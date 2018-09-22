#!/bin/bash

cp $HOME/.Xdefaults $HOME/dotfiles/
cp $HOME/.bashrc $HOME/dotfiles/
cp $HOME/.xinitrc $HOME/dotfiles/

cp $HOME/.config/compton.conf $HOME/dotfiles/.config/
cp $HOME/.config/i3/config $HOME/dotfiles/.config/i3/
cp $HOME/.config/nvim/init.vim $HOME/dotfiles/.config/nvim/
cp $HOME/.config/polybar/config $HOME/dotfiles/.config/polybar/
cp $HOME/.config/polybar/launch.sh $HOME/dotfiles/.config/polybar/
cp $HOME/.config/ranger/commands.py $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/rc.conf $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/rifile.conf $HOME/dotfiles/.config/ranger/
cp $HOME/.config/ranger/scope.sh $HOME/dotfiles/.config/ranger/

cp -r $HOME/.wallpaper $HOME/dotfiles/

