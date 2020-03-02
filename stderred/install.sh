#! /usr/bin/env sh

# dependencies
apt-get install -y build-essential cmake

src_dir=/usr/local/src/stderred

if [ -d "$src_dir" ]; then
    echo "directory stderred already exists!" 1>&2
    exit 1
else
    mkdir "$src_dir"
fi

git clone git://github.com/sickill/stderred.git "$src_dir"

cd "$src_dir"

# build stderred
make

# put .so in /usr/local/share
if ! [ -f $src_dir/build/libstderred.so ]; then
    echo "build failed!"
    exit 1
else
    ln -s "$src_dir/build/" /usr/local/lib/stderred
fi

unset src_dir

