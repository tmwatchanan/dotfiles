sudo apt-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim # need version >= 0.3.2 for virtual text
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
sudo apt install -y exuberant-ctags # for Tagbar vim plugin
sudo apt install -y build-essential
git config --global user.email "tmwatchanan@gmail.com"
git config --global user.name "tmwatchanan"
git config credential.helper store

# install fuzzy finder
sudo apt install -y findutils mlocate
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# applications
sudo apt install -y mmv # rename files with pattern
sudo apt install -y detox # clean up filenames
sudo apt install -y poppler-utils # pdftoppm
sudo apt install -y zathura # vim-like pdf viewer
sudo snap install pdftk # pdf merge toolkit
sudo apt install -y imagemagick # the best image manipulation tool
sudo apt install -y texlive-latex-extra # latex
sudo apt install -y texlive-xetex # latex

# ranger = a vim-like file browser
cd /tmp && git clone https://github.com/hut/ranger.git
cd /tmp/ranger && sudo make install
rm -rf /tmp/ranger
# ranger plugins
cd /tmp && git clone https://github.com/alexanderjeurissen/ranger_devicons
cd /tmp/ranger_devicons/ && sudo make install

# nvidia driver
sudo apt install -y nvidia-settings
sudo apt install -y ubuntu-drivers-common
sudo ubuntu-drivers autoinstall

# fira-code font
sudo apt install fonts-firacode
