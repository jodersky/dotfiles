export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    local EXIT="$?"
    PS1=""
    PS1+="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"

    local red='\[\033[0;31m\]'
    local green='\[\033[0;32m\]'
    local light_green='\[\033[01;32m\]'
    local light_blue='\[\033[01;34m\]'
    local reset='\[\033[0m\]'

    PS1+="╭"

    if [ "$EXIT" -eq 0 ]; then
	PS1+="${green}(✔)${reset} "
    else
	PS1+="${red}(✗)${reset} "
    fi

    PS1+="${debian_chroot:+($debian_chroot)}${light_green}\u@\h${reset}:${light_blue}\W${reset}"

    ### Add Git Status ###
    ## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
    if [[ $(command -v git) ]]; then
	local git_status="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"

	if [ "$git_status" ]; then
	    local git_color="${reset}"
	    ### Test For Changes ###
	    ## Change this to test for 'ahead' or 'behind'!
	    local git_changed="$(echo ${git_status} | tr ':' '\n' | grep -v "^$" | grep -v "^\#\#" | wc -l | tr -d ' ')"
	    if [ "$git_changed" == "0" ]; then
		git_color="${green}"
	    else
		git_color="${red}"
	    fi

	    ### Find Branch ###
	    local git_branch="$(echo ${git_status} | tr ':' '\n' | grep "^##" | cut -c4-)"
	    PS1+=" ${git_color}[${git_branch}]${reset}"
	fi
    fi

    if [ "$EXIT" -ne 0 ]; then
	PS1+=" ${red}(exit $EXIT)${reset}"
    fi

    PS1+="\n╰\$ ${reset}"
}
