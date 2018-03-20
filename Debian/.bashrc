#
# ~/.bashrc
#

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# enable xterm support for 256 colors if disabled
if [ "$TERM" = xterm ]; then
	TERM=xterm-256color;
fi

#	PRINTS "WELCOME" MESSAGES
echo ""
echo "	▄▄▄·  ▐ ▄  ▄· ▄▌                         "
echo "	▐█ ▀█ •█▌▐█▐█▪██▌▪              \    /\  "
echo "	▄█▀▀█ ▐█▐▐▌▐█▌▐█▪ ▄█▀▄           )  ( ') "
echo "	▐█ ▪▐▌██▐█▌ ▐█▀·.▐█▌.▐▌         (  /  )  "
echo "	 ▀  ▀ ▀▀ █▪  ▀ •  ▀█▄▀▪ @ debian \(__)|  "
echo ""
# fonts from patorjk.com/software/taag/
# doom, isometric3, small isometric1, delta corps priest 1, elite, colossal

#	PROMPT BEHAVIOR
export PS1='[\u@\h \W]\$ '

#	SET ALIASES
alias ls='ls -1 --color=always'
alias upd="sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade"
alias grep='grep --color=always'

#	SET AND/OR ADD ENVIRONMENT VARIABLE
export EDITOR=vim # set `vim` as the default text editor

export LESS="--RAW-CONTROL-CHARS" # get color support for `less`
export LS_COLORS='di=32:ln=35:so=34:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43' # change default color for `ls` (geoff.greer.fm/lscolors/)
export GREP_COLOR='1;41' # change default color for `grep`

# don't put duplicate lines or lines starting with space in the history
export HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colors for `man` pages
function _colorman() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;35m") \
    LESS_TERMCAP_md=$(printf "\e[1;34m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[7;40m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;33m") \
      "$@"
}
function man() { _colorman man "$@"; }
