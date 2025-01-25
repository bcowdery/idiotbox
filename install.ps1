# Powershell install script for Windows machines.
#
# This script installs the Scoop package manager, software, copies dotfiles to the home directory,
# and configures Windows Explorer to my liking.
#
# @see https://scoop.sh
# @see https://learn.microsoft.com/en-us/windows/package-manager/
#

# emoji characters
$nomouth = [char]::ConvertFromUtf32(0x1F636)
$wave = [char]::ConvertFromUtf32(0x1F44B)
$greenheart = [char]::ConvertFromUtf32(0x1F49A)
$knife = [char]::ConvertFromUtf32(0x1F52A)
$download = [char]::ConvertFromUtf32(0x1F4E1)

# prompt for confirmation before proceeding with installation
Write-Host "Welcome to Idiotbox $nomouth"
Write-Host "This script will install software and configure Windows settings."
Write-Host ""

$confirmation = $(Write-Host "Do you want to continue? (y/N) " -ForegroundColor Yellow -NoNewline; Read-Host)
if ($confirmation -ne 'y') {
    Write-Host -ForegroundColor Green "Ok, bye. $wave"
    exit
}

# install scoop if it doesn't exist
if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
	Write-Host ""
	Write-Host "$download Installing Scoop..."

	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# install and configure software
.\Dotfiles.ps1
.\Scoopfile.ps1
.\Wingetfile.ps1

# post installation tasks (one-time setup)
.\Post-Install.ps1

# install an optional shim for the idiotbox bash script
Write-Host ""

$confirmation = $(Write-Host "Do you want to add a shim for the idiotbox bash script? (y/N) " -ForegroundColor Yellow -NoNewline; Read-Host)
if ($confirmation -eq 'y') {
	Write-Host ""
	Write-Host "$knife Shimming idiotbox..."
	scoop shim add idiotbox "$PSScriptRoot/bin/idiotbox.sh"
}

Write-Host ""
Write-Host -ForegroundColor Green "All done! $greenheart"
Write-Host -ForegroundColor Green "Run 'idiotbox' from a bash command prompt to get started."
