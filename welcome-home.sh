#!/bin/bash

odf="old_dotfiles"
noask=false

blacklist=". .. .git .gitignore"

#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#echo $DIR
#echo `basename $0`
#echo ${PWD##*/}


if [ -d ~/$odf ]; then
	echo "[ ! ] old dotfiles directory exists"
else
	echo "[...] creating old dotfiles directory"
	mkdir -p ~/$odf
fi

for f in .*
do
	#printf "%s" ${f:0:2}
	#if [ $f = "."  -o  $f = ".." -o $f = ".git" -o $f = ".gitignore" ]; then
	#if [[ $blacklist =~ $f ]]; then
	
	for bl in $blacklist
	do
		[ $f = $bl ] && continue 2
		
	done
	
	if [ $noask = "false" ]; then
		read -p "$f verlinken? (y/n/a): " -n 1 confirm
		echo

		case $confirm in
			a|A)
				noask=true
				;;
			y|Y) 
				;;
			n|N|*)
				echo "[ ! ] skipping $f"
				continue
				;;
		esac
	fi
	
	if [ -e ~/$f ]; then
		echo "[...] move old dotfile to $odf"
		mv ~/$f ~/$odf/
	else
		echo "[ ! ] ~/$f doesn't exist. skipping mv"
	fi
	
	echo "[...] create symlink"
	ln -s ${PWD}/$f ~/$f

done
