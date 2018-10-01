#!/bin/bash

cp $HOME/.Xdefaults $HOME/dotfiles/
cp $HOME/.bashrc $HOME/dotfiles/
cp $HOME/.xinitrc $HOME/dotfiles/
cp $HOME/.xbindkeysrc $HOME/dotfiles/

cp $HOME/.config/compton.conf $HOME/dotfiles/.config/
cp $HOME/.config/i3/config $HOME/dotfiles/.config/i3/
cp $HOME/.config/nvim/init.vim $HOME/dotfiles/.config/nvim/
cp -r $HOME/.config/polybar/* $HOME/dotfiles/.config/polybar/
cp $HOME/.config/ranger/commands.py $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/rc.conf $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/rifle.conf $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/scope.sh $HOME/dotfiles/.config/ranger/

cp -r $HOME/.config/colors/* $HOME/dotfiles/.config/colors/
rm -rf $HOME/dotfiles/.wallpaper && cp -r $HOME/.wallpaper $HOME/dotfiles/

