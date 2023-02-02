#!/bin/bash
sudo apt install -y lxc
# cleanup
sudo lxc-stop -n far2l
sudo lxc-destroy -n far2l
sudo rm -rf ~/far2l_portable.run
# here we go
sudo lxc-create -t download -n far2l -- --force-cache -d ubuntu -r xenial -a amd64
sudo lxc-start -n far2l -d
sleep 2
sudo lxc-attach -n far2l -- dhclient eth0
echo nameserver 1.1.1.1 | sudo lxc-attach -n far2l -- tee /run/resolvconf/resolv.conf
sudo lxc-attach -n far2l -- apt install -y wget
if [ -f "make_far2l_portable_on_ubuntu_16_04.sh" ]; then
  sudo cp make_far2l_portable_on_ubuntu_16_04.sh /var/lib/lxc/far2l/rootfs/
else
  sudo lxc-attach -n far2l -- wget https://github.com/unxed/far2l-deb/raw/master/portable/make_far2l_portable_on_ubuntu_16_04.sh
fi
if [ -f "autonomizer.sh" ]; then
  sudo cp autonomizer.sh /var/lib/lxc/far2l/rootfs/
fi
if [ -f "tty_tweaks.patch" ]; then
  sudo cp tty_tweaks.patch /var/lib/lxc/far2l/rootfs/
fi
sudo lxc-attach -n far2l -- chmod +x make_far2l_portable_on_ubuntu_16_04.sh
sudo lxc-attach -n far2l -- ./make_far2l_portable_on_ubuntu_16_04.sh
sudo chmod +r -R /var/lib/lxc/far2l
sudo cp /var/lib/lxc/far2l/rootfs/root/far2l/far2l/build/far2l_portable.run .
sudo lxc-stop -n far2l
sudo lxc-destroy -n far2l
