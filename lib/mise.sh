#!/usr/bin/env bash
#
# mise.sh
#
# Configures mise (https://mise.jdx.dev) for managing language runtime versions.
# Mirrors the pattern from the macOS dotfiles lib/asdf.sh.
#

MISE_PYTHON_VERSION="3"
MISE_NODE_VERSION="lts"
MISE_DOTNET_VERSION="9"

# Install language plugins and set global version defaults.
function configure_mise() {
    echo "Configuring mise language versions..."

    mise use --global python@$MISE_PYTHON_VERSION
    mise use --global node@$MISE_NODE_VERSION
    mise use --global dotnet@$MISE_DOTNET_VERSION

    echo "Done. Run 'mise list' to verify installed versions."
}

# Update all mise plugins and reinstall latest versions.
function update_mise() {
    echo "Updating mise plugins and language versions..."

    mise self-update
    mise upgrade

    echo "Done."
}
