# Automated setup scrips for CamillaGUI

Start by downloading the files in this repository. The easiest way is to download and uncompress [this .zip file](https://github.com/HEnquist/camilladsp-setupscripts/archive/refs/heads/master.zip).

## Choose Python package manager
Two different installer scripts are available,
one using the [conda](link) package manager and one using python [venv](link).

Both options are available on both Linux and MacOS,
and both have pros and cons.
Which one is the best choice comes down to personal preference.

### Conda

The conda script can use Anaconda, miniconda or miniforge. A new conda environment named "camillagui" will be created.

#### Install
The script sets up the conda environment and the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

If the environment already exists, it will be updated with the new versions. If you for some reason want to keep the existing setup, then make a clone of the environment and give it a new name:
```sh
conda create --name camillagui_backup --clone  camillagui
```

Open a terminal, and navigate to the folder where the setup scripts are located. Run the install script:
```sh
./install_conda.sh
```

Once the script finishes, the new environment needs to be activated. This step needs to be done every time a new terminal is opened.
```sh
conda activate camillagui
```

If needed, edit the gui default configuration (camillagui/config/camillagui.yml).

#### Starting the gui

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


### venv

This uses the venv module that is part of the standard library in Python. 

#### Install
The script creates a new virtual environment and downloads the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

If the environment already exists, it will be updated with the new versions.

Open a terminal, and navigate to the folder where the setup scripts are located. Run the install script:
```sh
./install_venv.sh
```


If needed, edit the gui default configuration (camillagui/config/camillagui.yml).

#### Starting the gui

First start camilladsp if it's not already running.
 ```sh
./camilladsp your_config.yml -p1234 -w
```

Change to the "camillagui" folder, and run the backend.
The virtual environment is activated by simply using
the python executable of the environment:
```sh
cd camillagui
path/to/venv/bin/python main.py
```

The backend should now be available at http://localhost:5000