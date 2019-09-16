cd $(dirname $0)

source ../util.sh

check_and_link "$PWD/.tmux.conf" "$HOME/.tmux.conf"
