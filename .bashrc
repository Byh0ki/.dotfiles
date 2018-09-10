[[ $- != *i* ]] && return
#cddcd
# Base16 Shell
#BASE16_SHELL="$AFS_DIR/.confs/base16-shell/"
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export LANG=en_US.utf8
export NNTPSERVER="news.epita.fr"

export EDITOR=vim
export TERM=xterm-256color
export GOPATH=$AFS_DIR/TP/murrig_s/go

#Alias
alias ls='ls --color=auto'
alias atom='~/$AFS_DIR/atom/./atom'
alias la='ls -a'
alias l='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias color='$AFS_DIR/.confs/base16-shell/./colortest'
alias gdb='gdb -g'

#Alias Git
alias gc='git commit -v'
alias gcm='git commit -v -m'
alias gcam='git commit -v -a -m'
alias gss='git status -s'
alias gp='git push'
alias gccf='gcc -Wall -Wextra -Werror -pedantic -std=c99'

#Prompt
#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;93m\][\D{%d/%m/%y} \t]\[\033[01;34m\] \u\[\033[01;00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
