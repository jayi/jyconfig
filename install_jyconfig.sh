#!/bin/bash

PREFIX=".yjconfig"

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd ~/tmp
git clone ~/dev/jyconfig $PREFIX

timestamp=`date +%F_%T`
if [ ! -d "jybackup_$timestamp" ]; then
	mkdir jybackup_$timestamp
fi

for file in zshrc vim vimrc tmux.conf gitconfig pythonstartup
do
	mv .$file jybackup
	ln -s $PREFIX/$file .$file
done
