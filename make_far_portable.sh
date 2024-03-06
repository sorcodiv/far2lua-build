#!/bin/bash

git clone --depth=1 https://github.com/megastep/makeself
git clone --depth=1 https://github.com/shmuz/far2m

sed -i 's/unsigned int esc_expiration = 0;/unsigned int esc_expiration = 100;/' far2m/WinPort/src/Backend/WinPortMain.cpp
sed -i 's/unsigned int _esc_expiration = 0;/unsigned int _esc_expiration = 100;/' far2m/WinPort/src/Backend/TTY/TTYBackend.h
sed -i 's/AddPlugin( netcfg        wide  1 )/#AddPlugin( netcfg        wide  1 )/' far2m/CMakeLists.txt
rm -rf ./far2m/netcfg

cd far2m

rm -rf ./_build
mkdir _build
cd _build
cmake -DUSEWX=yes -DLEGACY=no -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc --all)

cd install
rm -rf ./lib
mkdir lib

if [ -f "/usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2.0.4" ]; then
  cp --preserve=timestamps /usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2.0.4 ./lib/libluajit-5.1.so
fi

cp ../../../autonomizer.sh .
chmod +x autonomizer.sh
./autonomizer.sh

rm autonomizer.sh
rm lib/libc.so.6
rm lib/libdl.so.2
rm lib/libgcc_s.so.1
rm lib/libm.so.6
rm lib/libpthread.so.0
rm lib/libstdc++.so.6
rm lib/libresolv.so.2
rm lib/librt.so.1

cd ..
mv install far_portable

chmod +x ../../makeself/makeself.sh
../../makeself/makeself.sh --keep-umask --nocomp far_portable far_portable.run far2m ./far2m
chmod 755 far_portable.run
mv far_portable.run ../../far
