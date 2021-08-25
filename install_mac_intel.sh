#!/bin/sh
source ~/opt/anaconda3/etc/profile.d/conda.sh

conda env create -f conda_macos.yml

conda activate camillagui

echo "--- Download Camillagui"
curl -LJO https://github.com/HEnquist/camillagui-backend/releases/download/v0.8.0/camillagui.zip -o camillagui.zip
echo "--- Uncompress Camillagui"
mkdir camillagui
unzip -o camillagui.zip -d camillagui

echo "--- Create folders for backend"
mkdir -p ~/camilladsp/configs
mkdir -p ~/camilladsp/coeffs

echo "--- Download CamillaDSP binary"
curl -LJO https://github.com/HEnquist/camilladsp/releases/download/v0.6.1/camilladsp-macos-amd64.tar.gz -o camilladsp.tar.gz
echo "--- Uncompress CamillaDSP binary"
tar -xvf camilladsp-macos-amd64.tar.gz