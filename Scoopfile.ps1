# core utils
scoop install 7zip wget

# core git (uncomment if you're not using Git for Windows)
# scoop install curl sudo git openssh coreutils grep sed less vim

# fonts
# @see https://github.com/matthewjberger/scoop-nerd-fonts/tree/master/bucket
scoop bucket add nerd-fonts
scoop install FiraCode FiraCode-NF Cascadia-Code

# console theme
scoop install starship
starship preset nerd-font-symbols -o ~/.config/starship.toml

# programming languages
# @see https://github.com/ScoopInstaller/Versions/tree/master/bucket
scoop bucket add versions
scoop install python python311 nodejs-lts
scoop reset python311

# cli tools
scoop install 1password-cli act gh jq

# applications
scoop bucket add extras
scoop install gitkraken notion postman powertoys spotify slack vscode

# # non-portable windows applications (requires admin privileges)
# # @see https://github.com/TheRandomLabs/scoop-nonportable/tree/master/bucket
# scoop bucket add nonportable
# scoop install sql-server-management-studio-np
