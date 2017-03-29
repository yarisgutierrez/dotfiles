#!/bin/bash
#
# Yaris Alex Gutierrez <yarisgutierrez@gmail.com>
# This script creates symbolic links from the home (~) directory to desired dotfiles in ~/git/dotfiles
#

###  Vars ###
directory=~/git/dotfiles                          # dotfiles directory
old_directory=~/dotfiles_old                      # Old dotfiles backup directory
files="zshrc bashrc vimrc vim oh-my-zsh bashrc"   # List of files/folders to symlink to the home dir


### Create dotfiles_old in the home directory ###
echo "Creating $old_directory for backup of any existing dotfiles in the current home directory..."
mkdir -p $old_directory
echo "...done"

### Change to the dotfiles directory ###
echo "Changing to the $directory directory..."
cd $directory
echo "...done"

### Move any existing dotfiles in the home directory to dotfiles_old, then create the symbolic links
for file in $files; do
  echo "Moving any existing dotfiles from the current home directory to $old_directory..."
  mv ~/.$file ~/dotfiles_old
  echo "Creating symbolic links to $file in home directory..."
  ln -s $directory/$file ~/.$file
done
