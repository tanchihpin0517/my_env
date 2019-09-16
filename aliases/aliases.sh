alias htop='htop -d 5'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias reload='bash -l; exit'
alias grep='grep --color=auto'
alias tmux='TERM=xterm-256color tmux'
alias ta='tmux attach'
alias tls="tmux ls"
alias tree='tree -al'
alias sshhome='ssh 59.127.236.158'
alias sshmac="ssh screamapple.csie.ncku.edu.tw"
alias sshpiano="ssh screampiano.csie.ncku.edu.tw"
alias sshviolin="ssh screamviolin.csie.ncku.edu.tw"
alias sshviola="ssh screamviola.csie.ncku.edu.tw"
alias sshcello="ssh screamcello.csie.ncku.edu.tw"
alias vim="nvim"

if [ "$(uname)" = "Darwin" ]; then # Fix for Mac
    alias ls='ls -G'
fi
