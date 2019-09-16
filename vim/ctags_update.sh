PREFIX="$HOME/.local"

cd $PREFIX/ctags
git pull

./autogen.sh
./configure --prefix=$PREFIX
make -j
make install
