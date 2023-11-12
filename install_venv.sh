#!/bin/sh
GUI_TAG="v2.0.0"
CDSP_TAG="v2.0.0"

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
VENV_PATH="$INSTALL_ROOT/camillagui_venv"

echo "Creating venv at $VENV_PATH"
python -m venv "$VENV_PATH"
if [ $? -eq 0 ]; then
    echo "Environment created"
else
    echo "Failed to create environment"
    exit 1
fi

echo "Installing Python libraries"
$VENV_PATH/bin/python -m pip install -r requirements.txt
if [ $? -eq 0 ]; then
    echo "Libraries installed"
else
    echo "Failed to install libraries"
    exit 1
fi

echo "--- Create folders"
mkdir -p "$INSTALL_ROOT/configs"
if [ $? -ne 0 ]; then
    echo "Failed to create config dir"
    exit 1
fi
mkdir -p "$INSTALL_ROOT/coeffs"
if [ $? -ne 0 ]; then
    echo "Failed to create coeffs dir"
    exit 1
fi
mkdir -p "$INSTALL_ROOT/bin"
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
echo "--- Moving CamillaDSP binary to $INSTALL_ROOT/bin"
mv camilladsp "$INSTALL_ROOT/bin"
if [ $? -ne 0 ]; then
    echo "Failed to move binary"
    exit 1
fi
echo "All done!"

