cd $(dirname $0)

echo "Update vim Plugins..."
vim +PlugUpgrade +PlugClean! +PlugUpdate! +qall && \
    echo "Success: vim plugins are update-to-date"

echo "Update neovim Plugins..."
nvim +PlugUpgrade +PlugClean! +PlugUpdate! +qall && \
    nvim +UpdateRemotePlugin +qall && \
    echo "Success: neovim plugins are update-to-date"

link_from_brew_bin() {
    local PACKAGE=$1
    local FROM_BIN=$2
    local LINK_PATH="$3"
    local TO_BIN=$4

    local BREW_PATH="$(brew --prefix)/opt/$PACKAGE/bin"

    rm $LINK_PATH/$TO_BIN
    echo "Link $BREW_PATH/$FROM_BIN to $LINK_PATH/$TO_BIN"
    ln -s "$BREW_PATH/$FROM_BIN" "$LINK_PATH/$TO_BIN"
}

if [ "$1" = "--all" ]; then
    LINK_PATH="$HOME/.local/bin"
    mkdir -p $LINK_PATH

    link_from_brew_bin python@3.7 python3 $LINK_PATH python
    link_from_brew_bin python@3.7 python3 $LINK_PATH python3
    link_from_brew_bin python@3.7 pip3 $LINK_PATH pip
    link_from_brew_bin python@3.7 pip3 $LINK_PATH pip3
    link_from_brew_bin llvm clang $LINK_PATH clang
    link_from_brew_bin llvm clangd $LINK_PATH clangd
    link_from_brew_bin llvm clang++ $LINK_PATH clang++

    ./ctags_install.sh
else
    ./ctags_update.sh
fi

pip3 install --upgrade pynvim
npm install -g neovim

./coc_install.sh

unset -f link_from_brew_bin
