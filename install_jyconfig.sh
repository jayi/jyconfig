#!/bin/bash

PREFIX=".jyconfig"

# echo installing oh-my-zsh...
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd ~

if [ -d $PREFIX ]; then
	echo jyconfig already installed
else
	echo installing jyconfig...
	git clone https://github.com/jayi/jyconfig.git $PREFIX
fi

timestamp=`date +%F_%T`
backup_path="jybackup_$timestamp"
if [ ! -d $backup_path ]; then
	mkdir $backup_path
fi

mv .vim $backup_path
for file in zshrc vimrc tmux.conf gitconfig pythonstartup bashrc completion
do
	mv .$file $backup_path
	ln -s $PREFIX/$file .$file
done

echo installing vundle...
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

# install vim vundle plugins
echo installing vim plugins
vim +PluginInstall +qall
