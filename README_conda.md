# Set up using conda

The conda script can use Anaconda, miniconda or miniforge. A new conda environment named "camillagui" will be created.

## Install
Ensure that conda is installed. Any distribution will suffice.
- [Miniforge](https://github.com/conda-forge/miniforge) - Community-driven minimal installer.
- [Miniconda](https://docs.conda.io/projects/miniconda/en/latest/) - Minimal installer by Anaconda.
- [Anaconda](https://www.anaconda.com/download) - Full Anaconda distribution. Much larger than needed, only use if already installed.

The script sets up the conda environment and the gui. It also downloads the matching version of CamillaDSP, selecting the Arm or Intel version automatically.

If the environment already exists, it will be updated with the new versions. If you for some reason want to keep the existing setup, then make a clone of the environment and give it a new name:
```sh
conda create --name camillagui_backup --clone  camillagui
```

Open a terminal, and navigate to the folder where the setup scripts are located. Run the install script.

On Linux or MacOS:
```sh
./full_install_conda.sh
```

On Windows (Command Prompt or PowerShell):
```sh
full_install_venv.bat
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