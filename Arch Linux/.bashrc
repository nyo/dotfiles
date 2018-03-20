#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prints welcome message
echo ""
echo "	▄▄▄·  ▐ ▄  ▄· ▄▌				"
echo "	▐█ ▀█ •█▌▐█▐█▪██▌▪                 \    /\	"
echo "	▄█▀▀█ ▐█▐▐▌▐█▌▐█▪ ▄█▀▄              )  ( ')	"
echo "	▐█ ▪▐▌██▐█▌ ▐█▀·.▐█▌.▐▌            (  /  )	"
echo "	 ▀  ▀ ▀▀ █▪  ▀ •  ▀█▄▀▪ @ archlinux \(__)|	"
echo ""
# Fonts from patorjk.com/software/taag/
# Doom, Isometric3, Small Isometric1, Delta Corps Priest 1, Elite, Colossal

# Prompt behavior
PS1='[\u@\h \W]\$ '

# Set aliases
alias open='xdg-open'
alias ls='ls -1 --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Set env changes
export EDITOR=vim

# Mouse sensitivity/acceleration changes
xset m 1/1 0
xinput -set-prop 10 'libinput Accel Speed' 0
xinput -set-prop 11 'libinput Accel Speed' 0

# Keyboard changes (us-intl)
setxkbmap -layout us -variant intl -option us-intl

# Don't put duplicate lines in the history... or force ignoredups and ignorespace
# + for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000
shopt -s histappend # append to the history file, don't overwrite it
