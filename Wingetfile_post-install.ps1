#!/usr/bin/env pwsh
#
# Winget post-install script.
#
# Runs first-time configuration and sets software installation defaults. This script is only
# executed by the by the install.ps1 script after all the other software installs have completed.
#
# To prevent accidental clobbering of your user environment, this script is not run by any 'idiotbox update' commmands.
#

$sparkles = [char]::ConvertFromUtf32(0x2728)
$folder = [char]::ConvertFromUtf32(0x1F4C1)

Write-Host ""
Write-Host "$sparkles Running post-install commands..."

# setup wsl
wsl --install

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
