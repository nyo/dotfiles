# enable xterm support for 256 colors if disabled
if [ "$TERM" = xterm ]; then
	TERM=xterm-256color;
fi

#	PRINT "WELCOME" MESSAGE
echo ""
echo "	▄▄▄·  ▐ ▄  ▄· ▄▌                         "
echo "	▐█ ▀█ •█▌▐█▐█▪██▌▪              \    /\  "
echo "	▄█▀▀█ ▐█▐▐▌▐█▌▐█▪ ▄█▀▄           )  ( ') "
echo "	▐█ ▪▐▌██▐█▌ ▐█▀·.▐█▌.▐▌         (  /  )  "
echo "	 ▀  ▀ ▀▀ █▪  ▀ •  ▀█▄▀▪ @ Debian \(__)|  "
echo ""
# fonts from patorjk.com/software/taag/
# eg. doom, isometric3, small isometric1, delta corps priest 1, elite, colossal

#	SET ALIASES
alias vi='vim'
alias ls='ls -1 --color=always'
alias upd='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
alias diff='colordiff -y'
alias grep='grep --color=always'

#	SET ENVIRONMENT ENTRIES
export PS1='[\u@\h \W]\$ '
export LESS='--RAW-CONTROL-CHARS' # get color support for `less`
export EDITOR='vim'
export LS_COLORS='di=32:ln=35:so=34:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43' # see: geoff.greer.fm/lscolors/
export GREP_COLOR='1;41'
export HISTCONTROL='ignoreboth' # don't put duplicate lines/lines starting with space in the history
export HISTSIZE='1000' # set history lenght
export HISTFILESIZE='2000' # set history file lenght
export HISTTIMEFORMAT="%Y%m%d %T  " # display timestamp in history

#	SET SHELL OPTIONAL BEHAVIOR
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # check the window size after each command & update the values of LINES and COLUMNS.

#	ENABLE COLORS FOR `man` PAGES
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
