@echo off
setlocal EnableDelayedExpansion

set "GUI_TAG=v2.0.0"
set "CDSP_TAG=v2.0.0"

set "ARCHIVE_NAME=camilladsp-windows-amd64.zip"

if "%~1"=="" (
    set "INSTALL_ROOT=%USERPROFILE%\camilladsp"
) else (
    set "INSTALL_ROOT=%~1"
)

if not "%CONDA_PREFIX%"=="" (
    echo Using conda from %CONDA_PREFIX%
    set "CONDA_ROOT=%CONDA_PREFIX%"
) else (
    echo CONDA_PREFIX environment variable is not set, looking for conda in standard locations
    if exist %USERPROFILE%\miniforge3\Scripts\activate.bat (
        set "CONDA_ROOT=%USERPROFILE%\miniforge3"     
    ) else if exist %USERPROFILE%\miniconda3\Scripts\activate.bat (
        set "CONDA_ROOT=%USERPROFILE%\miniconda3"
    ) else if exist %USERPROFILE%\Anaconda3\Scripts\activate.bat (
        set "CONDA_ROOT=%USERPROFILE%\Anaconda3"
    ) else if exist %ProgramData%\miniforge3\Scripts\activate.bat (
        set "CONDA_ROOT=%ProgramData%\miniforge3"  
    ) else if exist %ProgramData%\miniconda3\Scripts\activate.bat (
        set "CONDA_ROOT=%ProgramData%\miniconda3" 
    ) else if exist %ProgramData%\Anaconda3\Scripts\activate.bat (
        set "CONDA_ROOT=%ProgramData%\Anaconda3"     
    ) else (
        echo No conda found!
        exit /b 1
    )
            
)
echo Using conda found at !CONDA_ROOT!

call "%CONDA_ROOT%\Scripts\activate.bat"
call "%CONDA_ROOT%\Scripts\activate.bat" camillagui
if !errorlevel! equ 0 (
    echo Updating existing environment
    call conda env update -f cdsp_conda.yml --prune
) else (
    echo Creating new environment
    call conda env create -f cdsp_conda.yml
    call activate camillagui
)

echo --- Create folders
if not exist "%INSTALL_ROOT%\configs" mkdir "%INSTALL_ROOT%\configs"
if not exist "%INSTALL_ROOT%\coeffs" mkdir "%INSTALL_ROOT%\coeffs"
if not exist "%INSTALL_ROOT%\bin" mkdir "%INSTALL_ROOT%\bin"
if not exist "%INSTALL_ROOT%\gui" mkdir "%INSTALL_ROOT%\gui"

echo --- Download Camillagui
if exist camillagui.zip (
    del camillagui.zip
)
powershell Invoke-WebRequest https://github.com/HEnquist/camillagui-backend/releases/download/%GUI_TAG%/camillagui.zip -OutFile .\camillagui.zip
if !errorlevel! neq 0 (
    echo Failed to download gui
    exit /b 1
)

echo --- Uncompress Camillagui to %INSTALL_ROOT%\gui
powershell Expand-Archive camillagui.zip -DestinationPath "%INSTALL_ROOT%\gui" -Force
if !errorlevel! neq 0 (
    echo Failed to uncompress gui
    exit /b 1
)

echo --- Download CamillaDSP binary
if exist %ARCHIVE_NAME% (
    echo Deleting existing camilladsp archive
    del %ARCHIVE_NAME%
)
powershell Invoke-WebRequest https://github.com/HEnquist/camilladsp/releases/download/%CDSP_TAG%/%ARCHIVE_NAME% -OutFile .\%ARCHIVE_NAME%
if !errorlevel! neq 0 (
    echo Failed to download camilladsp binary
    exit /b 1
)

echo --- Uncompress CamillaDSP binary
powershell Expand-Archive "%ARCHIVE_NAME%" -DestinationPath "%INSTALL_ROOT%\bin" -Force
if !errorlevel! neq 0 (
    echo Failed to uncompress binary
    exit /b 1
)

echo All done!

endlocal
