# Automated setup scrips for CamillaGUI

Start by downloading the files in this repository. The easiest way is to download and uncompress [this .zip file](https://github.com/HEnquist/camilladsp-setupscripts/archive/refs/heads/master.zip).


## MacOS

The setup uses Anaconda. A new conda environment named "camillagui" will be created.

### Install
The script sets up the conda environment and the gui. It also download the matching version of CamillaDSP.

If the environment already exists, it will be updated with the new versions. If you for some reason want to keep the existing setup, then make a clone of the environment and give it a new name:
```sh
conda create --name camillagui_backup --clone  camillagui
```

Open a terminal, and navigate to the folder where the setup scripts are located. Run the install script:
```sh
./install_mac_intel.sh
or
./install_mac_arm.sh
```

Once the script finishes, the new environment needs to be activated. This step needs to be done every time a new terminal is opened.
```sh
conda activate camillagui
```

If needed, edit the gui default configuration (camillagui/config/camillagui.yml).

### Starting the gui

First start camilladsp if it's not already running.
 ```sh
./camilladsp your_config.yml -p1234 -w
```

Activate the conda environment.
```sh
conda activate camillagui
```

Change to the "camillagui" folder, and run the backend.
```sh
cd camillagui
python main.py
```

The backend should now be available at http://localhost:5000


