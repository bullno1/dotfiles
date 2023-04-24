# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mortalscumbag"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vagrant zbell dotenv)

source $ZSH/oh-my-zsh.sh

unsetopt autonamedirs

# Customize to your needs...
export EDITOR=vim

case "$TERM" in
	'xterm') TERM=xterm-256color;;
	'screen') TERM=screen-256color;;
esac
export TERM

zbell_ignore=($EDITOR $PAGER ls watch htop top ssh ssht rlwrap iotop dstat vmstat nano emacs vi vimdiff bwm-ng less more fdisk sqlite3 wine ping traceroute tail tmux screen man powertop git ocaml)

zbell_notify() {
	type notify-send > /dev/null && \
		notify-send -i terminal "Command completed:" $1
}

# Use local scripts
export PATH="$PATH:$HOME/bin:${HOME}/.krew/bin"

alias ls='ls --color=tty --group-directories-first'

# Make Ctrl+S work
stty -ixon

# Make tab width 4 spaces
tabs -4

# Convenient bindings

function ssht(){
	ssh $* -t 'tmux a || tmux || /bin/bash'
}

function activate-venv() {
	VENVDIR=${1:-~/venv}
	source $VENVDIR/bin/activate
}

function stouch() {
	mkdir -p "$(dirname "$1")" && touch "$1"
}

alias gitroot='cd $(git rev-parse --show-toplevel)'

# Autostart tmux if the shell is interactive
if command -v tmux > /dev/null; then
	[[ $- != *i* ]] && return
	[[ -z "$TMUX" ]] && exec tmux
fi

# OS X configuration
command -v brew > /dev/null && export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

# JRE configuration
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.systemlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export GRADLE_OPTS='-Dorg.gradle.daemon=true -Dorg.gradle.parallel=true'

# gpg
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" || true # Load RVM into a shell session *as a function*

# pyenv
if command -v pyenv 1> /dev/null
then
	eval "$(pyenv init --path)"
fi

if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
	source /usr/share/nvm/init-nvm.sh
	autoload -U add-zsh-hook

	load-nvmrc() {
		local nvmrc_path
		nvmrc_path="$(nvm_find_nvmrc)"

		if [ -n "$nvmrc_path" ]; then
			local nvmrc_node_version
			nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

			if [ "$nvmrc_node_version" = "N/A" ]; then
				nvm install
			elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
				nvm use
			fi
		elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
			echo "Reverting to nvm default version"
			nvm use default
		fi
	}

	add-zsh-hook chpwd load-nvmrc
	load-nvmrc
fi
