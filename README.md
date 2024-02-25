# dotfiles

## Installation

- Install packages
```sh
brew install neovim --HEAD
brew install yazi --HEAD
brew install wezterm fish
```

- Install fisher

```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

- Set up the symlink farm using GNU Stow

```sh
stow . --target=$HOME
```

## Tools

- [`GNU stow`](https://www.gnu.org/software/stow/) for managing dotfiles

- [`neovim (nightly)`](https://github.com/neovim/neovim) for text editing
- [`fish`](https://github.com/fish-shell/fish-shell) as a command-line shell
- [`fisher`](https://github.com/jorgebucaran/fisher) as a pluginer manager for fish
- [`wezterm`](https://github.com/wez/wezterm) for terminal emulator
- [`yazi`](https://github.com/sxyazi/yazi) as a file manager

- [`lazygit`](https://github.com/jesseduffield/lazygit) for git TUI
- [`delta`](https://github.com/dandavison/delta) for git diff
- [`fzf`](https://github.com/junegunn/fzf) for fuzzy finder
- [`duf`](https://github.com/muesli/duf) for a better _df_
- [`dust`](https://github.com/bootandy/dust) for a better _du_
- [`fd`](https://github.com/sharkdp/fd) for a better _find_
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) for a better _grep_
- [`exa`](https://github.com/ogham/exa) for a better _ls_
- [`bat`](https://github.com/sharkdp/bat) for a better _cat_
- [`hyperfine`](https://github.com/sharkdp/hyperfine) for benchmarking
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) for _cd_ based on frecency

- [`glow`](https://github.com/charmbracelet/glow) for markdown (.md) preview
- [`miller`](https://github.com/johnkerl/miller) for CSV, TSV, and tabular JSON preview

- `i3`-gaps as a window management
- `polybar` for top bar
- `compton` for enabling transparency with _urxvt_, and shadows
- `dunst` for notification server
- `Xbindkeys` for binding special keys
- `imagemagick` for every possible image manipulation
- `zathura` as a PDF viewer

## Set Wallpapers

`feh --randomize --bg-fill $HOME/.wallpapers/*`

## Note

- `neovim` must be the nightly version at this time, otherwise some plugins do not work.
