# portable far2l_lua build script

Script for building portable version (with all the libraries in one executable file) [far2l with lua macros support](https://github.com/shmuz/far2l) (fork of [far2l](https://github.com/elfmz/far2l), linux fork of [FAR Manager v2](http://farmanager.com/)).

This is modified version of [far2l building script](https://github.com/unxed/far2l-deb).

Far2l binaries are built with wxWidgets GUI backend by default. To build it without WX backend (console version only): change -DUSEWX=yes to -DUSEWX=no.

Binaries are built within Ubuntu 16.04 and require at least glibc 2.23.
