# Your previous .profile  (if any) is saved as .profile.mpsaved

###############################################################################
# aliases, path, etc.
###############################################################################

# activate venv, otherwise create and activate
venv() {
    if [ ! -d venv ]; then
	virtualenv venv
    fi
    source venv/bin/activate
}

# aliases
alias la='ls -a'   # hidden
alias ll='ls -lh'  # long
alias lt='ls -lth' # long time sorted
alias emacs='emacs -nw'
alias less='less -R'

# ls colors for bsd/linux
ls --color &>/dev/null && alias ls='ls --color=tty' || alias ls='ls -G'

# editor needs to be set for commits without -m
export EDITOR='emacs -nw'

# go stuff
command -v go &>/dev/null && {
    export GOPATH=~/go
    export PATH=$GOPATH/bin:$(go env GOROOT)/bin:$PATH
}

# ruby stuff
command -v ruby &>/dev/null && command -v gem &>/dev/null && {
    export PATH=$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH
}

# pip stuff -- curl artifactory to see if exists (0.05 should be fine)
curl -m 0.05 http://10.128.80.50:8081 &>/dev/null && {
    export PIP_INDEX_URL=http://10.128.80.50:8081/artifactory/api/pypi/pypi-virtual/simple
    export PIP_TRUSTED_HOST=10.128.80.50
}


###############################################################################
# zsh stuff
###############################################################################

# set window title and share pwd accross sessions
update_terminal_cwd() {
    local PWD_URL="file://$HOSTNAME${PWD// /%20}"
    printf '\e]7;%s\a' "$PWD_URL"
}

# prompt
PROMPT='%m:%1~ %n$ '
# in-place delete
bindkey '^[[3~'  delete-char
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
# cmd line completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
# batch rename
autoload -U zmv
# extended globbing but don't error on no match
setopt EXTENDED_GLOB
unsetopt NOMATCH
autoload -U add-zsh-hook
add-zsh-hook precmd update_terminal_cwd
add-zsh-hook preexec update_terminal_cwd
add-zsh-hook chpwd update_terminal_cwd
