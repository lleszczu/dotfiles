#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
EDITOR=/usr/bin/vim
VISUAL=/usr/bin/vim
export EDITOR
export VISUAL
if [[ ! -n $TMUX ]];then
	export TERM=xterm-256color
else
	export TERM=screen-256color
fi

export PATH=$PATH:/data/bin

source /usr/local/bin/virtualenvwrapper.sh
source /etc/zsh_command_not_found
source /etc/docker_completion

lrc(){
    start=$(date +%s)
    "$@"
    [ $(($(date +%s) - start)) -le 5 ] || notify-send "Notification" "Long\
 	running command \"$(echo $@)\" took $(($(date +%s) - start)) seconds to finish"
}
# support for sudo + aliases from http://www.zsh.org/mla/users/2008/msg01229.html
alias sudo='noglob do_sudo '
function do_sudo
{
	integer glob=1
	local -a run
	run=( command sudo )
	if [[ $# -gt 1 && $1 = -u ]]; then
		run+=($1 $2)
		shift ; shift
	fi
	(($# == 0)) && 1=/bin/zsh
	while (($#)); do
		case "$1" in
			command|exec|-) shift; break ;;
			nocorrect) shift ;;
			noglob) glob=0; shift ;;
			*) break ;;
		esac
	done
	if ((glob)); then
	    PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $~==*
	else
		PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $==*
	fi
}


alias nsudo='nocorrect sudo'
alias lxc-ls='lxc-ls --fancy'
alias ll='ls -alh --color=auto'