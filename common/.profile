# Path
export PATH="$PATH:$HOME/.local/bin"

# Misc
export LANG=en_US.utf8
export NNTPSERVER="news.epita.fr"
export DOT_PATH="$HOME/.config/.dotfiles/"

export EDITOR="$(which vim)"
export TERM=rxvt-unicode-256color
export WALLPAPERS_PATH="$HOME/.config/wallpapers"
# export GOPATH=$AFS_DIR/TP/murrig_s/go

# Color support for less
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;35;1;146m' # begin underline

# ssh-agent

SSH_ENV="$HOME/.ssh/env"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/# echo/' > "${SSH_ENV}"
     echo "Succeeded"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     # ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi
