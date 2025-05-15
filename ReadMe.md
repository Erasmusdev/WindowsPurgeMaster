# PurgeMaster Cleanup Wizard

## Overview

The PurgeMaster Cleanup Wizard is a command-line utility designed to streamline and automate system cleanup tasks on Windows operating systems. It provides a user-friendly interface to perform various cleanup operations efficiently.

## Features

- **Automatic Cleanup**: Perform cleanup operations with minimal user interaction.
- **Selective Cleanup**: Choose specific categories like temporary files, prefetch files, recycle bin, etc., for cleanup.
- **Detailed Logging**: Logs cleanup activities to `logs.json` for tracking space cleared and timestamp.
- **Customization**: Modify the script to add or remove cleanup options as needed.

## Usage

1. **Run the Program**:
   - **Important**: Run PurgeMaster.bat as an administrator. Right-click on PurgeMaster.bat and select "Run as administrator" from the context menu.


2. **Select Options**:
   - Double-click on `PurgeMaster.bat` to launch the program.
   - Follow the on-screen prompts to select the cleanup options.

3. **Select Options**:
   - Choose an option from the menu (1-10).
   - For `Clean All` (Option 10), it will execute `Autocleaner.bat` located in the `addons` folder.

4. **Confirmation**:
   - For individual options, confirm by typing `Y` or `N`.
   - For `Clean All`, it automatically confirms with `Y`.

5. **View Logs**:
   - After each cleanup, view the detailed logs in `logs.json` to see space cleared and timestamps.

6. **Exit**:
   - Choose Option 11 to exit the program.

## Notes

- **Customization**: You can customize the script by editing `PurgeMaster.bat` to add more cleanup options or modify existing ones.
- **Error Handling**: If any errors occur during cleanup, they will be logged in `crashlog.txt` for troubleshooting.

## Support

For any issues or suggestions, please contact:
- Github: https://github.com/Erasmusdev/WindowsPurgeMaster



 ## ===============================
 ## Update V1.0.03
 ## ===============================

FIXES:

- Empty Recycle Bin not working

- Fixed some bugs in the auto clean option

CHANGES:

- The program now uses Powerschell by default instead of CMD this is done to fix some restrictions with CDM

 ## ===============================
 ## Update V1.0.04
 ## ===============================

ADDED:

- Delete System Error Memory Dump Files

- Delete Temporary Installation Files 

- Clean Temporary Internet Files

(THESE OPTIONS ARE NOT ADDED TO THE AUTO CLEAN OPTION THIS WILL BE ADDED AFTER ITS FULLY TESTED)

CHANGES:

- Changed the way log reports are done
- Did some more chasnges to the crash reports
- Changed the terminal color

 ## ===============================
 ## Update V1.0.06
 ## ===============================

FIXES:
Resolved PowerShell path issues causing installer downloads (Core Temp, Revo Uninstaller) to fail on some systems.

Updated installation addons to use the full PowerShell executable path (C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe) for reliable downloads.

Improved error handling for downloading and launching installers.

ADDED:
Basic implementations for options:

Clean Registry (Option 8)

Clean Browser Cache and History (Option 9)
(Note: These are basic placeholders and will be expanded in future updates.)

CHANGES:
Installer scripts (InstallCoreTempAddon.bat and RevoUninstaller.bat) now explicitly specify PowerShell path for better compatibility.

Refined batch script flow for better user experience and error feedback.

Minor fixes in cleanup confirmations to reduce unnecessary key presses.