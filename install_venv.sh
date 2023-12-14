#!/bin/sh
GUI_TAG="v2.0.0"
CDSP_TAG="v2.0.0"

SYSTEM=$(uname -s)
ARCH=$(uname -m)

if [ "$SYSTEM" = "Linux" ]
then
    if [ "$ARCH" = "x86_64" ]
    then
        LONG_BIT=$(getconf LONG_BIT)
        if [ "$LONG_BIT" = "32" ]
        then
            echo "Running on Linux, amd64, with 32-bit userland"
            echo "Error, no binary available for this combination!"
            exit 1
        else
            echo "Running on Linux, amd64"
            ARCHIVE_NAME="camilladsp-linux-amd64.tar.gz"
        fi
    elif [ "$ARCH" = "aarch64" ]
    then
        LONG_BIT=$(getconf LONG_BIT)
        if [ "$LONG_BIT" = "32" ]
        then
            echo "Running on Linux, aarch64, with 32-bit userland"
            ARCHIVE_NAME="camilladsp-linux-armv7.tar.gz"
        else
            echo "Running on Linux, aarch64"
            ARCHIVE_NAME="camilladsp-linux-aarch64.tar.gz"
        fi
    elif [ "$ARCH" = "armv7l" ]
    then
        echo "Running on Linux, armv7l"
        ARCHIVE_NAME="camilladsp-linux-armv7.tar.gz"
    elif [ "$ARCH" = "armv6l" ]
    then
        echo "Running on Linux, armv6l"
        ARCHIVE_NAME="camilladsp-linux-armv6.tar.gz"
    else
        echo "There is no prebuilt binary available for CPU type $ARCH! on Linux!"
        exit 1
    fi
elif [ "$SYSTEM" = "Darwin" ]
then
    ARCH=$(uname -m)
    if [ "$ARCH" = "x86_64" ]
    then
        echo "Running on MacOS, amd64"
        ARCHIVE_NAME="camilladsp-macos-amd64.tar.gz"
    elif [ "$ARCH" == "arm64" ]
    then
        echo "Running on MacOS, aarch64"
        ARCHIVE_NAME="camilladsp-macos-aarch64.tar.gz"
    else
        echo "There is no prebuilt binary available for CPU type $ARCH! on MacOS!"
        exit 1
    fi
else
    echo "This script must run on Linux or MacOS!"
    exit 1
fi

if [ -z $1 ]; then
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
mkdir -p "$INSTALL_ROOT/gui"
if [ $? -ne 0 ]; then
    echo "Failed to create gui dir"
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
if command -v unar &> /dev/null
then
    unar -f camillagui.zip -o "$INSTALL_ROOT/gui"
    if [ $? -ne 0 ]; then
        echo "Failed to uncompress gui"
        exit 1
    fi
elif command -v unzip &> /dev/null
then
    unzip -o camillagui.zip -d "$INSTALL_ROOT/gui"
    if [ $? -ne 0 ]; then
        echo "Failed to uncompress gui"
        exit 1
    fi
else
    echo "Error, no tool for unpacking .zip found, install either unzip or unar and try again"
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

