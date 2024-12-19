# Description: Update all scoop apps and copy dotfiles to the home directory
# Author: Brian Cowdery
# Last Updated: 2021-09-26

# update scoop
scoop update

# run all the commands in the scoopfile
Write-Host "Installing Scoop packages..."

.\Scoopfile.ps1

# update all installed apps
scoop update -a
scoop cleanup -a

# copy all files prefixed with '.' to the home directory
# exclude the .git directory and this repos .gitignore file
Write-Host "Copying dotfiles to the home directory..."

Get-ChildItem -Path $PSScriptRoot -Filter ".*" -Exclude ".git,.gitignore" | ForEach-Object {
	Copy-Item -Path $_.FullName -Destination $env:USERPROFILE -Force
}

Write-Host "Done."
