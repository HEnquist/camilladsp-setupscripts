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

set "VENV_PATH=%INSTALL_ROOT%\camillagui_venv"

echo Creating venv at %VENV_PATH%
python -m venv "%VENV_PATH%"
if !errorlevel!==0 (
    echo Environment created
) else (
    echo Failed to create environment
    exit /b 1
)

echo Installing Python libraries
"%VENV_PATH%\Scripts\python.exe" -m pip install -r requirements.txt
if !errorlevel!==0 (
    echo Libraries installed
) else (
    echo Failed to install libraries
    exit /b 1
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
