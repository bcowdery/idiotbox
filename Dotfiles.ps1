#!/usr/bin/env pwsh
#
# Dotfiles
#
#
# Used to restore dev tooling and command-line configuration files to a new machine.
#
# Copies all files prefixed with '.' to the home directory, excluding the idiotbox
# repo .git directory and .gitignore file.
#

$gear = [char]::ConvertFromUtf32(0x1F527)

Write-Host ""
Write-Host "$gear Copying dotfiles to the home directory..."

Get-ChildItem -Path $PSScriptRoot -Filter ".*" -Exclude ".git,.gitignore" | ForEach-Object {
	Copy-Item -Path $_.FullName -Destination $env:USERPROFILE -Force
}
