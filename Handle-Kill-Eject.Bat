@echo off

:: Initialization
mode con cols=60 lines=30
color 0E

:: Variables
SET ScriptPath=main.ps1

:: Run Script
echo Launching PowerShell Script...
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%ScriptPath%"

:: Exit
echo.
echo PowerShell Script Exited!
pause
