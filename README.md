# Automated setup scrips for CamillaGUI

Start by downloading the files in this repository. The easiest way is to download and uncompress [this .zip file](https://github.com/HEnquist/camilladsp-setupscripts/archive/refs/heads/master.zip).

## Choose Python package manager
Two different installer scripts are available,
one using the [`conda`](#conda) package manager and one using python [`venv`](#venv).

Both options are available on Linux, Windows and MacOS,
and both are suitable for running the CamillaDSP GUI.

Reasons to choose conda:
- conda is already installed.
- The system does not have Python 3.8 or later installed.

Reasons to choose venv:
- Python 3.8 or newer is already installed.
- Minimizing disk space usage is important.

### Conda

The conda script can use Anaconda, miniconda or miniforge. A new conda environment named "camillagui" will be created.

#### Install
Ensure that conda is installed. Any distribution will suffice.
- [Miniforge](https://github.com/conda-forge/miniforge) - Community-driven minimal installer.
- [Miniconda](https://docs.conda.io/projects/miniconda/en/latest/) - Minimal installer by Anaconda.
- [Anaconda](https://www.anaconda.com/download) - Full Anaconda distribution. Much larger than needed, only use if already installed.

The script sets up the conda environment and the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

If the environment already exists, it will be updated with the new versions. If you for some reason want to keep the existing setup, then make a clone of the environment and give it a new name:
```sh
conda create --name camillagui_backup --clone  camillagui
```

Open a terminal, and navigate to the folder where the setup scripts are located. Run the install script:
```sh
./install_conda.sh
```

The script creates the directory `camilladsp` in the user home directory,
with the following subdirectories:
- `bin`: The CamillaDSP executable is placed here
- `coeffs`: For FIR coefficient files
- `configs`: For config files
- `gui`: The gui

Check the gui default configuration (camilladsp/gui/config/camillagui.yml)
and edit as needed.


#### Starting the gui

First [start camilladsp](#start-camilladsp) if it's not already running.

Change to the "camilladsp/gui" folder, and run the backend. 

Linux or MacOS. Also Windows using the Miniforge/Miniconda/Anaconda PowerShell:
```sh
cd ~/camilladsp/gui
conda run -n camillagui python main.py
```

Windows Command Prompt (use the Miniforge/Miniconda/Anaconda Prompt):
```sh
cd %userprofile%\camilladsp\gui
conda run -n camillagui python main.py
```

The first part, `conda run -n {env} {commmand}` makes conda run `{command}` in the environment `{env}`.

The gui should now be available at http://localhost:5000

Note that it is also possible to manually activate the environment before starting the gui:
```sh
conda activate camillagui
cd ~/camilladsp/gui
python main.py
```


### venv

This uses the `venv` module that is part of the standard library in Python.
Python 3.8 or later is required.

#### Install
The script creates a new virtual environment and downloads the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

If the environment already exists, it will be updated with the new versions.

Open a terminal, and navigate to the folder where the setup scripts are located.
Then run the install script.

On Linux or MacOS:
```sh
./install_venv.sh
```

On Windows (Command Prompt or PowerShell):
```sh
install_venv.bat
```

The script creates the directory `camilladsp` in the user home directory,
with the following subdirectories:
- `bin`: The CamillaDSP executable is placed here
- `camillagui_venv`: The Python virtual environment
- `coeffs`: For FIR coefficient files
- `configs`: For config files
- `gui`: The gui

Check the gui default configuration (camilladsp/gui/config/camillagui.yml)
and edit as needed.

#### Starting the gui

First [start camilladsp](#start-camilladsp) if it's not already running.

Change to the "camilladsp/gui" folder, and run the backend.
The virtual environment is activated by simply using
the python executable of the environment.

Linux or MacOS:
```sh
cd ~/camilladsp/gui
~/camilladsp/camillagui_venv/bin/python main.py
```

Windows PowerShell:
```sh
cd ~\camilladsp\gui
~\camilladsp\camillagui_venv\Scripts\python.exe main.py
```

Windows Command Prompt:
```sh
cd %userprofile%\camilladsp\gui
%userprofile%\camilladsp\camillagui_venv\Scripts\python.exe main.py
```

The gui should now be available at http://localhost:5005


## Start CamillaDSP
These are the recommended commands to start CamillaDSP for use with the GUI. 

TODO add statefile!

Linux and MacOS:
```sh
~/camilladsp/bin/camilladsp ~/camilladsp/configs/your_config.yml -p1234 -w
```

Windows PowerShell:
```sh
~\camilladsp\bin\camilladsp.exe ~\camilladsp\configs\your_config.yml -p1234 -w
```

Windows Command Prompt:
```sh
%userprofile%\camilladsp\bin\camilladsp.exe %userprofile%\camilladsp\configs\your_config.yml -p1234 -w
```