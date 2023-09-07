#!/bin/sh
GUI_TAG="v2.0.0-alpha2"
CDSP_TAG="v2.0.0-alpha2"

SYSTEM=$(uname -s)
ARCH=$(uname -m)

if [ "$SYSTEM" == "Linux" ]
then
    if [ "$ARCH" == "x86_64" ]
    then
        ARCHIVE_NAME="camilladsp-linux-amd64.tar.gz"
    elif [ "$ARCH" == "aarch64" ]
    then
        ARCHIVE_NAME="camilladsp-linux-aarch64.tar.gz"
    else
        echo "Unsupported CPU type $ARCH!"
        exit 1
    fi
elif [ "$SYSTEM" == "Darwin" ]
then
    ARCH=$(uname -m)
    if [ "$ARCH" == "x86_64" ]
    then
        ARCHIVE_NAME="camilladsp-macos-amd64.tar.gz"
    elif [ "$ARCH" == "arm64" ]
    then
        ARCHIVE_NAME="camilladsp-macos-aarch64.tar.gz"
    else
        echo "Unsupported CPU type $ARCH!"
        exit 1
    fi
else
    echo "This script must run on Linux or MacOS!"
    exit 1
fi

if [[ -z $1 ]]; then
    INSTALL_ROOT="$HOME/camilladsp"
else
    INSTALL_ROOT=$1
fi

if [[ -z $CONDA_PREFIX ]]; then
    echo "CONDA_PREFIX environment variable is not set, looking for conda in standard locations"
    if [ -f ~/opt/anaconda3/etc/profile.d/conda.sh ]; then
        echo "Using user Anaconda at ~/opt/anaconda3"
        source ~/opt/anaconda3/etc/profile.d/conda.sh
    elif [ -f ~/anaconda3/etc/profile.d/conda.sh ]; then
        echo "Using user Anaconda at ~/anaconda3"
        source ~/anaconda3/etc/profile.d/conda.sh
    elif [ -f /opt/anaconda3/etc/profile.d/conda.sh ]; then
        echo "Using system Anaconda at /opt/anaconda3"
        source /opt/anaconda3/etc/profile.d/conda.sh
    elif [ -f ~/opt/miniconda3/etc/profile.d/conda.sh ]; then
        echo "Using user miniconda at ~/opt/miniconda3"
        source ~/opt/miniconda3/etc/profile.d/conda.sh
    elif [ -f ~/miniconda3/etc/profile.d/conda.sh ]; then
        echo "Using user miniconda at ~/miniconda3"
        source ~/miniconda3/etc/profile.d/conda.sh
    elif [ -f ~/opt/miniforge3/etc/profile.d/conda.sh ]; then
        echo "Using user miniforge at ~/opt/miniforge3"
        source ~/opt/miniforge3/etc/profile.d/conda.sh
    elif [ -f ~/miniforge3/etc/profile.d/conda.sh ]; then
        echo "Using user miniforge at ~/miniforge3"
        source ~/miniforge3/etc/profile.d/conda.sh
    else
        echo "No conda found!"
        exit 1
    fi
else
    echo "Using conda from $CONDA_PREFIX"
    source $CONDA_PREFIX/etc/profile.d/conda.sh
fi

conda activate camillagui
if [ $? -eq 0 ]; then
    echo "Updating existing environment"
    conda env update -f cdsp_conda.yml --prune
else
    echo "Creating new environment"
    conda env create -f cdsp_conda.yml
    conda activate camillagui
fi

echo "--- Create folders"
mkdir -p $INSTALL_ROOT/configs
if [ $? -ne 0 ]; then
    echo "Failed to create config dir"
    exit 1
fi
mkdir -p $INSTALL_ROOT/coeffs
if [ $? -ne 0 ]; then
    echo "Failed to create coeffs dir"
    exit 1
fi
mkdir -p $INSTALL_ROOT/bin
if [ $? -ne 0 ]; then
    echo "Failed to create bin dir"
    exit 1
fi

echo "--- Download Camillagui"
if [ -f camillagui.zip ]; then
    rm camillagui.zip
fi
curl -LJO https://github.com/HEnquist/camillagui-backend/releases/download/$GUI_TAG/camillagui.zip
if [ $? -ne 0 ]; then
    echo "Failed to download gui"
    exit 1
fi
echo "--- Uncompress Camillagui to $INSTALL_ROOT/gui"
mkdir camillagui
unzip -o camillagui.zip -d "$INSTALL_ROOT/gui"
if [ $? -ne 0 ]; then
    echo "Failed to uncompress gui"
    exit 1
fi

echo "--- Download CamillaDSP binary"
if [ -f $ARCHIVE_NAME ]; then
    echo "Deleting existing camilladsp archive"
    rm $ARCHIVE_NAME
fi
curl -LJO https://github.com/HEnquist/camilladsp/releases/download/$CDSP_TAG/$ARCHIVE_NAME
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
echo "--- Moving CamillaDSP binary to $INSTALL_ROOT/bin/"
mv camilladsp "$INSTALL_ROOT/bin/"
if [ $? -ne 0 ]; then
    echo "Failed to move binary"
    exit 1
fi
echo "All done!"

