# Start
Read-Host "Hi! `nPress any key to continue to add specified Solved Activity folders to the target .gitignore by the specified Directory and Module Name"

# Browse for initial location of .gitignore file
$initialLocation = Read-Host -Prompt "Enter initial location of .gitignore file. 
    `nMust be the root directory of the repository, which contains the .git folder. 
    `nPlease format input so the path looks like this:
    `n `"`C:\Users\UserName\DIRECTORY\CONTAINING_FOLDER\HOW_DEEP_IS_IT_THO\fullstack-live-main`"` "
while (-not (Test-Path $initialLocation -PathType Container)) {
    Write-Host "Invalid path, please try again."
    $initialLocation = Read-Host -Prompt "Enter initial location of .gitignore file"
}

# Get folder name to ignore
$ignorePath = ""
do {
    $folderName = Read-Host "Enter folder name to ignore (e.g. '03-JavaScript')"
    $ignorePath = "01-Class-Content/$folderName/01-Activities/"
    if (-not (Test-Path -Path "$initialLocation/$ignorePath" -PathType Container)) {
        Write-Host "Invalid folder name, please try again."
    }
} while (-not (Test-Path -Path "$initialLocation/$ignorePath" -PathType Container))


$ignorePath = "01-Class-Content/$folderName/01-Activities/"

# Get all activity names
$activityNames = Get-ChildItem -Path "$initialLocation/$ignorePath" -Directory -Name | Sort-Object | Where-Object { $_ -match "^([0-9]{2})-" }

# Validate activity start and end numbers
do {
    # Use Read-Host with -Prompt parameter for clarity
    $activityStart = Read-Host "Enter activity start number (e.g. '02'; first activity in gitignore is $($activityNames[0]))"
    $activityEnd = Read-Host "Enter activity end number (e.g. '08'; last activity in gitignore is $($activityNames[-1]))"
         
    # Convert input to numbers
    $startNumber = [int]$activityStart
    $endNumber = [int]$activityEnd

    # Check if input is valid
    if ($startNumber -lt 1 -or $startNumber -gt 99 -or $endNumber -lt 1 -or $endNumber -gt 99 -or $startNumber -gt $endNumber) {
        Write-Host "Invalid input. Please enter activity start and end numbers between 1-99, with start number smaller than end number."
    }
} until ($startNumber -ge 1 -and $startNumber -le 99 -and $endNumber -ge 1 -and $endNumber -le 99 -and $startNumber -le $endNumber)

# Get activity names to ignore
$ignoreActivityNames = @()
foreach($activity in $activityNames)
{
    $activityNumber = [int]($activity -split '-')[0]
    if($activityNumber -ge $startNumber -and $activityNumber -le $endNumber)
    {
        $ignoreActivityNames += $activity
    }
}

# Build ignore string
$ignoreStrings = @()
foreach($activity in $ignoreActivityNames)
{
    $solvedPath = Join-Path $initialLocation ($ignorePath + $activity + "\Solved")
    if(Test-Path $solvedPath -PathType Container) {
        $ignoreStrings += "`n" + ($ignorePath + $activity + "/Solved")
    }
    else {
        Write-Host "'$solvedPath' does not exist, skipping..."
    }
}

# Write to .gitignore
$gitignorePath = Join-Path $initialLocation ".gitignore"
if (!(Test-Path $gitignorePath)) {
    New-Item $gitignorePath -ItemType File > $null
}
$comment = "`n# ignored by powershell, with love, SJROHRXD`n"
$existingContent = Get-Content $gitignorePath


if ($existingContent -notcontains $comment.Trim()) {
    $existingContent += $comment
}

foreach ($ignoreString in $ignoreStrings) {
    $trimmedIgnoreString = $ignoreString.Trim()
    if ($existingContent -notcontains $trimmedIgnoreString) {
        $existingContent += $ignoreString
        Write-Host "Added '$ignoreString' to .gitignore file."
    } else {
        Write-Host "'.gitignore' file already contains '$ignoreString', skipping..."
    }
}

$existingContent | Set-Content $gitignorePath

