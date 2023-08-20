#!/bin/sh
SYSTEM=$(uname -s)
if [ "$SYSTEM" != "Darwin" ]
then
    echo "This script must run on macOS!"
    exit 1
fi

ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]
then
    ARCHIVE_NAME="camilladsp-macos-amd64.tar.gz"
elif [ "$ARCH" == "arm64" ]
then
    ARCHIVE_NAME="camilladsp-macos-aarch64.tar.gz"
else
  echo "Unsupported CPU type!"
  exit 1
fi

if [[ -z $CONDA_PREFIX ]]; then
    if [ -f ~/opt/anaconda3/etc/profile.d/conda.sh ]; then
        echo "Using user Anaconda"
        source ~/opt/anaconda3/etc/profile.d/conda.sh
    elif [ -f /opt/anaconda3/etc/profile.d/conda.sh ]; then
        echo "Using system Anaconda"
        source /opt/anaconda3/etc/profile.d/conda.sh
    elif [ -f ~/opt/miniconda3/etc/profile.d/conda.sh ]; then
        echo "Using user miniconda"
        source ~/opt/miniconda3/etc/profile.d/conda.sh
    else
        echo "No conda found"
        exit 1
    fi
else
    echo "Using conda from $CONDA_PREFIX"
    source $CONDA_PREFIX/etc/profile.d/conda.sh
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
curl -LJO https://github.com/HEnquist/camillagui-backend/releases/download/v2.0.0-alpha1/camillagui.zip
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
if [ -f $ARCHIVE_NAME ]; then
    echo "Deleting existing camilladsp archive"
    rm $ARCHIVE_NAME
fi
curl -LJO https://github.com/HEnquist/camilladsp/releases/download/v2.0.0-alpha1/$ARCHIVE_NAME
if [ $? -ne 0 ]; then
    echo "Failed to download camilladsp binary"
    exit 1
fi
echo "--- Uncompress CamillaDSP binary"
if [ -f camilladsp ]; then
    echo "Deleting existing camilladsp binary"
    rm camilladsp
fi
tar -xvf $ARCHIVE_NAME
if [ $? -ne 0 ]; then
    echo "Failed to uncompress binary"
    exit 1
fi
echo "All done!"

