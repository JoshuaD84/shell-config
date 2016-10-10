#!/usr/bin/zsh

source ~/.zshrc

statusline='$FX[bold]$fg_text$bg_name$spad%n$spad$fg_name$bg_comp$split$fg_text$spad@%m$spad$fg_comp$bg_dir$split$fg_text$spad%~$spad$fg_dir$(git_status)$bg_bar$split'

text=`eval echo $statusline`

clean=`echo $text | sed -e 's/%{//g' -e 's/%}//g'`  

finished=${(%):-$clean}  

nocolor=`echo $finished | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"`

count=`echo "$nocolor" | wc -m` 

(( spacecount = COLUMNS - count + 1 ))

spaces=`printf '%*s\n' $spacecount | tr ' ' ' '`

echo "$finished$spaces"

