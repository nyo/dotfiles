# --- if not running interactively, don't do anyting (for scp) --- #
[[ $- != *i* ]] && return

# --- set aliases --- #

alias vi="vim"
alias open="xdg-open"
alias ls="ls -1 --color=always"
alias grep="grep --color=always"
alias upd="sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade"
alias diff="colordiff -y"
alias cat="tabs 4; cat"
alias man="_colorman man"
alias monip="_monip"
alias path="_path"

# --- prompt(s) --- #

# export PS1="[\u@\h \w]\$ "
# export PS1="[$0 \w]\$ "
export PS1="\[\033[38;5;231m\][\[\033[0m\]\[\033[38;5;250m\]\u@\h \w\[\033[0m\]]\[\033[38;5;231m\]\[\033[0m\]\[\033[38;5;141m\]\$ \[\033[0m\]"

# --- environment entries --- #

export TERM="xterm-256color";
export EDITOR="vim"
export HISTCONTROL="ignoreboth" # don't put duplicate lines & those starting with space in the history
export HISTSIZE="10000"
export HISTFILESIZE="20000"
export HISTTIMEFORMAT="%d/%m/%Y %T  " # display timestamp in history
export LESS="--RAW-CONTROL-CHARS" # get color support for `less`
export LS_COLORS="di=32:ln=35:so=34:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43" # geoff.greer.fm/lscolors/
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
export GREP_COLOR="1;41"
export MULLVAD_USE_GTK3="yes" # mullvad client support

# --- shell optional behavior --- #

shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # check & resize LINES and COLUMNS after each command if needed

# --- more color support & custom functions --- #

function _colorman() {
	env 									\
	LESS_TERMCAP_mb=$(printf "\e[1;35m")	\
	LESS_TERMCAP_md=$(printf "\e[1;34m")	\
	LESS_TERMCAP_me=$(printf "\e[0m")		\
	LESS_TERMCAP_se=$(printf "\e[0m")		\
	LESS_TERMCAP_so=$(printf "\e[7;40m")	\
	LESS_TERMCAP_ue=$(printf "\e[0m")		\
	LESS_TERMCAP_us=$(printf "\e[1;33m")	\
	"$@"
}

#function _colorcat() {
#	[ $# -eq 0 ] && { tabs 4; cat; exit 0; }
#	for file in "$@"; do
#		source-highlight --input="$file" --output="STDOUT" --out-format="esc256" --tab="4" 2>/dev/null || tabs 4; cat $file;
#	done
#}

function _monip() {
	echo -n "loading public ip..."
	ip=$(curl -s "https://api.ipify.org?format=json" | python -c "import sys, json; print json.load(sys.stdin)['ip']")
	echo -en "\e[2K\r"
	echo "$ip"
}

function _path() {
	echo "$(pwd)/$1"
}
