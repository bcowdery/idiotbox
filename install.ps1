# Description: Install script for setting up a new Windows machine
# Author: Brian Cowdery
# Last Updated: 2021-09-26

# check if Scoop is installed
if ($null -eq (Get-Command "scoop.exe" -ErrorAction SilentlyContinue)) {
	Write-Host "🥄 Installing Scoop..."
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# run all the commands in the scoopfile
Write-Host "📦 Installing Scoop packages..."

.\Scoopfile.ps1

# copy all files prefixed with '.' to the home directory
# exclude the .git directory and this repos .gitignore file
Write-Host "📄 Copying dotfiles to the home directory..."

Get-ChildItem -Path $PSScriptRoot -Filter ".*" -Exclude ".git,.gitignore" | ForEach-Object {
	Copy-Item -Path $_.FullName -Destination $env:USERPROFILE -Force
}

# Configure windows explorer settings
# show hidden files, full path in title bar etc.
Write-Host "🤖 Setting Windows Explorer settings..."

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key ShowSuperHidden 1
Stop-Process -processname explorer

Write-Host "Done 🎉"
