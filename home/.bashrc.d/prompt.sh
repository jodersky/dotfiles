function show_duration() {
    local seconds=$1
    local minutes=0
    local hours=0
    if [[ $seconds -ge 60 ]]; then
        minutes=$((seconds / 60))
        seconds=$((seconds % 60))
        if [[ $minutes -ge 60 ]]; then
            hours=$((minutes / 60))
            minutes=$((minutes % 60))
        fi
    fi
    if [[ $minutes -eq 0 && $hours -eq 0 ]]; then
        echo "${seconds}s"
    elif [[ $hours -eq 0 ]]; then
        echo "${minutes}m${seconds}s"
    else
        echo "${hours}h${minutes}m${seconds}s"
    fi
}

function __pre_command() {
    if [[ -z $__at_prompt ]]; then
        return
    fi
    unset __at_prompt

    __command_start_stamp=$SECONDS
}
trap __pre_command DEBUG

function __prompt_command() {
    local exit="$?"
    local duration_seconds="$(( SECONDS-__command_start_stamp ))"
    local now
    now="$(date +%H:%M:%S)"
    PS1=""
    # set title for terminal emulators
    PS1+="\\[\\e]0;\\u@\\h: \\w\\a\\]"

    local red='\[\e[31m\]'
    local green='\[\e[32m\]'
    local yellow='\[\e[33m\]'
    local light_blue='\[\e[94m\]'
    local orange='\[\e[38;5;208m\]'
    local reset='\[\e[0m\]'

    PS1+="╭"

    if [[ -n $SSH_CONNECTION ]]; then
        PS1+="${orange}(\\h)${reset}"
    fi

    PS1+="${light_blue}\\w${reset}"

    ### Add Git Status
    ## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
    if [[ $(command -v git) ]]; then
        local git_status
        if git_status="$(git status --porcelain=2 2>/dev/null)"; then
            if [[ -z $git_status ]]; then
                git_color="${green}"
            else
                git_color="${yellow}"
            fi
            git_status="$(git status --porcelain=2 --branch 2>/dev/null)"

            local git_branch
            git_branch="$(echo "$git_status" \
                            | sed --quiet 's/# branch.head //p' - )"
            PS1+=" ${git_color}["
            if [[ $git_branch == "(detached)" ]]; then
                PS1+="$(git rev-parse --short HEAD)"
            else
                PS1+="${git_branch}"
            fi
            PS1+="]${reset}"

            local git_ab
            git_ab="$(echo "$git_status" \
                            | sed --quiet 's/# branch.ab //p' - )"

            if [[ $git_ab = "" ]]; then
                true
            elif [[ $git_ab = "+0 -0" ]]; then
                PS1+=" ${green}[0]${reset}"
            elif [[ $git_ab != "+0 -0" ]]; then
                local git_a
                git_a=$(echo "$git_ab" | cut -d' ' -f 1 )
                local git_b
                git_b=$(echo "$git_ab" | cut -d' ' -f 2 )

                if [[ $git_a != "+0" && $git_b != "-0" ]]; then
                    # diverged
                    PS1+=" ${red}[${git_ab}]${reset}"
                elif [[ $git_a != "+0" ]]; then
                    PS1+=" ${yellow}[${git_a}]${reset}"
                elif [[ $git_b != "-0" ]]; then
                    PS1+=" ${yellow}[${git_b}]${reset}"
                fi
            fi
        fi
    fi

    if [[ $(which python3) =~ $HOME/venvs/.* ]]; then
        local venv
        venv=$(which python3 | sed 's|.*/venvs/\(\w*\)/.*|\1|')
        PS1+=" ${orange}[venv:$venv]${reset}"
    fi

    if [[ $exit -ne 0 ]]; then
        PS1+=" ${red}(exit $exit)${reset}"
    fi

    if [[ $duration_seconds -ge 10 ]]; then
        PS1+=" ${light_blue}($(show_duration "$duration_seconds") $now)${reset}"
    fi

    PS1+="\\n╰\$ ${reset}"
    __at_prompt=1
}

export PROMPT_COMMAND=__prompt_command
