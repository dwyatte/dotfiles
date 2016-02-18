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

# ls colors for bsd/linux
ls --color &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# editor needs to be set for commits without -m
export EDITOR='emacs -nw'

# go stuff
export GO15VENDOREXPERIMENT=1
export PATH=$(go env GOROOT)/bin:$PATH
export GOPATH=~/go


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
HISTSIZE=1000
SAVEHIST=1000
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
