#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
function link()
{
	rm $2
	ln -s $DIR/$1 $2
}

link .vimrc ~/.vimrc
link .vrapperrc ~/.vrapperrc
link .zprofile ~/.zprofile
link .zshrc ~/.zshrc
link gpg-agent.conf ~/.gnupg/gpg-agent.conf
