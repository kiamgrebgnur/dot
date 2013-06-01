alias ..='cd ..'
alias ...='cd ../..'


#cp and mv with progress bar

alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"


alias ktint="killall tint2 && sleep 2 && noh tint2"

function remindme()
{
	if [ $# = 0 ]
	then
		echo "remindme <time/sec> <msg>"
	else
		sleep $1 && zenity --info --text "$2" &
	fi
}

# git
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function noh {
	nohup $1 >/dev/null 2>&1 &
}

gitst='\[\033[1;31m\]$(parse_git_branch)\[\033[0m\]'


export PS1="$PS1$gitst\[\e[1;32m\]\$\[\e[m\]\[\e[0;30m\] "
