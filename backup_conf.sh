#!/bin/bash

cp $HOME/.Xdefaults $HOME/dotfiles/
cp $HOME/.bash_profile $HOME/dotfiles/
cp $HOME/.zshrc $HOME/dotfiles/
cp $HOME/.bashrc $HOME/dotfiles/
cp $HOME/.xinitrc $HOME/dotfiles/
cp $HOME/.xbindkeysrc $HOME/dotfiles/
cp $HOME/.profile $HOME/dotfiles/
cp $HOME/.tmux.conf $HOME/dotfiles/
cp $HOME/.condarc $HOME/dotfiles/

cp $HOME/.config/compton.conf $HOME/dotfiles/.config/
cp $HOME/.config/i3/config $HOME/dotfiles/.config/i3/
cp $HOME/.config/bspwm/* $HOME/dotfiles/.config/bspwm/
cp $HOME/.config/sxhkd/* $HOME/dotfiles/.config/sxhkd/
cp $HOME/.config/kitty/kitty.conf $HOME/dotfiles/.config/kitty/
cp $HOME/.config/nvim/init.vim $HOME/dotfiles/.config/nvim/
cp -r $HOME/.config/nvim/lua/* $HOME/dotfiles/.config/nvim/lua/
cp -r $HOME/.config/polybar/* $HOME/dotfiles/.config/polybar/
cp $HOME/.config/ranger/commands.py $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/rc.conf $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/rifle.conf $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/scope.sh $HOME/dotfiles/.config/ranger/
cp $HOME/.config/dunst/* $HOME/dotfiles/.config/dunst/
cp $HOME/.config/zathura/zathurarc $HOME/dotfiles/.config/zathura/

mkdir -p $HOME/dotfiles/.fonts/ && cp $HOME/.fonts/* $_
cp -r $HOME/.config/colors/* $HOME/dotfiles/.config/colors/
rm -rf $HOME/dotfiles/.wallpaper && cp -r $HOME/.wallpaper $HOME/dotfiles/

