#!/bin/sh
if [ -f ~/opt/anaconda3/etc/profile.d/conda.sh ]; then
    echo "Using user conda"
    source ~/opt/anaconda3/etc/profile.d/conda.sh
elif [ -f /opt/anaconda3/etc/profile.d/conda.sh ]; then
    echo "Using system conda"
    source /opt/anaconda3/etc/profile.d/conda.sh
else
    echo "No conda found"
    exit 1
fi

conda activate camillagui
if [ $? -eq 0 ]; then
    echo "Updating existing environment"
    conda env update -f conda_macos.yml --prune
else
    echo "Creating new environment"
    conda env create -f conda_macos.yml
    conda activate camillagui
fi

echo "--- Download Camillagui"
if [ -f camillagui.zip ]; then
    rm camillagui.zip
fi
curl -LJO https://github.com/HEnquist/camillagui-backend/releases/download/v0.8.0/camillagui.zip
if [ $? -ne 0 ]; then
    echo "Failed to download gui"
    exit 1
fi
echo "--- Uncompress Camillagui"
mkdir camillagui
unzip -o camillagui.zip -d camillagui
if [ $? -ne 0 ]; then
    echo "Failed to uncompress gui"
    exit 1
fi

echo "--- Create folders for backend"
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

echo "--- Download CamillaDSP binary"
if [ -f camilladsp-macos-amd64.tar.gz ]; then
    echo "Deleting existing camilladsp archive"
    rm camilladsp-macos-amd64.tar.gz
fi
curl -LJO https://github.com/HEnquist/camilladsp/releases/download/v0.6.1/camilladsp-macos-amd64.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download camilladsp binary"
    exit 1
fi
echo "--- Uncompress CamillaDSP binary"
if [ -f camilladsp ]; then
    echo "Deleting existing camilladsp binary"
    rm camilladsp
fi
tar -xvf camilladsp-macos-amd64.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to uncompress binary"
    exit 1
fi
echo "All done!"

