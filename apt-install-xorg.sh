echo Install Xorg
apt install xserver-xorg-core xserver-xorg-video-dummy xserver-xorg-input-void xinit x11-xserver-utils
echo Install Video Drivers
apt install xserver-xorg-video-intel xserver-xorg-video-vesa xserver-xorg-video-qxl
echo Install Input Drivers
apt install xserver-xorg-input-evdev xserver-xorg-input-libinput xserver-xorg-input-mouse xserver-xorg-input-kbd xserver-xorg-input-synaptics
echo Install Fonts
apt-get install xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable
