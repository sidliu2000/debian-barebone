# debian-barebone

A simple page to keep track of the changes to install Debian as minimal and barebone as possible.

My preference of a linux desktop is to be as barebone as possible, easy to extend if needed, and know what I install, and be able to serve ALL of my daily needs, which are mostly programming and office documents related activities. I have been a linux user for many years and gone through quite a few distros including red hat, fedora, ubuntu, lubuntu, xubuntu, debian, slax, dsl, tiny core, etc, just to name a few. In recent years, I found myself using debian-based distro more and more. It is small and fast, but not so small and different to a point where it is hard to add things if I need to, like some of the really lightweight distro.

It documents how I install minimum packages. Many of these are taken from various google sources but I need a single place to track end to end steps and packages.

1) BASE

For debian base (buster) installation, I use debian-10.6.0-amd64-netinst-firmware.iso. Using text based installer to go through the whole installation process, without selecting any meta packages, yea, NONE. 

Install some handy optional packages, install os-prober if you dual boot Windows, add yourself to the sudoer list:
 
    apt install sudo lshw ssh os-prober
    usermod -aG sudo [your username]
 
Check linux kernel and keep the latest version (in this case, it is 4.19.0-12-amd64):

    uname -a
    apt list linux-image* --installed
    apt-get purge linux-image-4.19.0-11-amd64

After installation, add contrib non-free to /etc/apt/sources.list file. Generally I prefer vendor supplied drivers such as nvidia's. Disable recommended packages for apt by creating /etc/apt/apt.conf.d/99_norecommends file:

    APT::Install-Recommends "false";
    APT::AutoRemove::RecommendsImportant "false";
    APT::AutoRemove::SuggestsImportant "false";

After this, run the following to update and remove even more package. At this point, there are 208 packages installed, about 800MB in disk size, see apt-base.txt.

    apt update; apt upgrade; apt autoremove
 
2) NETWORK

If network card is recognize, to connect to wifi:

    ip a
    iw dev
    ip link set wlp2s0 up
    iwlist scan

Add wifi to /etc/network/interfaces. This will work for most commonly WPA/WPA2 networks:

    allow-hotplug wlp3s0
    iface wlp3s0 inet dhcp
        wpa-ssid ESSID
        wpa-psk PASSWORD

Bring up your interface and verify the connection:

    ifup wlp3s0
    iw wlp3s0 link
    ip a

If network card is not recognize, you will need to go through more steps. I will not cover here.

3) XORG

I use debian as my desktop, X11 is needed. 

Xorg core -- Installing the void input driver and dummy video driver prevents APT installing all available drivers soyou can install only the drivers you need.

    apt install xserver-xorg-core xserver-xorg-video-dummy xserver-xorg-input-void xinit x11-xserver-utils

Video drivers -- Install your video driver. Install vesa for fallback, qxl if you use qemu virtual machine.

    apt install xserver-xorg-video-intel xserver-xorg-video-vesa xserver-xorg-video-qxl

Input drivers -- keyboard, mouse, touchpad, etc.

    apt install xserver-xorg-input-evdev xserver-xorg-input-libinput xserver-xorg-input-mouse xserver-xorg-input-kbd xserver-xorg-input-synaptics

Install fonts -- 

    apt install xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable
    
4) DESKTOP

Desktop environment is obviously very personal. I use many over the years, gnome, xfce4, icewm, openbox, fluxbox, lxde. The current lxde based on openbox is actually quite small and fast, consume very little resources. Apps are modular, meaning you can add/delete/change if you don't like any of it. With the right theme (Arc-Theme), lxde can look quite modern. And did I mention it is lightning fast? 

    apt install lxde

Because of "No Recommended" packages, meta package lxde only installs the dependencies which include a terminal, file manager, an 4 very lightweight accessories calculator, image viewer, text editor, xarchiver. Reboot into a full desktop environment. If you need other apps, such as volume and power controls, themes, network manager, install them manually.

    apt install arc-theme wicd lxtask lightdm-gtk-greeter-settings xfce4-power-manager alsa-utils

Now I got a fully functional, themed desktop environment, with 180MB memory and 1.2GB disk size, yay!

5) OFFICE - optional

For pdf and doc:

    apt install evince libreoffice
 
6) LOCALE - optional

For additional languages you might use, install them. I use simplified chinese fcitx input method, with google pinyin. 

Reconfigure the locales to include zh_CN.UTF-8 UTF-8:

    dpkg-reconfigure locales

Install fcitx:

    apt install im-config fcitx fcitx-config-gtk fcitx-googlepinyin fcitx-modules fcitx-module-dbus fcitx-module-x11 fcitx-ui-classic

Run im-config to select fcitx, then reboot or logout for it to become effective: 

    im-config

Run fcitx configuration from Preferences, then add Google Pinyin. You will have a keyboard icon now on the panel to switch between English and Chinese input. 

Lastly don't forget to install your preferred fonts. I use fonts-noto-cjk for the sake of simplicity.

    apt install fonts-noto-cjk
    
7) PROGRAMMING - optional

For basic build environment:

    apt install build-essential git maven nodejs npm

8) BROWSERS - optional

For browsers, install firefox or chromium. If you prefer, download chrome browser directly from Google website:
    
    apt install firefox-esr chromium
    
9) VIRTUAL MACHINE

For the occasions that you have to use Windows, install qemu and virt-manager:

    sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager dnsmasq
    sudo systemctl status libvirtd.service
    sudo virsh net-list --all
    sudo virsh net-start default
    sudo virsh net-autostart default
    sudo modprobe vhost_net
    echo "vhost_net" | sudo  tee -a /etc/modules
        vhost_net
    lsmod | grep vhost
        vhost_net              24576  0
        vhost                  49152  1 vhost_net
        tap                    28672  1 vhost_net
        tun                    49152  2 vhost_net
    sudo adduser $USER libvirt
    sudo adduser $USER libvirt-qemu
    newgrp libvirt
    newgrp libvirt-qemu

That's all folks! 

Why the trouble? You have the control and can decide what you want and don't want.

Maybe I will write samba, gvfs, mount internal disk, etc?

I want to give a special mention to slax (slax.org) because it might be my next debian-based barebone desktop. It has a lot of potentials as a live OS or regular desktop, with no installation needed. I feel that currently there are some kinks such as slower boot up (perhaps due to some jobs and auto scan/mount file systems) and slight delay of xlunch. 
