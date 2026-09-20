# dotfiles

## Installation

- Install [`just`](https://github.com/casey/just?tab=readme-ov-file#packages)

```sh
brew install just
```

- Create the symlink farm, and then after this we can use the global justfile

```sh
just -f ~/dev/dotfiles/.config/just/justfile stow
```

- Install packages

```sh
just -g install
```

- Set up the symlink farm using GNU Stow for managing dotfiles

```sh
just -g stow
```

- Install Claude Code config

```sh
stow -d ~/dev/dotfiles -t "$HOME" claude
```

- Install yazi plugins

```sh
just -g install-yazi
```

## Tools

### Dotfile management

| Tool | Purpose |
| --- | --- |
| [`just`](https://github.com/casey/just) | Command runner |
| [`GNU stow`](https://www.gnu.org/software/stow/) | Symlink farm for managing dotfiles |

### Shell & editing

| Tool | Purpose |
| --- | --- |
| [`neovim (nightly)`](https://github.com/neovim/neovim) | Text editing |
| [`fish`](https://github.com/fish-shell/fish-shell) | Command-line shell |
| [`fisher`](https://github.com/jorgebucaran/fisher) | Plugin manager for fish |
| [`wezterm`](https://github.com/wez/wezterm) | Terminal emulator |
| [`yazi`](https://github.com/sxyazi/yazi) | File manager |
| [`unar`](https://theunarchiver.com/command-line) | Yazi's archive extractor |

### Command-line utilities

| Tool | Purpose |
| --- | --- |
| [`lazygit`](https://github.com/jesseduffield/lazygit) | Git TUI |
| [`delta`](https://github.com/dandavison/delta) | Git diff |
| [`fzf`](https://github.com/junegunn/fzf) | Fuzzy finder |
| [`television`](https://github.com/alexpasmantier/television) | Fuzzy finding in terminal UIs |
| [`sd`](https://github.com/chmln/sd) | A better _sed_ |
| [`duf`](https://github.com/muesli/duf) | A better _df_ |
| [`dust`](https://github.com/bootandy/dust) | A better _du_ |
| [`fd`](https://github.com/sharkdp/fd) | A better _find_ |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) | A better _grep_ |
| [`eza`](https://github.com/eza-community/eza) | A better _ls_ |
| [`bat`](https://github.com/sharkdp/bat) | A better _cat_ |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | _cd_ based on frecency |
| [`hyperfine`](https://github.com/sharkdp/hyperfine) | Benchmarking |
| [`glow`](https://github.com/charmbracelet/glow) | Markdown (.md) preview |
| [`duckdb`](https://github.com/duckdb/duckdb) | CSV, TSV, JSON, Parquet, and XLSX preview (via [`duckdb.yazi`](https://github.com/wylie102/duckdb.yazi)) |
| [`tokei`](https://github.com/XAMPPRocky/tokei) | Code statistics (LOCs, # of files, etc.) |

### Languages & packages

| Tool | Purpose |
| --- | --- |
| [`uv`](https://github.com/astral-sh/uv) | Drop-in replacement for _pip_ |
| [`mamba` (via `miniforge`)](https://github.com/conda-forge/miniforge) | Drop-in replacement for _conda_ |
| [`fnm`](https://github.com/Schniz/fnm) | Node.js versions, auto-switches on `cd` via `.node-version`/`.nvmrc` |
| [`pixi`](https://github.com/prefix-dev/pixi) | Multi-language package manager (thinking about conda) |

### macOS

| Tool | Purpose |
| --- | --- |
| [`Alcove`](https://tryalcove.com) | MacBook notch (Dynamic Island-style media & battery activities); [`boring.notch`](https://github.com/TheBoredTeam/boring.notch) is a free & open-source alternative |

### Linux desktop

| Tool | Purpose |
| --- | --- |
| `i3`-gaps | Window management |
| `polybar` | Top bar |
| `compton` | Transparency with _urxvt_, and shadows |
| `dunst` | Notification server |
| `Xbindkeys` | Binding special keys |
| `imagemagick` | Every possible image manipulation |
| `zathura` | PDF viewer |

## Git Ignore

We need to define a git filter to ignore specific lines, in this case, lines that contain the `;gitignore` text.
This is really useful for ignoring some credentials that might be present in the files.

```sh
git config filter.gitignore.clean "sed '/;gitignore\$/d'"
# or 
git config --global filter.gitignore.clean "sed '/;gitignore\$/d'"
```

## Windows

Open Command Prompt with Administrator privileges.

### Git

In Windows,
```cmd
mklink "%USERPROFILE%\.gitconfig" "D:\dev\dotfiles\.gitconfig"
```

In WSL2,
```sh
sudo ln -s /mnt/c/Program\ Files/Git/usr/bin/gpg.exe /usr/local/bin/gpg
sudo ln -s gpg /usr/local/bin/gpg2
```

### Wezterm

```sh
mkdir %USERPROFILE%\.config
mklink /D %USERPROFILE%\.config\wezterm D:\dev\dotfiles\.config\wezterm
```

### Zed

Zed stores user config on Windows in `%APPDATA%\Zed`. Link the individual
config files so local data under that directory, such as themes or generated
state, can stay there.

Open Command Prompt with Administrator privileges.

```cmd
mkdir "%APPDATA%\Zed"
mklink "%APPDATA%\Zed\settings.json" "D:\dev\dotfiles\.config\zed\settings.json"
mklink "%APPDATA%\Zed\keymap.json" "D:\dev\dotfiles\.config\zed\keymap.json"
mklink "%APPDATA%\Zed\tasks.json" "D:\dev\dotfiles\.config\zed\tasks.json"
```

Without Administrator privileges, move any existing `%APPDATA%\Zed` directory
out of the way and use a directory junction instead.

```cmd
move "%APPDATA%\Zed" "%APPDATA%\Zed.backup"
mklink /J "%APPDATA%\Zed" "D:\dev\dotfiles\.config\zed"
```

### Television

Install Television with its file-listing and preview dependencies, then link
its Windows config directory.

```cmd
winget install --id alexpasmantier.television
winget install --id sharkdp.fd
winget install --id sharkdp.bat
mkdir "%LOCALAPPDATA%\television"
mklink /J "%LOCALAPPDATA%\television\config" "D:\dev\dotfiles\.config\television"
```

### AutoHotkey

```sh
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\mie.ahk" "D:\dev\dotfiles\AutoHotkey\mie.ahk"
```

Open PowerShell

### PowerShell profile, a script that runs when PowerShell starts

```powershell
New-Item -Path $PROFILE -ItemType SymbolicLink -Value D:\dev\dotfiles\PowerShell\profile.ps1
```
