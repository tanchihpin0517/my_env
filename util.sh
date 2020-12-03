check_and_add_line_to_file() {
    local line=$1
    local rc_file=$2
    local lno=""

    echo "Update $rc_file:"
    echo "- $line"
    if [ -f "$rc_file" ]; then
        lno=$(\grep -nF "$line" "$rc_file" | sed 's/:.*//' | tr '\n' ' ')
    fi
    if [ -n "$lno" ]; then
        echo "- Already exists: line #$lno"
    else
        echo "$line" >> "$rc_file"
    fi
}

check_and_link() {
    local from=$1
    local to=$2

    if [ -L $to ]; then
        echo "Warning: $to exists"
    fi

    echo "Link $from to $to..."
    ln -sf $from $to
}

source_rc_file() {
    rc_file="$HOME/.bashrc"
    if [ "$(uname)" = "Darwin" ]; then # Fix for Mac
        rc_file="$HOME/.bash_profile"
    fi

    source $rc_file
}
