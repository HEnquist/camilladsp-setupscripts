#!/bin/sh
grep -q -F -x 'dtoverlay=dwc2' /boot/config.txt
if [ $? -ne 0 ]; then
  echo 'dtoverlay=dwc2' >> /boot/config.txt
fi

grep -q -F -x 'dwc2' /etc/modules-load.d/modules.conf
if [ $? -ne 0 ]; then
  echo 'dwc2' >> /etc/modules-load.d/modules.conf
fi

grep -q -F -x 'g_audio' /etc/modules-load.d/modules.conf
if [ $? -ne 0 ]; then
  echo 'g_audio' >> /etc/modules-load.d/modules.conf
fi

echo 'options g_audio c_chmask=3 c_srate=96000 c_ssize=4 p_chmask=3 p_srate=96000 p_ssize=4' > /etc/modprobe.d/g_audio.conf


apt-get install -y python3-numpy
apt-get install -y python3-matplotlib
apt-get install -y python3-aiohttp
apt-get install -y python3-websocket


wget -N -O pycamilladsp.zip https://github.com/HEnquist/pycamilladsp/archive/master.zip
unzip -o pycamilladsp.zip
pushd ./pycamilladsp-master
pip3 install .
popd

wget -N -O pycamilladspplot.zip https://github.com/HEnquist/pycamilladsp-plot/archive/master.zip
unzip -o pycamilladspplot.zip
pushd ./pycamilladsp-plot-master
pip3 install .
popd

wget -N https://github.com/HEnquist/camillagui-backend/releases/download/v0.2.0/camillagui.zip
mkdir camillagui
unzip -o camillagui.zip -d camillagui

wget -N https://github.com/HEnquist/camilladsp/releases/download/v0.3.2-beta3/camilladsp-linux-armv7.tar.gz
mkdir camilladsp




