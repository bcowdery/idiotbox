#!/usr/bin/env bash
#
# Idiotbox is a tool for managing my Windows machine.
#
# It can be used to edit installer files, update installers, apps, and dotfiles. To install idiotbox,
# clone the repository and run the 'install.ps1' script.
#

# this script lives in ./bin/
# resolve the path to parent directory where the installer files live
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

source "$PARENT_DIR/lib/mise.sh"

# installer scripts
DOT_FILE="Dotfiles.ps1"
SCOOP_FILE="Scoopfile.ps1"
WINGET_FILE="Wingetfile.ps1"
MISE_FILE=".tool-versions"

# help message
function show_help() {
    echo "Usage: $(basename $0) <command> [options]"
    echo ""
    echo "Available commands:"
    echo "  configure - Configure language versions via mise"
    echo "  edit      - Edit an installer file using the EDITOR"
    echo "  update    - Update all apps and dotfiles listed in the installer files"
    echo "  help      - Show this help message"
	echo ""
	echo "Options: "
	echo "  Use 'edit scoop', 'edit winget', or 'edit mise' to edit the app manifest for a specific installer."
	echo "  Use 'update scoop', 'update winget', 'update dotfiles', or 'update mise' to run a specific installer."
}

# Edit a file using the configured EDITOR (default to vim).
#
# Accepts a filename as an argument, or either 'scoop', 'winget', or 'mise' to
# edit the respective installer files. If no argument is provided, the
# current directory will be opened in the editor.
#
# @param $1 filename - the filename to edit
function edit_command() {
    local filename="$1"

    # check if the filename is 'scoop', 'winget', or 'mise'
	# default to the current directory if not set
	if [ -z "$filename" ]; then
		filename="."

    elif [ "$filename" == "scoop" ]; then
        filename="$SCOOP_FILE"

	elif [ "$filename" == "winget" ]; then
        filename="$WINGET_FILE"

	elif [ "$filename" == "mise" ]; then
        filename="$MISE_FILE"
    fi

    # edit the file using configured EDITOR
    # default to vim if not set
    if [ -n "$EDITOR" ]; then
        $EDITOR "$filename"
    else
        vim "$filename"
    fi
}

# Update installers, apps, and dotfiles.
#
# Accepts an installer as an argument, either 'scoop', 'winget', 'dotfiles', or 'mise'. If no
# argument is provided, all installers will be updated.
#
# @param $1 installer - the installer to update
function update_command() {
    local installer="$1"

    # check if the installer is 'scoop' or 'winget' or 'dotfiles' or 'mise'
	if [ -z "$installer" ]; then
		update_scoop
		update_winget
		update_dotfiles
		update_mise

	elif [ "$installer" == "scoop" ]; then
        update_scoop

	elif [ "$installer" == "winget" ]; then
        update_winget

	elif [ "$installer" == "dotfiles" ]; then
		update_dotfiles

	elif [ "$installer" == "mise" ]; then
		update_mise

	else
        echo "Error: Unknown source '$installer'"
        return;
    fi
}

function update_scoop() {
    powershell -File $SCOOP_FILE
}

function update_winget() {
	powershell -File $WINGET_FILE
}

function update_dotfiles() {
	powershell -File $DOT_FILE
}

cd "$PARENT_DIR" || exit 1

# Run the command
case "$1" in
	"configure")
		configure_mise
		;;
	"edit")
		edit_command "${@:2}"
		;;
	"update")
		update_command "${@:2}"
		;;
	"help"|"")
		show_help
		;;
	*)
		echo "Error: Unknown command '$1'"
		show_help
		exit 1
		;;
esac
