#exclusion=".git,.idea"
#export FZF_DEFAULT_COMMAND="fd --hidden --exclude={$exclusionj}"
export FZF_DEFAULT_COMMAND="fd -H . . 2> /dev/null"
#export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -50'"
#export FZF_CTRL_T_COMMAND="fd --hidden --exclude={$exclusion}"
export FZF_CTRL_T_COMMAND="fd -H . . 2> /dev/null"
#export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -50'"
#export FZF_ALT_C_COMMAND="fd --hidden --type d --full-path '/'"
export FZF_ALT_C_COMMAND="fd -H --type d . / 2> /dev/null"

FZF_PATH="$(which fzf)"

fzf() {  # fzf [opts] [path]
    local result=""
    local path=""
    local opt=""

    if [[ -z $@ ]]; then
        path="."
    else
        if [[ $# -eq 1 ]]; then
            path=$@
        else
            local let num_opt=$#-1
            path=${@: -1}
            opt=${@:1:$num_opt}
        fi
    fi

    if [[ -t 0 ]]; then
        result=$(fd -H $opt . $path 2>/dev/null | $FZF_PATH)
    else
        result=$($FZF_PATH < /dev/stdin)
    fi
    echo $result
}

fcd() {  # fcd [path]
    local path=$1

    if [[ -z $path ]]; then
        path="."
    fi

    if [[ -d $path ]]; then
        cd $(fzf --type d $path)
    else
        echo "bash: fcd: $path: Not a directory"
    fi
}
