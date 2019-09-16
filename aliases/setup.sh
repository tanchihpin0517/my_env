cd $(dirname $0)

source ../util.sh

rc_file="$HOME/.bashrc"
sh_file="$(pwd)/aliases.sh"
line="[ -f $sh_file ] && source $sh_file"

if [ "$(uname)" = "Darwin" ]; then # Fix for Mac
    rc_file="$HOME/.bash_profile"
fi

check_and_add_line_to_file "$line" "$rc_file"
