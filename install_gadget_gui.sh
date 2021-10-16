#!/bin/sh
CAMILLADSP_NAME="camilladsp-linux-aarch64.tar.gz"
PYCAMILLADSP_VER="v0.6.0"
PYCAMILLADSPPLOT_VER="v0.6.2"
CAMILLAGUI_VER="v0.8.0"

echo "\n--- Configure boot config"
grep -q -F -x 'dtoverlay=dwc2' /boot/config.txt
if [ $? -ne 0 ]; then
  echo "Add dwc2 to boot config"
  sudo sh -c "echo 'dtoverlay=dwc2' >> /boot/config.txt"
fi

echo "\n--- Configure kernel modules"
grep -q -F -x 'dwc2' /etc/modules-load.d/modules.conf
if [ $? -ne 0 ]; then
  echo "Configure dwc2 module to autoload"
  sudo sh -c "echo 'dwc2' >> /etc/modules-load.d/modules.conf"
fi

grep -q -F -x 'g_audio' /etc/modules-load.d/modules.conf
if [ $? -ne 0 ]; then
  echo "Configure g_audio module to autoload"
  sudo sh -c "echo 'g_audio' >> /etc/modules-load.d/modules.conf"
fi

echo "Set g_audio module options"
sudo sh -c "echo 'options g_audio c_chmask=3 c_srate=96000 c_ssize=4 p_chmask=3 p_srate=96000 p_ssize=4' > /etc/modprobe.d/g_audio.conf"

echo "\n--- Install required python libraries"
sudo apt-get install -y python3-numpy python3-matplotlib python3-aiohttp python3-websocket

echo "\n--- Install pyCamillaDSP"
sudo pip3 install git+https://github.com/HEnquist/pycamilladsp.git@$PYCAMILLADSP_VER
echo "\n--- Install pyCamillaDSP-plot"
sudo pip3 install git+https://github.com/HEnquist/pycamilladsp-plot.git@$PYCAMILLADSPPLOT_VER


echo "\n--- Download Camillagui"
if [ -f camillagui.zip ]; then
    rm camillagui.zip
fi
wget -qN https://github.com/HEnquist/camillagui-backend/releases/download/$CAMILLAGUI_VER/camillagui.zip
if [ $? -ne 0 ]; then
    echo "Failed to download gui"
    exit 1
fi
echo "\n--- Uncompress Camillagui"
mkdir ~/camillagui
unzip -o camillagui.zip -d ~/camillagui
if [ $? -ne 0 ]; then
    echo "Failed to uncompress gui"
    exit 1
fi

echo "\n--- Create folders for backend"
mkdir -p ~/camilladsp/configs
if [ $? -ne 0 ]; then
    echo "Failed to create config dir"
    exit 1
fi
mkdir -p ~/camilladsp/coeffs
if [ $? -ne 0 ]; then
    echo "Failed to create coeffs dir"
    exit 1
fi

echo "\n--- Download CamillaDSP binary"
if [ -f $CAMILLADSP_NAME ]; then
    echo "Deleting existing camilladsp archive"
    rm $CAMILLADSP_NAME
fi
wget -qN https://github.com/HEnquist/camilladsp/releases/download/v0.6.3/$CAMILLADSP_NAME
if [ $? -ne 0 ]; then
    echo "Failed to download camilladsp binary"
    exit 1
fi
echo "\n--- Uncompress CamillaDSP binary"
if [ -f camilladsp ]; then
    echo "Deleting existing camilladsp binary"
    rm camilladsp
fi
tar -xvf $CAMILLADSP_NAME
if [ $? -ne 0 ]; then
    echo "Failed to uncompress binary"
    exit 1
fi

echo "\n--- Install CamillaDSP binary to /usr/local/bin"
sudo mv camilladsp /usr/local/bin/
if [ $? -ne 0 ]; then
    echo "Failed to install binary"
    exit 1
fi

echo "\n--- Copy and symlink default config"
cp gadget/gadget_default.yml ~/camilladsp/configs/
ln -s ~/camilladsp/configs/gadget_default.yml ~/camilladsp/active_config.yml

echo "\n--- Install CamillaDSP systemd service"
sudo cp gadget/camilladsp.service /etc/systemd/system/camilladsp.service
sudo systemctl enable camilladsp

echo "\n--- Install CamillaGUI systemd service"
sudo cp gadget/camillagui.service /etc/systemd/system/camillagui.service
sudo systemctl enable camillagui

echo "\nAll done!"





