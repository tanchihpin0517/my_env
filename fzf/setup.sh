cd $(dirname $0)

source ../util.sh

$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-zsh --no-fish
echo

rc_file="$HOME/.bashrc"
sh_file="$(pwd)/fzf.sh"
lno=""

if [ "$(uname)" = "Darwin" ]; then # Fix for Mac
        rc_file="$HOME/.bash_profile"
fi

lines=()
lines+=("[ -f ~/.fzf.bash ] && source ~/.fzf.bash")
lines+=("[ -f $sh_file ] && source $sh_file")

for line in "${lines[@]}"; do
    check_and_add_line_to_file "$line" "$rc_file"
done

