#!/bin/bash

if [ ! -d /etc/X11/xorg.conf.d ]; then
sudo mkdir -p /etc/X11/xorg.conf.d
fi
sudo cp ./usr/lcd35a-overlay.dtb /boot/overlays/lcd35a.dtbo
sudo cp ./usr/lcd35a-overlay.dtb /boot/overlays/

sudo cp /boot/firmware/config.txt ./usr/config.txt
sudo echo "hdmi_force_hotplug=1" >> ./usr/config.txt
sudo echo "dtparam=i2c_arm=on" >> ./usr/config.txt
sudo echo "dtparam=spi=on" >> ./usr/config.txt
sudo echo "enable_uart=1" >> ./usr/config.txt
sudo echo "dtoverlay=lcd35a:rotate=270" >> ./usr/config.txt
sudo echo "hdmi_group=2" >> ./usr/config.txt
sudo echo "hdmi_mode=1" >> ./usr/config.txt
sudo echo "hdmi_mode=87" >> ./usr/config.txt
sudo echo "hdmi_cvt 480 320 60 6 0 0 0" >> ./usr/config.txt
sudo echo "hdmi_drive=2" >> ./usr/config.txt

sudo cp -rf ./usr/config.txt /boot/firmware/config.txt


#sudo cp -rf ./usr/99-calibration.conf-35-90  /etc/X11/xorg.conf.d/99-calibration.conf
#sudo cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf

#sudo cp ./usr/inittab /etc/
#sudo cp -rf ./etc/rc.local /etc/

sudo apt-get install cmake libraspberrypi-dev -y
sudo apt-get install xserver-xorg-input-evdev -y
sudo apt-get install xserver-xorg-input-evdev xinput-calibrator -y

sudo mkdir ./rpi-fbcp/build
cd ./rpi-fbcp/build/
sudo cmake ..
sudo make
sudo install fbcp /usr/local/bin/fbcp
cd - > /dev/null


sudo sync
sudo sync
sleep 1

echo "reboot now"
sudo reboot
