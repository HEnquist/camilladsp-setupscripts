#!/bin/sh
conda install -y aiohttp
conda install -y websocket


curl https://github.com/HEnquist/pycamilladsp/archive/v0.5.0.zip -o pycamilladsp.zip
unzip -o pycamilladsp.zip
pushd ./pycamilladsp-0.5.0
pip3 install .
popd

curl https://github.com/HEnquist/pycamilladsp-plot/archive/v0.4.3.zip -o pycamilladspplot.zip
unzip -o pycamilladspplot.zip
pushd ./pycamilladsp-plot-0.4.3
pip3 install .
popd

curl https://github.com/HEnquist/camillagui-backend/releases/download/v0.6.0/camillagui.zip -o camillagui.zip
mkdir camillagui
unzip -o camillagui.zip -d camillagui

mkdir -p ~/camilladsp/configs
mkdir -p ~/camilladsp/coeffs

curl https://github.com/HEnquist/camilladsp/releases/download/v0.5.0-beta2/camilladsp-macos-amd64.tar.gz -o camilladsp.tar.gz
tar -xvf camilladsp.tar.gz