#!/bin/sh

SCRIPT_PATH=`readlink -f $0`
SCRIPT_DIR=`dirname $SCRIPT_PATH`
link()
{
	mkdir -p `dirname $2`
	rm $2 > /dev/null ; ln -s $SCRIPT_DIR/$1 $2
}

link .vimrc ~/.vimrc
link .vrapperrc ~/.vrapperrc
link .zshrc ~/.zshrc
link .tmux.conf ~/.tmux.conf
link gpg-agent.conf ~/.gnupg/gpg-agent.conf
link .conkyrc ~/.conkyrc
link .2.conkyrc ~/.2.conkyrc
