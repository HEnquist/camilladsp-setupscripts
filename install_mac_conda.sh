#!/bin/sh
echo "--- Install python libraries"
conda install -y aiohttp websocket-client

echo "--- Download pycamilladsp"
curl -LJO https://github.com/HEnquist/pycamilladsp/archive/v0.5.0.zip -o pycamilladsp.zip
echo "--- Uncompress pycamilladsp"
unzip -o pycamilladsp-0.5.0.zip
echo "--- Install pycamilladsp"
pushd ./pycamilladsp-0.5.0
pip3 install .
popd

echo "--- Download pycamilladsp-plot"
curl -LJO https://github.com/HEnquist/pycamilladsp-plot/archive/v0.4.3.zip -o pycamilladsp-plot.zip
echo "--- Uncompress pycamilladsp-plot"
unzip -o pycamilladsp-plot-0.4.3.zip
echo "--- Install pycamilladsp-plot"
pushd ./pycamilladsp-plot-0.4.3
pip3 install .
popd

echo "--- Download Camillagui"
curl -LJO https://github.com/HEnquist/camillagui-backend/releases/download/v0.6.0/camillagui.zip -o camillagui.zip
echo "--- Uncompress Camillagui"
mkdir camillagui
unzip -o camillagui.zip -d camillagui

echo "--- Create folders for backend"
mkdir -p ~/camilladsp/configs
mkdir -p ~/camilladsp/coeffs

echo "--- Download CamillaDSP binary"
curl -LJO https://github.com/HEnquist/camilladsp/releases/download/v0.5.0-beta2/camilladsp-macos-amd64.tar.gz -o camilladsp.tar.gz
echo "--- Uncompress CamillaDSP binary"
tar -xvf camilladsp-macos-amd64.tar.gz