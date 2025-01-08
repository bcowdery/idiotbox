# Scoopfile
#
# Installs software using Scoop package manager. 
#
# @see https://scoop.sh
#


# Extras bucket is for software that doesn't fit in the main bucket (non cli-apps)
# @see https://github.com/ScoopInstaller/Extras/tree/master/bucket
scoop bucket add extras *> $null

# Versions bucket is for software that has multiple versions (like python and nodejs)
# @see https://github.com/ScoopInstaller/Versions/tree/master/bucket
scoop bucket add versions *> $null

# Nerd Fonts bucket is for patched fonts with icons
# @see https://github.com/matthewjberger/scoop-nerd-fonts/tree/master/bucket
scoop bucket add nerd-fonts *> $null

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
scoop install 1password-cli act gh jq

# applications
scoop install discord gitkraken notion postman powertoys spotify slack vscode
