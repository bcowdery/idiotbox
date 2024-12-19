Dotfiles
========

My .dotfiles, configurations and unattended software installs for Windows.

* Install the [Scoop](https://scoop.sh) package manager
* Install [Nerd Fonts](https://www.nerdfonts.com/)
* Install [Starship.rs](https://starship.rs/) and console themes
* Install python, nodejs, dev tools and other applications
* Copys all .dotfiles to the user $HOME directory


# Installation

You can clone the repository wherever you want, although `~/.dotfiles` is preferred. The [install.ps1](install.ps1) script will pull in the latest version, install all the software and copy dotfiles to their new $HOME.

```
git clone https://github.com/bcowdery/dotfiles-win.git ~.dotfiles && ~/.dotfiles/install.ps1
```

## Staying up to date

You can update your installation at any time by running the install script again.

If you prefer to only run software updates (ignoring windows explorer and other machine settings) you can run the [update.ps1](update.ps1) script instead.
```shell
~/.dotfiles/update.sh
```

Alternativley, you can just run `scoop update` to update all your software:
```shell
scoop update
scoop update -a
```



# Extras

If any of these files exist, they will be sourced along with the main `~/.zshrc`. These files provide extension points for the shell environment organized by convention.

- `.path` - Additions to the `$PATH`
- `.exports` - Export environment variables, feature detection etc.
- `.aliases` - Aliases for commonly used commands
- `.functions` - Shell functions
- `.extra` - User specific extra's that you generally don't want to commit to github

## Path

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```shell
export PATH="/usr/local/bin:$PATH"
```

## Customizations

You can use `~/.extra` to add a few customizations without the need to fork this entire repository, or to add configuration that you don’t want to commit to a public repository.

For example, you can use `~/.extra` to configure your Git credentials, leaving the committed `.gitconfig` free
of user specific configuration.

```shell
# Git credentials
# Commented out to prevent people from accidentally committing under my name
#GIT_AUTHOR_NAME="Brian Cowdery"
#GIT_AUTHOR_EMAIL="brian@thebeardeddeveloper.co"
#GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
#GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
#git config --global user.name "$GIT_AUTHOR_NAME"
#git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. Although it's probably better to just [fork this repository](https://github.com/bcowdery/dotfiles-win/fork) instead.
