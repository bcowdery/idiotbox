#!/usr/bin/env pwsh
#
# Scoop post-install script.
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

# set the default python version to 3.12
scoop reset python312

# set the startship preset
starship preset nerd-font-symbols -o ~/.config/starship.toml
