@echo off

:: Initialization
mode con cols=60 lines=30
color 0E

:: Variables 
SET handleZip=.\libraries\handle.zip
SET handleUrl=https://download.sysinternals.com/files/Handle.zip
SET handleExe32=handle.exe
SET handleExe64=handle64.exe
SET handleExe64a=handle64a.exe

:: Folders
echo Checking libraries folder...
if not exist ".\libraries" (
    mkdir ".\libraries"
    echo ...libraries folder created.
) else (
    echo ...libraries folder exists.
)
echo.
timeout /t 2 /nobreak >nul


:SelectVersion
cls
echo =====================( Setup-Install )======================
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                      -= OS Selection =-
echo.
echo                       1. 32-bit - x32
echo                       2. 64-bit - x64
echo                       3. ARM64 - x64a
echo.
echo                       0. Exit Program
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p choice="Enter your choice (1-0): "
echo.

if "%choice%"=="1" (
    SET handleExeName=%handleExe32%
) else if "%choice%"=="2" (
    SET handleExeName=%handleExe64%
) else if "%choice%"=="3" (
    SET handleExeName=%handleExe64a%
) else if "%choice%"=="0" (
    echo Exiting...
    exit /b
) else (
    echo Invalid Choice Made.
    goto SelectVersion
)

:DownloadHandle
echo Checking for %handleExeName%...
if not exist ".\libraries\handles.exe" (
    echo ...Downloading %handleExeName% Package...
    powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%handleUrl%' -OutFile '%handleZip%'"
    echo ...Download Process Finished.
    echo.
    echo Unpacking handle.zip File...
    powershell -command "Expand-Archive -Path '%handleZip%' -DestinationPath '.\libraries' -Force"

    if exist ".\libraries\%handleExeName%" (
        echo ...Duplicating %handleExeName% File...
        copy ".\libraries\%handleExeName%" ".\libraries\handles.exe"
    ) else (
        echo ...Error: %handleExeName% not found after extraction.
        goto Cleanup
    )
    
    :Cleanup
    echo ...Cleaning Up Files...
    del ".\libraries\handle64.exe"
    del ".\libraries\handle64a.exe"
    del ".\libraries\handle.exe"
    del ".\libraries\Eula.txt"
	del ".\libraries\handle.zip"
    
	:: First Run Shh! 
    .\libraries\handles.exe -l -nobanner
    echo ...Handle Install Completed.
) else (
    echo ...Handle Already Present.
)
echo.

timeout /t 2 /nobreak >nul
echo Setup-Install Processes Completed!
echo.
pause
