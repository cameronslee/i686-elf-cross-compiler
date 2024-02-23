#!/usr/bin/env bash

mkdir $HOME/src && cd $HOME/src

# Debian
yes | sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo 

# Install binutils
git clone git://sourceware.org/git/binutils-gdb.git

# Install GCC
git clone git://gcc.gnu.org/git/gcc.git


export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"


# This is gonna take a hot minute stay schway

# Build binutils
cd $HOME/src
mkdir build-binutils
cd build-binutils
../binutils-gdb/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

# Build gcc
cd $HOME/src
mkdir build-gcc
cd build-gcc
../gcc/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

# Invoke CC
$HOME/opt/cross/bin/$TARGET-gcc --version

# Add to your path if desired: export PATH="$HOME/opt/cross/bin:$PATH"
