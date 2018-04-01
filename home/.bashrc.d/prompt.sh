export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    local exit="$?"
    PS1=""
    # set title for terminal emulators
    PS1+="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"

    local red='\[\e[31m\]'
    local green='\[\e[32m\]'
    local light_green='\[\e[92m\]'
    local light_blue='\[\e[94m\]'
    local reset='\[\e[0m\]'

    PS1+="╭"

    if [ "$exit" -eq 0 ]; then
	PS1+="${green}(✔)${reset} "
    else
	PS1+="${red}(✗)${reset} "
    fi

#    if [[ $(command -v kubectl) ]]; then
#	PS1+="[$(kubectl config current-context)] "
#    fi

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

    if [ "$exit" -ne 0 ]; then
	PS1+=" ${red}(exit $exit)${reset}"
    fi

    PS1+="\n╰\$ ${reset}"
}
