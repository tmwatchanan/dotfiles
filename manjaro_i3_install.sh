sudo pacman -S --noconfirm systemd-swap

sudo pacman -S --noconfirm yay
sudo pacman -S --noconfirm neovim
sudo pacman -S --noconfirm kitty
sudo pacman -S --noconfirm trash-cli
sudo pacman -S --noconfirm sxiv
# tmux
sudo pacman -S --noconfirm tmux
# tpm (tmux plugins)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo pacman -S --noconfirm imagemagick
sudo pacman -S --noconfirm bat
sudo pacman -S --noconfirm fzf

sudo pacman -S --noconfirm yay
yay -S --noconfirm visual-studio-code-insiders
yay -S --noconfirm ttf-fira-code
yay -S --noconfirm ttf-monoid
yay -S --noconfirm mmv

yay -S --noconfirm spotify

# rnstall oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# dev
git config --global user.email "tmwatchanan@gmail.com"
git config --global user.name "tmwatchanan"
git config credential.helper store


