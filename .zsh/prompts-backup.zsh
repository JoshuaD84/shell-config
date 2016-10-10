#/usr/bin/zsh
#if we're in a situation where we don't want colors
#these variables aren't initialized and
#so they don't have any impact on prompt definitions

if [[ "$TERM" != "dumb" ]]; then
  local reset="%{$reset_color%}"
  local fg_text="$FG[232]"
  local fg_black="$FG[232]"
  local fg_error="$FG[124]"
  local bg_time="$BG[056]"
	
  local name=027;       local fg_name="$FG[$name]";      local bg_name="$BG[$name]"
  local comp=070;       local fg_comp="$FG[$comp]";      local bg_comp="$BG[$comp]"
  local dir=117;        local fg_dir="$FG[$dir]";        local bg_dir="$BG[$dir]" 
  local git=105;        local fg_git="$FG[$git]";        local bg_git="$BG[$git]"
  local bar=240;        local fg_bar="$FG[$bar]";        local bg_bar="$BG[$bar]"
  local jobs=117;       local fg_jobs="$FG[$jobs]";      local bg_jobs="$BG[$jobs]"
  local clock=249;      local fg_clock="$FG[$clock]";    local bg_clock="$BG[$clock]"
    
  local prompt=166
  local prompt_root=124
  local fg_prompt="%(!.$FG[$prompt_root].$FG[$prompt])"
  local bg_prompt="%(!.$BG[$prompt_root].$BG[$prompt])"
  
  local git_icon="?"
  local split="$FX[no-bold]?$FX[bold]"
  local spad=" "  
  local indicator="$split"

else
  local indicator=">"

fi

local newline=$'\n'                                  #inlining $'\n' doesn't work for some reason
local return_status="%(?. .$fg_error ?$newline)"     #Setup the return status indicator
ZLE_RPROMPT_INDENT=0                                 #get rid of the indent on the right-prompt
setopt prompt_subst                                  #make sure we get color substitution

#now setup the prompts
#PROMPT='$return_status$newline$FX[bold]$fg_text$bg_name$spad%n$spad$fg_name$bg_comp$split$fg_text$spad@%m$spad$fg_comp$bg_dir$split$fg_text$spad%~$spad$fg_dir$(git_status)$bg_bar$split%E$newline$reset$bg_prompt$spad$reset$fg_prompt$indicator$reset '

PROMPT='$return_status$newline$FX[bold]$fg_text$bg_name$spad%n$spad$fg_name$bg_comp$split$fg_text$spad@%m$spad$fg_comp$bg_dir$split$fg_text$spad%~$spad$fg_dir$(git_status)$bg_bar$split%E$newline$reset$bg_prompt$spad$reset$fg_prompt$indicator$reset '

RPROMPT='$FX[bold]$fg_black$(jobs_status)$bg_clock$split$spad$fg_text${timec}%D{%L:%M:%S %p} $FX[no-bold]$reset' 

PROMPT2='$reset$bg_prompt %_$spad$reset$fg_prompt$indicator$reset '

RPROMPT2=''

PROMPT3='$reset$bg_prompt ?#$spad$reset$fg_prompt$indicator$reset '

PROMPT4='$reset$bg_prompt +%N:%i$spad$reset$fg_prompt$indicator$reset '

SPROMPT="zsh: correct '%R' to '%r' [nyae]?" #this is the default, and I like it

TIMEFMT=`echo "$newline$fg_time$bg_time %J  %*Es (%P cpu) $reset" | sed -e 's/%{//g' -e 's/%}//g'`

#todo: set a simpler version for when I'm on dhamma dhara
#RPROMPT="$bgc${timec}[%D{%L:%M:%S %p}]$reset"
#PROMPT="$FX[bold]$newline$bgc$userc%n $machinec@%m $dirc%~ $(git_status)%E$newline$reset$cyan$FX[bold]> $reset"

#tells us how many jobs are in the background
function jobs_status() {
  count=$((jobs -s) | wc -l)
  if [[ $count -ne "0" ]]; then
    echo "$bg_jobs$split$fg_text $count $fg_jobs"
  fi
}

function git_status() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) 
    if [[ -z $ref ]]; then
    echo ""
  else 
     echo "$bg_git$split$fg_text $git_icon ${ref#refs/heads/}$(git_icons) $fg_git"
  fi
}

function git_icons() {
  #TODO: https://git-scm.com/docs/git-status
  #use these statuses to make more information
  local git_status="$(git status --porcelain 2> /dev/null)"
  if [[ -n "$git_status" ]]; then
    echo "*"
  fi

}


#Cool utf characters: ? ? ? ? ? ? ? ? ? ? ? ? - ? 

#Got this from ze-best-zsh-theme. Look at it in more detail
#function git_prompt_info {
#  local ref=$(=git symbolic-ref HEAD 2> /dev/null)
#  local gitst="$(=git status 2> /dev/null)"
#
#  if [[ -f .git/MERGE_HEAD ]]; then
#    if [[ ${gitst} =~ "unmerged" ]]; then
#      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
#    else
#      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
#    fi
#  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
#    gitstatus=" %{$fg[blue]%}!%{$reset_color%}"
#  elif [[ ${gitst} =~ "use \"git add" ]]; then
#    gitstatus=" %{$fg[red]%}!%{$reset_color%}"
#  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
#    gitstatus=" %{$fg[yellow]%}*%{$reset_color%}"
#  else
#    gitstatus=''
#  fi
#
#  if [[ -n $ref ]]; then
#    echo "%{$fg_bold[green]%}/${ref#refs/heads/}%{$reset_color%}$gitstatus"
#  fi
#}

