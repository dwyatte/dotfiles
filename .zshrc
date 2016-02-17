# Your previous .profile  (if any) is saved as .profile.mpsaved

# activate venv, otherwise create and activate
venv() {
    if [ ! -d venv ]; then
	virtualenv venv
    fi
    source venv/bin/activate
}

# Tell the terminal about the working directory at each prompt.
update_terminal_cwd() {
    if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
        local PWD_URL="file://$HOSTNAME${PWD// /%20}"
        printf '\e]7;%s\a' "$PWD_URL"
    fi
}

# aliases
alias ls='ls -G'

# editor needs to be set for commits without -m
export EDITOR=emacs

# spark
export JAVA_HOME=$(/usr/libexec/java_home)
export SPARK_HOME=/usr/local/Cellar/apache-spark/1.5.1/libexec
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip:$PYTHONPATH

####################
# zsh stuff
####################
# prompt
PROMPT='%m:%1~ %n$ '
# zsh history
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
history() { builtin history 1 } # make history behave like bash's
bindkey '^[[A' up-line-or-search # history completion w/ up
bindkey '^[[B' down-line-or-search # history completion w/ down
bindkey '^[[3~'  delete-char # in-place delete
# cmd line completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
# batch rename
autoload -U zmv
# extended globbing but don't error on no match
setopt EXTENDED_GLOB
unsetopt NOMATCH
# set window title and share pwd accross sessions
precmd() { update_terminal_cwd }