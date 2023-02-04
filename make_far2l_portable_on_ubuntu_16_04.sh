#!/bin/bash
mkdir ~
cd ~
rm -rf far2l
mkdir far2l
cd far2l
apt-get update
apt-get install -y libspdlog-dev patchelf wget gawk m4 libx11-dev libxi-dev libxerces-c-dev libuchardet-dev libssh-dev libssl-dev libnfs-dev libneon27-dev libarchive-dev libpcre3-dev cmake g++ git
apt-get install -y libsmbclient-dev libwxgtk3.0-dev
#git clone https://github.com/elfmz/far2l
apt-get install -y libluajit-5.1-dev luajit uuid-dev
git clone https://github.com/shmuz/far2l
cd far2l
if [ -f "/tty_tweaks.patch" ]; then
  cp /tty_tweaks.patch .
else
  wget https://raw.githubusercontent.com/unxed/far2l-deb/master/portable/tty_tweaks.patch
fi
git apply tty_tweaks.patch
mkdir build
cd build
cmake -DUSEWX=yes -DLEGACY=no -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc --all)
cd install
rm -rf ./lib
mkdir lib
if [ -f "./Plugins/luafar/luafar2l.so" ]; then
  mv ./Plugins/luafar/luafar2l.so ./lib/luafar2l.so
fi
if [ -f "/usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2.0.4" ]; then
  cp /usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2.0.4 ./lib/libluajit-5.1.so
fi
if [ -f "/autonomizer.sh" ]; then
  cp /autonomizer.sh .
else
  wget https://github.com/unxed/far2l-deb/raw/master/portable/autonomizer.sh
fi
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
mv install far2l_portable
git clone https://github.com/megastep/makeself.git
makeself/makeself.sh far2l_portable far2l_portable.run far2l ./far2l
