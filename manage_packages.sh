cd $(dirname $0)

source ./util.sh

packages+=" cmake"
packages+=" llvm python@3.7"
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

while true; do
    read -p "Install or use Homebrew locally? ([Y]/n): " yn
    case $yn in
        [Yy]* ) install_brew_locally; break;;
        [Nn]* ) break;;
        "" ) install_brew_locally; break;; # default yes
        * ) echo "Please answer yes or no.";;
    esac
done

mkdir -p "$HOME/.local/bin"
line='export PATH="$HOME/.local/bin:$PATH"'
check_and_add_line_to_file "$line" "$rc_file"

for arg in "$@"; do
    if [ "$arg" = "install" ]; then
        brew update --verbose
        brew install $packages
    fi
done
for arg in "$@"; do
    if [ "$arg" = "upgrade" ]; then
        brew update --verbose
        brew upgrade
    fi
done
