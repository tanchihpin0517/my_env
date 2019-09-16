PREFIX="$HOME/.local"

mkdir -p $PREFIX
cd $PREFIX

git clone https://github.com/universal-ctags/ctags.git
cd ctags

./autogen.sh
./configure --prefix=$PREFIX
make -j
make install
