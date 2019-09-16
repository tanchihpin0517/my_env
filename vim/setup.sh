cd $(dirname $0)

source ../util.sh

check_and_link "$PWD/.vimrc" "$HOME/.vimrc"

echo "Install Vim-Plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

CONFIG_PATH=$HOME/.vim
COC_FILE='coc-settings.json'

check_and_link "$PWD/$COC_FILE" "$CONFIG_PATH/$COC_FILE"

CONFIG_PATH=$HOME/.config/nvim
VIM_FILE='init.vim'
COC_FILE='coc-settings.json'

mkdir -p $CONFIG_PATH
check_and_link "$PWD/.vimrc" "$CONFIG_PATH/$VIM_FILE"
check_and_link "$PWD/$COC_FILE" "$CONFIG_PATH/$COC_FILE"

echo "Install Vim-Plug..."
sh -c 'curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

./update_plugin.sh --all
