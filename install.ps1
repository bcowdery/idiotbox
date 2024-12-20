# Description: Install script for setting up a new Windows machine
# Author: Brian Cowdery
# Last Updated: 2021-09-26


# install scoop if it doesn't exist
if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# run all the commands in the scoopfile
Write-Host "Installing Scoop packages..."

.\Scoopfile.ps1

# copy all files prefixed with '.' to the home directory
# exclude the .git directory and this repos .gitignore file
Write-Host "Copying dotfiles to the home directory..."

Get-ChildItem -Path $PSScriptRoot -Filter ".*" -Exclude ".git,.gitignore" | ForEach-Object {
	Copy-Item -Path $_.FullName -Destination $env:USERPROFILE -Force
}

# Configure windows explorer settings
# @see https://learn.microsoft.com/en-us/windows/apps/develop/settings/settings-common
# @see https://learn.microsoft.com/en-us/windows/apps/develop/settings/settings-windows-11
Write-Host "Configuring Windows Explorer settings..."

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

Set-ItemProperty $key Hidden 1			          # show hidden files
Set-ItemProperty $key HideFileExt 0		          # show all file extensions
Set-ItemProperty $key ShowSuperHidden 0           # show system files
Set-ItemProperty $key NavPaneShowAllFolders 1     # show all folders in navigation pane
Set-ItemProperty $key Start_Layout 1  			  # more pins, less recommendations
Set-ItemProperty $key Start_IrisRecommendations 0 # disable recommendations
Set-ItemProperty $key Start_TrackDocs 0           # disable recent documents

Stop-Process -processname explorer

# Add a shim for the idiotbox bash script
scoop shim add idiotbox "$PSScriptRoot/bin/idiotbox.sh"

Write-Host "Done."