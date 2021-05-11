cd $(dirname $0)

source ../util.sh

rc_file="$HOME/.bashrc"
sh_file="$(pwd)/fzf.sh"
lno=""

if [ "$(uname)" = "Darwin" ]; then # Fix for Mac
        rc_file="$HOME/.bash_profile"
fi

lines=()
lines+=('eval "$(thefuck --alias fuck)"')

for line in "${lines[@]}"; do
    check_and_add_line_to_file "$line" "$rc_file"
done

