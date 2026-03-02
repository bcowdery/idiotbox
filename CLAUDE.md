# idiotbox

Manages Windows machine setup: dotfiles, shell config, PATH, and software installs. Changes here get copied to the home directory via PowerShell scripts.

## Architecture

```
.idiotbox/
├── bin/idiotbox.sh          # Main CLI — run via `idiotbox <command>`
├── lib/mise.sh              # Language version management helpers
├── .*                       # Dotfiles — copied to ~ by Dotfiles.ps1
├── Dotfiles.ps1             # Copies dotfiles + fixes Windows user PATH
├── Scoopfile.ps1            # Scoop package installs
├── Scoopfile_post-install.ps1
├── Wingetfile.ps1           # Winget package installs
├── Wingetfile_post-install.ps1
└── install.ps1              # Full bootstrap — runs all of the above
```

## Shell config load order (GitBash)

```
~/.bash_profile
  └── ~/.bashrc
        ├── starship init
        ├── mise activate
        ├── ssh-agent setup
        └── sources: ~/.path, ~/.exports, ~/.aliases, ~/.functions, ~/.extra
```

## Key dotfiles

| File | Purpose |
|---|---|
| `.path` | Adds `$HOME/.local/bin` to `$PATH` — this is how `claude` (and other user-local tools) become available in GitBash |
| `.exports` | Sets `EDITOR`, `LANG`, `LC_ALL` |
| `.aliases` | Shell aliases (`l`, `ls`, `la`, `reload`, etc.) |
| `.functions` | `mkd` (mkdir + cd), `fs` (file size) |
| `.extra` | Machine-specific overrides — not committed |

## PATH for user-local tools (e.g. claude)

- Bash: `~/.local/bin` is added by `.path`, sourced in every interactive session
- Windows: `Dotfiles.ps1` ensures `%USERPROFILE%\.local\bin` is a directory entry in the Windows user PATH (fixes the claude installer's habit of adding the exe file path instead of the directory)

## Common tasks

```bash
# Apply dotfiles to home directory
idiotbox update dotfiles

# Update all packages
idiotbox update

# Edit a config file
idiotbox edit <filename>
idiotbox edit scoop     # Scoopfile.ps1
idiotbox edit winget    # Wingetfile.ps1
idiotbox edit mise      # .tool-versions

# Configure language runtimes (python, node, dotnet)
idiotbox configure
```

## Conventions

- Shell scripts use `#!/usr/bin/env bash`
- PowerShell scripts use `#!/usr/bin/env pwsh`
- Machine-specific customization goes in `~/.extra` (not committed)
- The `.path` file should only contain PATH additions — one `export PATH=...` per tool
- New tools that install to `~/.local/bin` will automatically be on PATH without any changes
