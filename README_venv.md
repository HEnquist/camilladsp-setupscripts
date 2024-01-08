# Setup using venv

This uses the `venv` module that is part of the standard library in Python.
Python 3.8 or later is required.

## Install
The script creates a new virtual environment and downloads the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

If the environment already exists, it will be updated with the new versions.

Open a terminal, and navigate to the folder where the setup scripts are located.
Then run the install script.

On Linux or MacOS:
```sh
./full_install_venv.sh
```

On Windows (Command Prompt or PowerShell):
```sh
full_install_venv.bat
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

## Starting the gui

First [start camilladsp](README.md#start-camilladsp) if it's not already running.

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