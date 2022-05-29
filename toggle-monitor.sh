#!/bin/bash

# Invoke the variables
SEARCH_CHIPSET=$(iwconfig | awk '/Nickname/' | tr -s "[:punct:]\n" " " | grep "REALTEK")
INTERFACE=$(printf "$SEARCH_CHIPSET\n" | awk '{printf $1}')
MAC_ADDRESS=$(ifconfig $INTERFACE | awk '/ether/{printf $2"\n"}')
IS_MANAGED=$(iwconfig $INTERFACE | awk '/Mode/' | tr -s "[:punct:]\n" " " | awk '{print $2"\n"}')

# Check if the device is connected
if [ -z "$SEARCH_CHIPSET" ]; then
    printf "\e[1;31mThe device is not connected. Closing now...\e[0m\n"
    notify-send "The device is not connected. Closing now..."
    exit;
fi

# Ask for the root password
while ! zenity --password | sudo -S cat /dev/null > /dev/null; do
    if $(zenity --question --text="Wrong password. Would you like to cancel?"); then
        printf "\e[1;31mYou need to run as root in order to toggle the module.\e[0m\n"
        notify-send "You need to run as root in order to toggle the module."
        exit;
    fi
done

# Create a backup for the original NetworkManager configuration
if ! ls /etc/NetworkManager/NetworkManager.conf.backup; then
    sudo -S mv /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.backup
fi

# Stop the network
sudo -S systemctl stop NetworkManager.service

# Toggle the Monitor to Managed mode
if [[ "$IS_MANAGED" == "Managed" || "$IS_MANAGED" == "Auto" ]]; then
    printf "[device]\nwifi.scan-rand-mac-address=no\n\n[ifupdown]\n\nmanaged=false\n\n[connection]\nwifi.powersave=0\n\n[main]\nplugins=keyfile\n\n[keyfile]\nunmanaged-devices=$MAC_ADDRESS\n" | sudo -S tee /etc/NetworkManager/NetworkManager.conf
    sudo -S rmmod 8188eu
    sudo -S modprobe 8188eu
    sudo -S ip link set $INTERFACE down
    sudo -S iw dev $INTERFACE set type monitor
else
    printf "\n" | sudo -S tee /etc/NetworkManager/NetworkManager.conf
    sudo -S rmmod 8188eu
    sudo -S modprobe 8188eu
    sudo -S ip link set $INTERFACE down
    sudo -S iw dev $INTERFACE set type managed
    sudo -S ip link set $INTERFACE up
fi

# Start the network
sudo -S systemctl start NetworkManager.service

# Display toggle message
MODE=$(iwconfig $INTERFACE | awk '/Mode/' | tr -s "[:punct:]\n" " " | awk '{print $2"\n"}')
if [ "$MODE" == "Monitor" ]; then
    printf "\e[1;33mChanged mode to \e[1;31m$MODE\e[1;33m mode.\e[0m\n"
    notify-send "Changed mode to $MODE mode."
else
    printf "\e[1;33mChanged mode to \e[1;34m$MODE\e[1;33m mode.\e[0m\n"
    notify-send "Changed mode to $MODE mode."
fi

sudo -K

# TODO: A way to avoid the user toggling back and forth the device and bugging the system.
#       A way to reload the NetworkManager configuration.