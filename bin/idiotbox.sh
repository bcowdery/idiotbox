#!/bin/bash

# Get the directory where the script is located and move to its parent
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

# Change to parent directory
cd "$PARENT_DIR" || exit 1

# Command to edit a file in the idiotbox directory. 
# If no filename is provided, edit the Scoopfile.
# 
# @param $1 filename - the filename to edi
function edit_command() {
  local filename="$1"

  if [ -z "$filename" ]; then
    filename="Scoopfile"
  fi

  # edit the file using EDITOR or vim
  if [ -n "$EDITOR" ]; then
    $EDITOR "$filename"
  else
    vim "$filename"
  fi 
}

# Command to update scoop and install any new apps listed in the Scoopfile
function update_command() {
    # update scoop
    scoop update

    # run all the commands in the scoopfile
    bash Scoopfile 2>/dev/null

    # update all installed apps
    # and cleanup old versions
    scoop update -a
    scoop cleanup -a

    # copy all files prefixed with '.' to the home directory
    # exclude the .git directory and this repos .gitignore file
    for file in .*; do
        if [[ "$file" != ".git" && "$file" != ".gitignore" && -f "$file" ]]; then            
            cp -f "$file" "$HOME/"
        fi
    done

    echo -e "\033[32mDone 💚\033[0m"
}

# Command redirect to git for repository operations
function repo_command() {
    git "$@"
}

function show_help() {
    echo "Usage: $0 <command>"
    echo ""
    echo "Available commands:"
    echo "  edit    - Edit an idiotbox scoop or dotfile"
    echo "  update  - Update all installed apps and install any new apps listed in the scoopfile"
    echo "  repo    - Repository operations"
    echo "  help    - Show this help message"
}

# Main command handler
case "$1" in
    "edit")
        edit_command "${@:2}"
        ;;
    "update")
        update_command "${@:2}"
        ;;
    "repo")
        repo_command "${@:2}"
        ;;
    "git")
        repo_command "${@:2}"
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
