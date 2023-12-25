# Setup using poetry

This uses the `poetry` management tool, which needs to be installed.
Python 3.12 or later is required.

## Install
The script creates a new environment and downloads the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

Open a terminal, and navigate to the folder where the setup scripts are located.
Then run the install script.

On Linux or MacOS:
```sh
./full_install_poetry.sh
```

TODO!
On Windows (Command Prompt or PowerShell):
```sh
full_install_poetry.bat
```

The script creates the directory `camilladsp` in the user home directory,
with the following subdirectories:
- `bin`: The CamillaDSP executable is placed here
- `coeffs`: For FIR coefficient files
- `configs`: For config files
- `gui`: The gui

Check the gui default configuration (camilladsp/gui/config/camillagui.yml)
and edit as needed.

## Starting the gui

First [start camilladsp](README.md#start-camilladsp) if it's not already running.

Change to the "camilladsp/gui" folder, and run the backend.

Linux or MacOS:
```sh
cd ~/camilladsp/gui
poetry run python main.py
```

Windows PowerShell:
```sh
cd ~\camilladsp\gui
poetry run python main.py
```

Windows Command Prompt:
```sh
cd %userprofile%\camilladsp\gui
poetry run python main.py
```

The gui should now be available at http://localhost:5005