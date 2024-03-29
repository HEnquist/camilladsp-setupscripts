# Automated setup scrips for CamillaGUI

## Where are the scripts?
Go to the latest version under "Releases". The scripts are added under "Assets".

Download the script that suits your system.

For linux and MacOS, the script needs to be made executable before it's possible to run it.
Use `chmod` in the terminal, example:
```sh
chmod a+x full_install_venv.sh
```

It is also possible to execure the script directly:
```sh
curl -L { insert download link copied from Assets } | sh
```
Right-click the script under Assets and choose to copy the link.

Example, run the script from release 2.1.0:
```sh
curl -L https://github.com/HEnquist/camilladsp-setupscripts/releases/download/v2.1.0/full_install_venv.sh | sh
```

Or use the permanent link to the latest release:
```sh
curl -L https://github.com/HEnquist/camilladsp-setupscripts/releases/latest/download/full_install_venv.sh | sh
```

This repository itself does not contain any ready-to-use scripts.
Instead it contains templates used to generate them.
This process runs automatically when a release is created,
and the generated scripts are attached to the release.


## Choose Python package manager
Three different installer scripts are available,
one using the `conda` package manager, one using python `venv`, and one using `poetry`.

All options are available on Linux, Windows and MacOS,
and all are suitable for running the CamillaDSP GUI.

Reasons to choose conda:
- conda is already installed.
- The system does not have Python 3.8 or later installed.

Reasons to choose venv:
- Python 3.8 or newer is already installed.
- Minimizing disk space usage is important.

Reasons to choose poetry:
- Convenient, the environment is created automatically.

After making a choice, follow the instructions in the separate READMEs.
- [conda](README_conda.md)
- [venv](README_venv.md)
- [poetry](README_poetry.md)


## Start CamillaDSP
These are the recommended commands to start CamillaDSP for use with the GUI.
This uses the statefile to store the path to the active config file.
Adjust the path the the config file if needed.

Note that it is also possible to specify a config file directly when starting CamillaDSP.
This prevents permanently switching config file via the gui.

Linux and MacOS:
```sh
~/camilladsp/bin/camilladsp -p1234 -w -s ~/camilladsp/statefile.yml
```

Windows PowerShell:
```sh
~\camilladsp\bin\camilladsp.exe -p1234 -w -s ~\camilladsp\statefile.yml
```

Windows Command Prompt:
```sh
%userprofile%\camilladsp\bin\camilladsp.exe -p1234 -w -s %userprofile%\camilladsp\statefile.yml
```

# Setup of USB gadget mode
**NOTE** This is currently not updated for the latest versions of CamillaDSP and Raspberry Pi OS.

The `install_gadget_gui.sh` script installs camilladsp with the GUI,
as well as configures the USB gadget mode on a Raspberry Pi.

# Development: render the templates
This repository contains jinja2 templates used to create automated setup scripts for CamillaGUI.
The templates are stored in `templates/`.

To render the templates, run the Python script `build_release.py`.
When rendering, the versions of the various components are taken from the file `versions.yml`.