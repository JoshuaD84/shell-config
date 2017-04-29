# Set important shell variables
   export EDITOR=vim                           # Set default editor
   export WORDCHARS=''                         # This is the oh-my-zsh default, I think I'd like it to be a bit different 
   export PAGER=less                           # Set default pager
   export LESS="-R"                            # Set the default options for less 
   export LANG="en_US.UTF-8"                   # I'm not sure who looks at this, but I know it's good to set in general
   export PASSWORD_STORE_DIR=".pass"   # Set the location of the encrypted password store for 'pass'
   export PASSWORD_STORE_CLIP_TIME=30          # Set how long a password clipped to the clipboard with 'pass' lasts
   export LESSHISTFILE="/dev/null"                    # Prevent the less hist file from being made, I don't want it
   export HISTFILE=~/.bash/cache/history

# Misc
   eval $(dircolors ~/.zsh/dircolors) #TODO: Fix this
   umask 002

# setup Prompts
   PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
   PS2=">";

# Aliases
   git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit" 

   alias ...='../..'
   alias ....='../../..'
   alias .....='../../../..'
   alias ......='../../../../..'
   alias .......='../../../../../..'
   alias ........='../../../../../../..'
   
   alias ls="ls -h --color='auto'"
   alias lsa='ls -A'
   alias ll='ls -l'
   alias la='ls -lA'
#   alias cdl=changeDirectory; function changeDirectory { cd $1 ; la }

   alias md='mkdir -p'
   alias rd='rmdir'

   # Search running processes. Usage: psg <process_name>
   alias psg="ps aux $( [[ -n "$(uname -a | grep CYGWIN )" ]] && echo '-W') | grep -i $1"

   # Copy with a progress bar
   alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --" 

   alias d='dirs -v | head -10'                      # List the last ten directories we've been to this session, no duplicates

# Setup grep to be a bit more nice
  # check if 'x' grep argument available
   grep-flag-available() {
         echo | grep $1 "" >/dev/null 2>&1
   }

   GREP_OPTIONS=""

   # color grep results
   if grep-flag-available --color=auto; then
         GREP_OPTIONS+=" --color=auto"
   fi

   # ignore VCS folders (if the necessary grep flags are available)
   VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

   if grep-flag-available --exclude-dir=.cvs; then
         GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
   elif grep-flag-available --exclude=.cvs; then
         GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
   fi

   # export grep settings
   alias grep="grep $GREP_OPTIONS"


