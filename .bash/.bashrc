#if [ -f /etc/bashrc ]; then
#       . /etc/bashrc   # --> Read /etc/bashrc, if present.
#fi

export JAVA_HOME=/usr/local/jdk
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/classes.zip
export PATH="$PATH:/usr/local/bin:/usr/X11R6/bin"
export EDITOR=vim
export PAGER=less
export LESS="-R"
export LANG="en_US.UTF-8"
export WORDCHARS=''

backup="dharaweb@backup1.server.dhamma.org"

#Define a few Color's
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NOCOLOR='\e[0m'              # No Color


#-------------------
#setup Prompts
#-------------------

PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
#PS1="\[${LIGHTGREEN}\][\u@\h \w ]\[${NOCOLOR}\]$ ";
PS2=">";
#-------------------
# Personnal Aliases
#-------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'

alias less='less -R'
# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -Al'               # show hidden files
alias ls='ls -hF --color'	# add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time  
alias lu='ls -lur'		# sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias tree='tree -Csu'		# nice alternative to 'ls'
alias vi='vim'
if [ -d ~/.vim74 ]; then
	alias vi='~/.vim74/bin/vim'
fi

if [ -e ~/.dir_colors ]; then
	eval `dircolors ~/.dir_colors`
fi
