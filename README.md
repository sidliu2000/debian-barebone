# debian-barebone

A simple page to keep track of the changes to install Debian as barebone as possible.

My preference of a linux desktop is to be as barebone as possible, easy to extend if needed, and know what I install, and be able to serve ALL of my daily needs, which are mostly programming and office documents related activities. I have been a linux user for many years and gone through quite a few distros including red hat, fedora, ubuntu, lubuntu, xubuntu, debian, slax, dsl, tiny core, etc, just to name a few. In recent years, I found myself using debian-based distro more and more. It is small and fast, but not so small and different to a point where it is hard to add things if I need to, like some of the really lightweight distro.

It documents how I install minimum packages. Many of these are taken from various google sources but I need a single place to track end to end steps and packages.

1) Base

For debian base (buster) installation, I use debian-10.6.0-amd64-netinst-firmware.iso. Using text based installer to go through the whole installation process, without selecting any meta packages, yea, NONE. After installation, add contrib non-free to /etc/apt/sources.list file. Generally I prefer vendor supplied drivers such as nvidia's. Disable recommended packages for apt by creating /etc/apt/apt.conf.d/99_norecommends file:

    APT::Install-Recommends "false";
    APT::AutoRemove::RecommendsImportant "false";
    APT::AutoRemove::SuggestsImportant "false";

Install some handy optional packages, install os-prober if you dual boot Windows, check linux kernel and keep the latest version:

    apt install sudo lshw ssh os-prober
    apt list linux-image* --installed

After this, run the following to update and remove even more package. At this point, there are less than 200 packages installed, see apt-base.txt.

    apt update; apt upgrade; apt autoremove
 




