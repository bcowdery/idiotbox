Idiotbox
========

😶Idiotbox is a super lightweight helper script to install and configure my Windows environment.

The idiot can:
* Install the [Scoop](https://scoop.sh) package manager
* Install [Nerd Fonts](https://www.nerdfonts.com/)
* Install [Starship.rs](https://starship.rs/) and console themes
* Install python, nodejs, dev tools and other applications
* Manage Bash configuration .dotfiles in the users $HOME directory


# Installation

You can clone the repository wherever you want, although `~/.idiotbox` is preferred. 
The `install.ps1` script will configure the machine and add the `idiotbox` command to the path.

```
git clone https://github.com/bcowdery/idiotbox.git ~/.idiotbox && ~/.idiotbox/install.ps1
```

## Commands

Run `idiotbox edit` to edit the Scoopfile to add or remove applications.
```shell
$ idiotbox edit
```

You can optionally specify a `.dotfile` in the idiotbox directory to edit. This is useful for making changes to
aliases, paths, functions or other environment customizations.
```shell
$ idiotbox edit .aliases
```

Run `idiotbox update` to update all installed software and copy any modified `.dotfiles` to your $HOME dir. 
```shell
$ idiotbox update
```


# Dotfiles

Dotfiles are copied to the user's $HOME directory when the `idiotbox update` command is run. These files are used to
configure the Bash shell environment and many POSIX compliant applications.

- `.bashrc` - Bash configuration
- `.vimrc` - ViM configuration
- `.curlrc` - cURL configuration
- `.editorconfig` - Editor configuration for consistent code formatting
- `.gitconfig` - Git configuration

## Extras

Extras are optional includes that you can use to add customizations to your environment.

| File         | Description |
|--------------|-------------|
| `.path`      | Additions to the `$PATH` |
| `.exports`   | Export environment variables, feature detection etc. |
| `.aliases`   | Aliases for commonly used commands |
| `.functions` | Shell functions |
| `.extra`     | User specific extra's that you generally don't want to commit to github |


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
