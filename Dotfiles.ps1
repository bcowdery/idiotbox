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

# Ensure ~/.local/bin is in the Windows user PATH as a directory.
# Some installers (e.g. Claude Code) incorrectly add the full path to an
# executable instead of the directory, which breaks PATH lookup outside of
# bash login shells.
$localBin = "$env:USERPROFILE\.local\bin"
$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
$pathEntries = $currentPath -split ';' | Where-Object { $_ -ne '' }

# Remove the directory itself (to re-add) and any bare file paths inside it
$cleaned = $pathEntries | Where-Object {
	$_ -ne $localBin -and -not ($_.StartsWith($localBin + '\'))
}

$newPath = (@($localBin) + $cleaned) -join ';'
[Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
Write-Host "$gear Ensured $localBin is in the Windows user PATH."
