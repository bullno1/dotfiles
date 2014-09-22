#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
function link()
{
	rm $2
	ln -s $DIR/$1 $2
}

link .vimrc ~/.vimrc
link .vrapperrc ~/.vrapperrc
link .zshrc ~/.zshrc
link .tmux.conf ~/.tmux.conf
link gpg-agent.conf ~/.gnupg/gpg-agent.conf
link .conkyrc ~/.conkyrc
