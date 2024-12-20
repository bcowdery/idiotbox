# Post-install Scoopfile.
#
# Runs first-time configuration and sets software installation defaults. This script is only 
# executed by the by the install.ps1 script after the main Scoopfile.ps1. It is not run by idiotbox
# updates to prevent accidental clobbering of the user environment.
#
# @see https://scoop.sh
#


# set the default python version to 3.11
scoop reset python311

# set the startship preset
starship preset nerd-font-symbols -o ~/.config/starship.toml