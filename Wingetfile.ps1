#!/usr/bin/env pwsh
#
# Winget
#
# Installs software using Windows Package Manager (winget).
#
# @see https://winget.run/
# @see https://learn.microsoft.com/en-us/windows/package-manager/
#

$package = [char]::ConvertFromUtf32(0x1F4E6)

Write-Host ""
Write-Host "$package Installing Winget packages..."


# Update winget
winget update

# Install WSL
winget install Microsoft.WSL

# Install windows terminal and devtools
winget install DevToys-app.DevToys Jetbrains.Toolbox Jetbrains.Rider Microsoft.WindowsTerminal

# Productivity
winget install AgileBits.1Password Brave.Brave Notion.Notion

# Entertainment
winget install Discord.Discord Spotify.Spotify
