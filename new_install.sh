#!/bin/bash

sudo apt update
sudo apt -y upgrade

# install Thai fonts
# ref: https://opensource.cc.psu.ac.th/%E0%B8%95%E0%B8%B4%E0%B8%94%E0%B8%95%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B8%9F%E0%B8%AD%E0%B8%99%E0%B8%95%E0%B9%8C%E0%B8%A0%E0%B8%B2%E0%B8%A9%E0%B8%B2%E0%B9%84%E0%B8%97%E0%B8%A2%E0%B8%9A%E0%B8%99_ubuntu_16.04_server
sudo apt install -y xfonts-thai 
sudo wget ftp://ftp.psu.ac.th/pub/thaifonts/sipa-fonts/*ttf -P /usr/share/fonts/truetype/thai

# install terminal emulator
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

sudo apt install -y network-manager
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
# restore dotfiles
cd ~
git clone https://github.com/tmwatchanan/dotfiles
cd dotfiles
./restore_conf.sh
fc-cache -f -v
# install tmux and tpm (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf # reload tmux environment
# install misc
# ranger = a vim-like file browser
cd /tmp && git clone https://github.com/hut/ranger.git
cd /tmp/ranger && sudo make install
rm -rf /tmp/ranger
# ranger plugins
cd /tmp && git clone https://github.com/alexanderjeurissen/ranger_devicons
cd /tmp/ranger_devicons/ && sudo make install
sudo apt install -y atool # managing file archives
# install fuzzy finder
sudo apt install -y findutils mlocate
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
sudo apt install -y poppler-utils # pdftoppm
sudo apt install -y zathura # vim-like pdf viewer
sudo snap install pdftk # pdf merge toolkit
sudo apt install -y imagemagick # the best image manipulation tool
sudo apt install -y firefox # web browser
sudo apt install -y xbacklight
sudo apt install -y feh # background image changer
# original compton
# sudo apt-add-repository ppa:richardgv/compton
# sudo apt update
# sudo apt install -y compton
# modified compton
sudo apt install -y libconfig-dev dbus libdbus-1-dev libdbus-glib-1-2 libdbus-glib-1-dev libgl1-mesa-dev
git clone https://github.com/tryone144/compton /tmp/
cd /tmp/compton
make
make install
rm -r /tmp/compton
sudo apt install -y rofi
sudo apt install -y x11-xserver-utils
sudo apt install -y mmv # rename files with pattern
# playing audio
sudo apt install -y pulseaudio
sudo apt install -y pavucontrol
# playing videos
sudo apt install -y libavcodec-extra 
# nvidia driver
sudo apt install -y nvidia-settings
sudo apt install -y ubuntu-drivers-common
sudo ubuntu-drivers autoinstall
# wireless devices
sudo apt install -y rfkill
# utilities
sudo apt install -y detox # clean up filenames
# fonts
sudo add-apt-repository universe
sudo apt install -y fonts-firacode
# latex
sudo apt install -y texlive-latex-extra
sudo apt install -y texlive-xetex

# i3-gaps
# ref: https://github.com/Airblader/i3/wiki/Compiling-&-Installing
# install i3-gaps dependencies
sudo apt install -y \
libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake
# install i3-gaps dependency (xcb-util-xrm)
cd /tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install
cd /tmp && rm -rf xcb-util-xrm
# install i3-gaps
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
cd /tmp && rm -rf i3-gaps

# install polybar
# ref: https://medium.com/@tatianaensslin/install-polybar-in-3-steps-on-debian-stretch-c64ab6157fb1
sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev
cd /tmp && git clone --branch 3.2 --recursive https://github.com/jaagr/polybarcd polybar && ./build.sh
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install
cd /tmp && rm -rf polybar
# set environment variable for polybar
export MONITOR=eDP1
# set default editor for sudoedit
sudo update-alternatives --config editor
