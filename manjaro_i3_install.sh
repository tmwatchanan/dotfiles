sudo pacman -S --noconfirm systemd-swap

sudo pacman -S --noconfirm yay
# neovim
sudo pacman -S --noconfirm neovim
pip install pynvim
# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo pacman -S --noconfirm kitty
sudo pacman -S --noconfirm trash-cli
sudo pacman -S --noconfirm sxiv
# tmux
sudo pacman -S --noconfirm tmux
# tpm (tmux plugins)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo pacman -S --noconfirm graphicsmagick
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


