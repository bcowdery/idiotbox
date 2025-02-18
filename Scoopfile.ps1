#!/usr/bin/env pwsh
#
# Scoopfile
#
# Installs software using Scoop package manager.
#
# @see https://scoop.sh
#

$package = [char]::ConvertFromUtf32(0x1F4E6)

Write-Host ""
Write-Host "$package Installing Scoop packages..."


# Extras bucket is for software that doesn't fit in the main bucket (non cli-apps)
# @see https://github.com/ScoopInstaller/Extras/tree/master/bucket
scoop bucket add extras --quiet

# Versions bucket is for software that has multiple versions (like python and nodejs)
# @see https://github.com/ScoopInstaller/Versions/tree/master/bucket
scoop bucket add versions --quiet

# Nerd Fonts bucket is for patched fonts with icons
# @see https://github.com/matthewjberger/scoop-nerd-fonts/tree/master/bucket
scoop bucket add nerd-fonts --quiet

# update manifests
scoop update --quiet

# core utils
scoop install 7zip wget

# portable git
# uncomment this line if you want to use portable git instead of git-for-windows (git-scm.com)
# scoop install curl sudo git openssh coreutils grep sed less vim

# fonts and console themes
scoop install starship FiraCode FiraCode-NF Cascadia-Code

# programming languages
scoop install dotnet-sdk-lts python python312 nodejs-lts

# cli tools
scoop install 1password-cli act gh jq k6 ngrok

# applications
scoop install notepadplusplus postman powertoys rider slack vscode wireshark
