If you are are taking "Learn Ethical Hacking From Scratch | Udemy" by Zaid Sabih and using Kali 2022 x64 Customized by zSecurity 1.0.7 and TP-Link TL-WN722N v2/v3 [Realtek RTL8188EUS], you might find this helpful. In the begining, I am able to enter monitor mode. However after a few days, I found out it doesn't allow to enter monitor mode. I think  TP-Link TL-WN722N v2/v3 have automatically updated its driver. Then, I find a video from David Bombal (https://www.youtube.com/watch?v=tYnjMiTTdms) but still can't perfectly solve the issue. However, I find below steps work fine for me.

1. sudo apt update
2. sudo apt upgrade 
3. sudo apt-get dist-upgrade
4. reboot
5. sudo apt-get install linux-headers-$(uname -r)
6. sudo apt install bc 
7. sudo apt-get install build-essential
8. sudo apt-get install libelf-dev
10. sudo apt install dkms
11. sudo rmmod r8188eu.ko 
12. git https://github.com/drygdryg/rtl8188eus (This works for me 😂)
13. cd rtl8188eus
14. sudo -i
15. echo 'blacklist r8188eu'|sudo tee -a '/etc/modprobe.d/realtek.conf'
16. reboot
17. cd rtl8188eus 
18. sudo make && make install
19. reboot 

Like https://github.com/cccooo/rtl8812au-centos-7.6, forked from aircrack-ng/rtl8188eus and modified for CentOS 7.9
as CentOS Kernel 3.10 contains many code from 4.x

## rtl8188eus v5.3.9

# Realtek rtl8188eus &amp; rtl8188eu &amp; rtl8188etv WiFi drivers

[![Monitor mode](https://img.shields.io/badge/monitor%20mode-supported-brightgreen.svg)](#)
[![Frame Injection](https://img.shields.io/badge/frame%20injection-supported-brightgreen.svg)](#)
[![MESH Mode](https://img.shields.io/badge/mesh%20mode-supported-brightgreen.svg)](#)
[![GitHub issues](https://img.shields.io/github/issues/aircrack-ng/rtl8188eus.svg)](https://github.com/aircrack-ng/rtl8188eus/issues)
[![GitHub forks](https://img.shields.io/github/forks/aircrack-ng/rtl8188eus.svg)](https://github.com/aircrack-ng/rtl8188eus/network)
[![GitHub stars](https://img.shields.io/github/stars/aircrack-ng/rtl8188eus.svg)](https://github.com/aircrack-ng/rtl8188eus/stargazers)
[![GitHub license](https://img.shields.io/github/license/aircrack-ng/rtl8812au.svg)](https://github.com/aircrack-ng/rtl8188eus/blob/master/LICENSE)<br>
[![Android](https://img.shields.io/badge/android%20(8)-supported-brightgreen.svg)](#)
[![aircrack-ng](https://img.shields.io/badge/aircrack--ng-supported-blue.svg)](#)


# Supports
* Android 7
* MESH Support
* Monitor mode
* Frame injection
* Up to kernel v5.8+
... And a bunch of various wifi chipsets

# Howto build/install
1. You will need to blacklist another driver in order to use this one.
2. `echo 'blacklist r8188eu'|sudo tee -a '/etc/modprobe.d/realtek.conf'`
3. Reboot
4. cd rtl8188eus
5. `make && sudo make install`
6. Reboot in order to blacklist and load the new driver/module.

# MONITOR MODE howto
Use these steps to enter monitor mode.
```
$ sudo airmon-ng check kill
$ sudo ip link set <interface> down
$ sudo iw dev <interface> set type monitor
```
Frame injection test may be performed with
(after kernel v5.2 scanning is slow, run a scan or simply an airodump-ng first!)
```
$ aireplay -9 <interface>
```

# NetworkManager configuration
Add these lines below to "NetworkManager.conf" and ADD YOUR ADAPTER MAC below [keyfile]
This will make the Network-Manager ignore the device, and therefore don't cause problems.
```
[device]
wifi.scan-rand-mac-address=no

[ifupdown]
managed=false

[connection]
wifi.powersave=0

[main]
plugins=keyfile

[keyfile]
unmanaged-devices=mac:A7:A7:A7:A7:A7
```

# Credits
Realtek       - https://www.realtek.com<br>
Alfa Networks - https://www.alfa.com.tw<br>
aircrack-ng.  - https://www.aircrack-ng.org<br>
<br>
And all those who may be using or contributing to it of anykind. Thanks!<br>
