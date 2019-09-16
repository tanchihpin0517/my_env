bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

PS_NO_COLOR="\[\033[0m\]"
PS_GRAY="\[\e[01;30m\]"
PS_RED="\[\033[0;31m\]"
PS_GREEN="\[\033[01;32m\]"
PS_YELLOW="\[\033[0;33m\]"
PS_BLUE="\[\033[01;34m\]"
PS_MAGENTA="\[\e[01;35m\]"
PS_CYAN='\[\e[00;36m\]'
PS_WHITE='\[\e[01;37m\]'

PS_INFO="$PS_GREEN\u@\h$PS_NO_COLOR:$PS_BLUE\w"
PS_GIT="$PS_YELLOW\$(__ps_parse_git_branch)"
PS_TIME="\[\033[\$((COLUMNS-21))G\] $PS_WHITE[\D{%Y-%m-%d %H:%M:%S}]"
PS_TIME_ONLY_DATE="\[\033[\$((COLUMNS-21))G\] $PS_WHITE[\D{%Y-%m-%d --:--:--}]"

function __ps_parse_git_branch {
    local branch=''
    if [ -d .svn ]; then
        branch="(svn r$(svn info|awk '/Revision/{print $2}'))"
        return
    elif [ -f _FOSSIL_ -o -f .fslckout ]; then
        branch="(fossil $(fossil status|awk '/tags/{print $2}')) "
        return
    fi
    local ref=''
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    branch="(${ref#refs/heads/})"
    echo $branch
}

case "$-" in *i*)
    PS1_ELEMENTS=(
        "${PS_INFO} ${PS_GIT}\n"
        "${PS_YELLOW}\$${PS_NO_COLOR} "
    )
    PS1=$(IFS=; echo "${PS1_ELEMENTS[*]}")

    PS2_ELEMENTS=(
        "${PS_YELLOW}> ${PS_NO_COLOR}"
    )
    PS2=$(IFS=; echo "${PS2_ELEMENTS[*]}")
esac
