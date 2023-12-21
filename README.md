# Handle-Kill-Eject
Status: Working
<br> Planned updates for the next release...
- Enhancement of UI the main script.
- Testing for process handling and drive ejection.

## Description
Handle-Kill-Eject is a comprehensive toolset comprising a PowerShell script and accompanying Batch files, designed to manage system processes that are accessing external or internal drives. This utility is particularly useful for resolving drive ejection issues on Windows systems. It is compatible with a variety of Windows versions, ensuring wide usability.

## Features:
- **Drive Process Management**: Identifies and lists processes accessing selected drives.
- **Interactive User Interface**: Features user-friendly interactive menus in both PowerShell and Batch scripts, making it easy to navigate and select options.
- **Multiple System Architecture Support**: Includes setup options for different system architectures (32-bit, 64-bit, ARM64).
- **Safe and Forced Drive Ejection**: Offers both safe ejection and forced ejection options for drives.
- **Automated Setup and Cleanup**: Comes with a `Setup-Install.Bat` script that automates the setup process, including downloading necessary files, and cleans up after installation.
- **Simplified Execution**: The `Handle-Kill-Eject.Bat` file facilitates easy launching of the main PowerShell script.

## Usage
1. Place Handle-Kill-Eject in its own folder and run `Setup-Install.Bat` to set up necessary files and configurations.
2. Once setup is complete, execute `Handle-Kill-Eject.Bat` to launch the main PowerShell script.
3. In the PowerShell script interface, select the drive you want to manage.
4. The script will display processes accessing the selected drive. Choose to kill processes, safely eject the drive, or force eject if necessary.
5. Follow on-screen instructions for any further actions.

## Requirements
- Windows 7/8.1/10/11
- PowerShell 5-7
- Internet connection for the initial setup
- Compatibility with various system architectures (x86, x64, ARM64)

## Note
Handle-Kill-Eject was developed because windows refused to eject my media, forced eject could corrupt it, unfortunately it did not detect what was accessing it, it was a waste of time, but, the problem is probably not with the program, but, windows itself or my motherboard, and its nice to finally have some form of tool for this, maybe it will work next time...

## Disclaimer
This program is provided "as is" without warranties or support. Users are responsible for the content they, download and use, as well as, any resulting damage to, hardware or sanity.
