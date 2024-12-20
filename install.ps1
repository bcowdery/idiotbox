# Powershell install script for my Windows machine.
#
# This script installs Scoop, installs software, copies dotfiles
# and configures Windows Explorer to my liking.
#
# @see https://scoop.sh
#

# emoji characters
$nomouth = [char]::ConvertFromUtf32(0x1F636)
$wave = [char]::ConvertFromUtf32(0x1F44B)
$package = [char]::ConvertFromUtf32(0x1F4E6)
$greenheart = [char]::ConvertFromUtf32(0x1F49A)
$knife = [char]::ConvertFromUtf32(0x1F52A)
$folder = [char]::ConvertFromUtf32(0x1F4C1)
$download = [char]::ConvertFromUtf32(0x1F4E1)
$gear = [char]::ConvertFromUtf32(0x1F527)


# Prompt for confirmation before proceeding with installation
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


# run all the commands in the scoopfile
Write-Host ""
Write-Host "$package Installing Scoop packages..."

.\Scoopfile.ps1
.\Scoopfile-install.ps1


# copy all files prefixed with '.' to the home directory
# exclude the .git directory and this repos .gitignore file
Write-Host ""
Write-Host "$gear Copying dotfiles to the home directory..."

Get-ChildItem -Path $PSScriptRoot -Filter ".*" -Exclude ".git,.gitignore" | ForEach-Object {
	Copy-Item -Path $_.FullName -Destination $env:USERPROFILE -Force
}


# Configure windows explorer settings
# @see https://learn.microsoft.com/en-us/windows/apps/develop/settings/settings-common
# @see https://learn.microsoft.com/en-us/windows/apps/develop/settings/settings-windows-11
Write-Host ""
Write-Host "$folder Configuring Windows Explorer settings..."

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

Set-ItemProperty $key Hidden 1			          # show hidden files
Set-ItemProperty $key HideFileExt 0		          # show all file extensions
Set-ItemProperty $key ShowSuperHidden 0           # show system files
Set-ItemProperty $key NavPaneShowAllFolders 1     # show all folders in navigation pane
Set-ItemProperty $key Start_Layout 1  			  # more pins, less recommendations
Set-ItemProperty $key Start_IrisRecommendations 0 # disable recommendations
Set-ItemProperty $key Start_TrackDocs 0           # disable recent documents

Stop-Process -processname explorer


# Add an optional shim for the idiotbox bash script
Write-Host ""

$confirmation = $(Write-Host "Do you want to add a shim for the idiotbox bash script? (y/N) " -ForegroundColor Yellow -NoNewline; Read-Host)
if ($confirmation -eq 'y') {
	Write-Host ""
	Write-Host "$knife Shimming idiotbox..."
	scoop shim add idiotbox "$PSScriptRoot/bin/idiotbox.sh"
}

Write-Host ""
Write-Host -ForegroundColor Green "All done! $wave"
Write-Host -ForegroundColor Green "Run 'idiotbox' from a bash command prompt to get started."