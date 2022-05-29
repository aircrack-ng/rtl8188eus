#!/bin/bash

CURRENT_SHELL=$(ps -hp $$ | awk '{printf $5}');
CORE=$(nproc)
IS_NOT_BLACKLISTED=$(cat /etc/modprobe.d/realtek.conf | grep "blacklist r8188eu")
INSTALLATION_PATH_DOES_NOT_EXIST=$(printf $PATH | grep /usr/local/sbin)

# Clone the repository first
git clone --recursive https://github.com/aircrack-ng/rtl8188eus.git
cd rtl8188eus

# Check if the device is already blacklisted.
if [ -z "$IS_NOT_BLACKLISTED" ]; then
	sudo mkdir -pv /etc/modprobe.d
	printf "blacklist r8188eu\n" | sudo tee "/etc/modprobe.d/realtek.conf"
fi

# Check if /usr/local/sbin exists.
if [ -z "$INSTALLATION_PATH_DOES_NOT_EXIST" ]; then
	sudo mkdir -pv /usr/local/sbin
	printf "export PATH=/usr/local/sbin:$PATH\n" >> ."$CURRENT_SHELL"rc
fi

# Check the package manager.
if type dpkg &>/dev/null; then
	sudo apt-get install git gcc make linux-headers-$(uname -r) zenity -y # Assuming most people will use Kali Linux, maybe gawk and net-tools is installed by default. (also I do not know which packages are in debian-based dritributions)
elif type pacman &>/dev/null; then
	sudo pacman -S --needed gawk net-tools git gcc make zenity --noconfirm
elif type dnf &>/dev/null; then
	sudo dnf install -y gawk net-tools git gcc make kernel-devel zenity
else
	printf "\e[1;32mConsider installing the kernel headers by yourself.\e[0m\n"
fi

# Installation process.
sudo rmmod r8188eu # This one can be anything. I am using this one because is the common TL-WN722N v2/v3
make -j$CORE && sudo make install clean
sudo modprobe 8188eu # Load the new driver/module
sudo cp -v toggle-monitor.sh /usr/local/sbin/toggle-monitor
sudo chown $USER:$USER /usr/local/sbin/toggle-monitor
sudo chmod +x /usr/local/sbin/toggle-monitor
printf "[Desktop Entry]\nType=Application\nVersion=1.0\nName=rtl8188eus toggle\nGenericName=rtl8188eus toggle\nComment=Toggle to and from monitor mode\nExec=toggle-monitor\nTerminal=true\nCategories=Application;Utility;\nStartupNotify=true\n" | sudo tee /usr/share/applications/rtl8188eus-toggle-monitor.desktop
printf "\e[1;33mThe driver/module has been installed!\e[0m\n"
notify-send "The driver/module has been installed!"
