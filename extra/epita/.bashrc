export PATH=$PATH:/home/murrig_s/.local/bin

[[ $- != *i* ]] && return

# Base16 Shell
BASE16_SHELL="$AFS_DIR/.confs/base16-shell/"
#BASE16_SHELL="$HOME/.config/base16-shell/"
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
alias atom='$AFS_DIR/Divers/bin/atom/./atom'
alias la='ls -a'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias md='mkdir -p'
alias color='$AFS_DIR/.confs/base16-shell/./colortest'
alias gdb='gdb -q'

#Alias Path
alias .dot='cd $AFS_DIR/Divers/.dotfiles/'
alias p='cd $AFS_DIR/Dev/p2021'
alias alg='cd $AFS_DIR/Dev/algo/'
alias mri='cd $AFS_DIR/Dev/myreadiso/murrig_s-myreadISO/'
alias mf='cd $AFS_DIR/Dev/myfind/murrig_s-myfind'
alias mll='cd $AFS_DIR/Dev/malloc/murrig_s-malloc'
alias f1='cd $AFS_DIR/Dev/f1/murrig_s-formula-one'
alias ray='cd $AFS_DIR/Dev/raytracer/stanislas.sokolov-raytracer/'
alias rc='cd $AFS_DIR/Dev/rushc/murrig_s-rush_c/'

#Alias Git
alias gc='git commit -v'
alias gcm='git commit -v -m'
alias gcam='git commit -v -a -m'
alias gss='git status -s'
alias gp='git push'
alias gpl='git pull'
alias gsl='git shortlog'
alias gll='git log --oneline'
alias gls='git ls-files'
alias gccf='gcc -Wall -Wextra -Werror -pedantic -std=c99'

# Color support for less
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;35;1;146m' # begin underline

#Prompt
#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;93m\][\t]\[\033[01;34m\] \u\[\033[01;00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
