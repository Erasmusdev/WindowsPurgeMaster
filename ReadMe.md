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
- Github: https://github.com/Flockers-Design/WindowsPurgeMaster/issues



 ## ===============================
 ## Update V1.0.03
 ## ===============================

FIXES:

- Empty Recycle Bin not working

- Fixed some bugs in the auto clean option

CHANGES:

- The program now uses Powerschell by default instead of CMD this is done to fix some restrictions with CDM
