# GitIgnore Solved Auto Script

This PowerShell script prompts the user for information about which Solved folders to ignore in a specified .gitignore file. The script adds specified Solved folders to the target .gitignore by the specified Directory and Module Name. The steps in the script are as follows:

1. The script displays a prompt to the user to press any key to continue and then prompts the user to enter the initial location of the .gitignore file.
2. The script validates the user input and ensures that the specified repository is a valid container path.
3. The script prompts the user to enter the folder name to ignore and validates the user input to ensure that the folder exists in the specified location.
4. The script retrieves all activity names from the specified location and prompts the user to input an activity start number and end number. It validates the inputs.
5. The script retrieves the activity names to ignore; activity folders that do not have "Solved" folders within them are skipped.
6. The script builds an ignore string for each Solved folder in the specified activity names to ignore.
7. The script writes the ignore strings to the .gitignore file and notifies the user of any added or skipped entries.

To Use:

1. Extract the downloaded ZIP file to a location on your computer.
2. Open PowerShell on your computer and navigate to the directory where the extracted script is located using the "cd" command.
3. Run the script by typing its filename (e.g., ".\theBestScript.ps1") and pressing Enter.
4. Follow the prompts in the script to enter the necessary information.
5. Always double-check the .gitignore file upon completion!
6. Report bugs to [me](https://github.com/SJROHRXD)!

Depending on security settings, you may need to change the execution policy for PowerShell scripts to run the script. Run PowerShell as an administrator and typing the following command:

    Set-ExecutionPolicy RemoteSigned.
