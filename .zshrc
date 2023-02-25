# Your previous .profile  (if any) is saved as .profile.mpsaved

###############################################################################
# aliases, path, etc.
###############################################################################

# activate virtualenv venv, otherwise create and activate
venv() {
    if [ ! -d $PWD/venv ]; then
	python -m venv $PWD/venv
    fi
    source $PWD/venv/bin/activate
}

# activate conda env cenv, otherwise create and activate
cenv() {
    if [ ! -d $PWD/cenv ]; then
	mkdir cenv && conda create -p $PWD/cenv python -y
    fi
    source activate $PWD/cenv
}

# env
[ -e $HOME/.env ] && source $HOME/.env

# aliases
alias la='ls -a'   # hidden
alias ll='ls -lh'  # long
alias lt='ls -lth' # long time sorted
alias emacs='emacs -nw'
alias less='less -R'
alias k='kubectl'

# ls colors for bsd/linux
ls --color &>/dev/null && alias ls='ls --color=tty' || alias ls='ls -G'
export LSCOLORS=ExFxBxDxCxegedabagacad

# editor needs to be set for commits without -m
export EDITOR='emacs -nw'

# homebrew
export PATH=/opt/homebrew/bin:$PATH

# pyenv
export PYENV_VERSION=3.9.16
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true
export PATH="$HOME/.poetry/bin:$PATH"

# cuda
export CUDA_HOME=/usr/local/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# personal stuff
#export PATH=$HOME/bin:$PATH

# work stuff
export SQUARE_HOME=$HOME/Development
FILE=$SQUARE_HOME/config_files/square/profile && [ -f $FILE ] && source $FILE
FILE=$SQUARE_HOME/ds-cash/setup/ds-cash-shell && [ -f $FILE ] && source $FILE
#FILE=$SQUARE_HOME/config_files/square/zshrc && [ -f $FILE ] && source $FILE

###############################################################################
# zsh stuff
###############################################################################

# prompt
PROMPT="%m:%1~ %n$ "
# in-place delete
bindkey "^[[3~" delete-char
# zsh history
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
history() { builtin history 1 }
# up/down searching
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search # Up (Debian)
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down (Debian)
# cmd line completion
autoload -U compinit && compinit
zstyle ":completion:*" menu select
# k8s completion
command -v kubectl &>/dev/null && source <(kubectl completion zsh)
# batch rename
autoload -U zmv
# extended globbing but don't error on no match
setopt EXTENDED_GLOB
unsetopt NOMATCH
# unique path
typeset -U PATH

