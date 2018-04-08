# enable xterm support for 256 colors if disabled
if [ "$TERM" = xterm ]; then
	TERM=xterm-256color;
fi

#	SET ALIASES
alias vi='vim'
alias ls='ls -1'
alias grep='grep --color=always'

#	SET ENVIRONMENT ENTRIES
export PS1='\[\033[38;5;147m\][\[\033[38;5;187m\]\u@\h \W\[\033[38;5;147m\]]\$ \[\033[0m\]'
export LESS='--RAW-CONTROL-CHARS'
export EDITOR='vim'
export CLICOLOR='1'
export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
# export GREP_COLOR="1;46"
export HISTCONTROL='ignoreboth'
export HISTSIZE='1000'
export HISTFILESIZE='2000'
export PATH="$PATH:$HOME/.brew/bin"
# export PATH="$PATH:/opt/vagrant/bin:/Applications/VirtualBox.app/Contents/MacOS"
# export VAGRANT_HOME="~/goinfre"
# export VAGRANT_DEFAULT_PROVIDER="virtualbox"

#	SET SHELL OPTIONAL BEHAVIOR
shopt -s histappend
shopt -s checkwinsize

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

#	SPAWN IN DIRECTORY PROJECT I'M CURRENTLY WORKING ON
cd ~/Documents/
