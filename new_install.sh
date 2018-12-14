#!/bin/bash

sudo apt update
sudo apt -y upgrade

# install Thai fonts
# ref: https://opensource.cc.psu.ac.th/%E0%B8%95%E0%B8%B4%E0%B8%94%E0%B8%95%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B8%9F%E0%B8%AD%E0%B8%99%E0%B8%95%E0%B9%8C%E0%B8%A0%E0%B8%B2%E0%B8%A9%E0%B8%B2%E0%B9%84%E0%B8%97%E0%B8%A2%E0%B8%9A%E0%B8%99_ubuntu_16.04_server
sudo apt install -y xfonts-thai 
sudo wget ftp://ftp.psu.ac.th/pub/thaifonts/sipa-fonts/*ttf -P /usr/share/fonts/truetype/thai

sudo apt install -y neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install -y build-essential
sudo apt install -y git
git config --global user.email "tmwatchanan@gmail.com"
git config --global user.name "tmwatchanan"
git config credential.helper store
sudo apt install -y ranger
sudo apt install -y firefox
sudo apt-add-repository ppa:richardgv/compton
sudo apt update
sudo apt install -y compton
sudo apt install -y rofi
sudo apt install -y nvidia-settings

# restore dotfiles
cd ~
git clone https://github.com/tmwatchanan/dotfiles
cd dotfiles
./restore_conf.sh
fc-cache -f -v

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
# set default editor for sudoedit
sudo update-alternatives --config editor
