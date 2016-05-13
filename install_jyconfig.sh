#!/bin/bash

PREFIX=".jyconfig"

echo installing oh-my-zsh...
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd ~

if [ -d $PREFIX ]; then
	echo jyconfig already installed
	exit -1
fi

echo installing jyconfig...
git clone https://github.com/jayi/jyconfig.git $PREFIX

timestamp=`date +%F_%T`
backup_path="jybackup_$timestamp"
if [ ! -d $backup_path ]; then
	mkdir $backup_path
fi

for file in zshrc vimrc tmux.conf gitconfig pythonstartup
do
	mv .$file $backup_path
	ln -s $PREFIX/$file .$file
done

echo installing vundle...
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

# install vim vundle plugins
echo installing vim plugins
vim +PluginInstall +qall
