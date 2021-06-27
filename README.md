# Automated setup scrips for CamillaGUI

## MacOS

The setup uses Anaconda. A new conda environment named "camillagui" will be created.

### Install
The script sets up the gui, and downloads the matching version of Camilladsp.

Clone this repository. Then run the install script:
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


