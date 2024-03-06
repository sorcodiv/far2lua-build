# portable far2m build scripts

Scripts for building portable version of [far2m](https://github.com/shmuz/far2m) - Linux port of [FAR Manager](http://farmanager.com/), fork of [far2l](https://github.com/elfmz/far2l) with FAR3 macro system (LuaMacro).

This is modified version of [far2l building script](https://github.com/unxed/far2l-deb) (deprecated).

Far2m binaries are built with wxWidgets GUI backend by default. To build it without WX backend (console version only): change -DUSEWX=yes to -DUSEWX=no.

Binaries are built within Ubuntu 16.04 and require at least glibc 2.23.

#### Download and install [Ubuntu 16.04 server image](https://releases.ubuntu.com/xenial/).

Tested on version 16.04.7, SHA256SUMS: b23488689e16cad7a269eb2d3a3bf725d3457ee6b0868e00c8762d3816e25848 *ubuntu-16.04.7-server-amd64.iso

#### Install dependencies:

``` sh
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
sudo apt-get install -y libspdlog-dev patchelf gawk m4 libx11-dev libxi-dev libxerces-c-dev libuchardet-dev libssh-dev libssl-dev libnfs-dev libneon27-dev libarchive-dev libpcre3-dev git cmake g++ libsmbclient-dev libwxgtk3.0-dev libluajit-5.1-dev luajit uuid-dev
```

#### Download `autonomizer.sh` and `make_far_portable.sh`, run `make_far_portable.sh`
