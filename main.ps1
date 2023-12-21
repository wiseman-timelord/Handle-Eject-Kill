# Initialization
$Host.UI.RawUI.ForegroundColor = 'Yellow'
Write-Host "...Handle-Eject-Kill Started."
Start-Sleep -Seconds 2

# Path to handles.exe
$handleExePath = ".\libraries\handles.exe"

# Check if handles.exe is present
if (-not (Test-Path $handleExePath)) {
    Write-Host "handles.exe Not Found..."
    Write-Host "...Run Setup-Install.Bat First!"
    exit
}

function PrintHeader {
	Clear-Host
	Write-Host "`n===================( " -NoNewline -ForegroundColor Blue
    Write-Host "Handle-Eject-Kill" -NoNewline -ForegroundColor Yellow
    Write-Host " )====================" -ForegroundColor Blue
}


function DisplayMainMenu {
    PrintHeader
	$drives = Get-PSDrive -PSProvider FileSystem
    Write-Host "`n`n`n`n`n`n                     Drive Selection`n"
    for ($i = 0; $i -lt [Math]::Min($drives.Count, 9); $i++) {
        Write-Host "                        $($i + 1)) $($drives[$i].Name) - $($drives[$i].Root)"
    }
    Write-Host "`n                     0) Exit program"
}

function GetDriveSelection {
    $drives = Get-PSDrive -PSProvider FileSystem
    $selection = $null
    while ($null -eq $selection) {
        $input = Read-Host "`n`n`n`n`n`n`nEnter your choice"
        if ($input -match '^[0-9]+$' -and $input -ge 0 -and $input -le $drives.Count) {
            $selection = $input
        } else {
            Write-Host "Invalid choice"
        }
    }
    return $selection
}

function ManageProcessesOnDrive($drive) {
    do {
        $handleOutput = & $handleExePath $drive.Root
        $processes = $handleOutput | Select-String -Pattern "pid: ([0-9]+)" -AllMatches | ForEach-Object {
            $processId = $_.Matches.Groups[1].Value
            Get-Process -Id $processId -ErrorAction SilentlyContinue | Select-Object Id, ProcessName, Path
        }

        if ($processes.Count -gt 0) {
            PrintHeader
            $processes | Format-Table -AutoSize
            Write-Host "`n`n"
            Write-Host "                1. Kill all processes"
            Write-Host "                2. Kill Processes, Eject drive"
            Write-Host "                3. Force Eject Drive"
            Write-Host "                4. Re-Scan Selected Drive`n"
            Write-Host "                0. Go Back`n`n"
            
            $choice = Read-Host "Enter your choice"
            switch ($choice) {
                "1" { 
                    # Existing logic for option 1
                }
                "2" { 
                    # Existing logic for option 2
                }
                "3" { 
                    EjectDrive $drive -Force
                    break
                }
                "4" { 
                    continue
                }
                "0" { 
                    return
                }
                default {
                    Write-Host "Invalid choice"
                }
            }
        } else {
            Write-Host "No processes accessing drive."
            Start-Sleep -Seconds 3
            return
        }
    } while ($true)
}




function EjectDrive($drive, [switch]$Force) {
    if ($Force) {
        # Force eject logic (use with caution)
        Write-Host "Force ejecting drive"
    } else {
        try {
            $eject = New-Object -comObject Shell.Application
            $eject.NameSpace(17).ParseName($drive.Root).InvokeVerb('Eject')
            Write-Host "Drive safely ejected!"
        } catch {
            Write-Host "Failed eject drive!"
        }
    }
}

# Main loop
do {
    DisplayMainMenu
    $selection = GetDriveSelection
    if ($selection -eq 0) { break }
    $drive = Get-PSDrive -PSProvider FileSystem | Select-Object -Index ($selection - 1)
    ManageProcessesOnDrive $drive
} while ($true)
