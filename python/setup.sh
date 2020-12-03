cd $(dirname $0)

packages+=" ipython"
packages+=" pynvim"
packages+=" music21 pretty_midi librosa"
packages+=" numpy scipy pandas sklearn scikit-image scikit-learn sklearn-porter pygame"
packages+=" matplotlib seaborn"
packages+=" torch transformers"
packages+=" tqdm memory_tempfile"

link_from_brew_bin() {
    local PACKAGE=$1
    local FROM_BIN=$2
    local LINK_PATH="$3"
    local TO_BIN=$4

    local BREW_PATH="$(brew --prefix)/opt/$PACKAGE/bin"

    echo "Link $BREW_PATH/$FROM_BIN to $LINK_PATH/$TO_BIN"
    ln -sf "$BREW_PATH/$FROM_BIN" "$LINK_PATH/$TO_BIN"
}

LINK_PATH="$HOME/.local/bin"
mkdir -p $LINK_PATH

link_from_brew_bin python@3.8 python3 $LINK_PATH python
link_from_brew_bin python@3.8 python3 $LINK_PATH python3
link_from_brew_bin python@3.8 pip3 $LINK_PATH pip
link_from_brew_bin python@3.8 pip3 $LINK_PATH pip3

$LINK_PATH/pip3 install --upgrade $packages

unset -f link_from_brew_bin
unset LINK_PATH
