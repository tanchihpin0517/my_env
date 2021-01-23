cd $(dirname $0)

source ./util.sh

packages+=" tcl-tk python@3.8 llvm"
packages+=" cmake"
packages+=" tree htop"
packages+=" tmux tmux-mem-cpu-load"
packages+=" vim nvim node"
packages+=" fzf fd"
packages+=" autoconf automake pkg-config"

rc_file="$HOME/.bashrc"
if [ "$(uname)" = "Darwin" ]; then # Fix for Mac
    rc_file="$HOME/.bash_profile"
fi

for arg in "$@"; do
    if [ "$arg" = "--apt" ]; then
        sudo apt update
        sudo apt install build-essential curl file git make -y
    fi
done

install_brew_locally() {
    git clone https://github.com/Homebrew/brew ~/.brew/Homebrew
    mkdir ~/.brew/bin
    ln -s ../Homebrew/bin/brew ~/.brew/bin
    eval $(~/.brew/bin/brew shellenv)

    line="eval \$($(brew --prefix)/bin/brew shellenv)"
    check_and_add_line_to_file "$line" "$rc_file"
}

for arg in "$@"; do
    if [ "$arg" = "--brew" ]; then
        install_brew_locally
    fi
done

if [[ $(which brew) == "" ]]; then
    echo "brew: command not found"
    exit
else
    echo "brew: found at $(which brew)"
fi

mkdir -p "$HOME/.local/bin"
line='export PATH="$HOME/.local/bin:$PATH"'
check_and_add_line_to_file "$line" "$rc_file"

for arg in "$@"; do
    if [ "$arg" = "--install" ]; then
        eval "read -r -a pkgs <<< \"$packages\""

        for pkg in "${pkgs[@]}"; do
            if info=$(brew ls --versions $pkg > /dev/null 2>&1); then
                echo "$pkg is already installed"
            else
                echo "$pkg" is not installed
                not_installed+=($pkg)
            fi
        done
        if [[ $not_installed != "" ]]; then
            echo "Packages will be installed: ${not_installed[*]}"
            brew update --verbose
            brew install ${not_installed[*]}
        fi
    fi
done

for arg in "$@"; do
    if [ "$arg" = "--upgrade" ]; then
        brew update --verbose
        brew upgrade
    fi
done

echo "Remember to restart shell to load environment variables"
