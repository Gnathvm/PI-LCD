#!/bin/bash

sudo apt-get install cmake libraspberrypi-dev -y
sudo apt-get install xserver-xorg-input-evdev -y
sudo apt-get install xserver-xorg-input-evdev xinput-calibrator -y

sudo cp ./usr/lcd35a.dtb /boot/overlays/
sudo cp ./usr/lcd35a.dtb /boot/overlays/lcd35a.dtbo

sudo cp /boot/config.txt ./usr/config.txt
sudo echo "hdmi_force_hotplug=1" >> ./usr/config.txt
sudo echo "dtparam=i2c_arm=on" >> ./usr/config.txt
sudo echo "dtparam=spi=on" >> ./usr/config.txt
sudo echo "enable_uart=1" >> ./usr/config.txt
sudo echo "dtoverlay=lcd35a" >> ./usr/config.txt
sudo echo "hdmi_group=2" >> ./usr/config.txt
sudo echo "hdmi_mode=1" >> ./usr/config.txt
sudo echo "hdmi_mode=87" >> ./usr/config.txt
sudo echo "hdmi_cvt 480 320 60 6 0 0 0" >> ./usr/config.txt
sudo echo "hdmi_drive=2" >> ./usr/config.txt
sudo cp -rf ./usr/config.txt /boot/config.txt

if [ -f /etc/X11/xorg.conf.d/40-libinput.conf ]; then
sudo rm -rf /etc/X11/xorg.conf.d/40-libinput.conf
fi
if [ ! -d /etc/X11/xorg.conf.d ]; then
sudo mkdir -p /etc/X11/xorg.conf.d
fi

sudo cp -rf ./etc/rc.local /etc/
sudo cp -rf ./usr/99-calibration35.conf  /etc/X11/xorg.conf.d/99-calibration.conf
sudo cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf

sudo cp ./usr/inittab /etc/

sudo mkdir ./rpi-fbcp/build
cd ./rpi-fbcp/build/
sudo cmake ..
sudo make
sudo install fbcp /usr/local/bin/fbcp
cd - > /dev/null

sudo sync
sleep 1

echo "reboot now"
sudo reboot
