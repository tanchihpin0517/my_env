cd $(dirname $0)

brew bundle dump
brew bundle --force cleanup
rm Brewfile
