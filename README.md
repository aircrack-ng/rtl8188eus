## rtl8188eus v5.7.6

# Realtek rtl8188eus &amp; rtl8188eu &amp; rtl8188etv WiFi driver

[![Monitor mode](https://img.shields.io/badge/monitor%20mode-supported-brightgreen.svg)](#)
[![Frame Injection](https://img.shields.io/badge/monitor%20mode-supported-brightgreen.svg)](#)
[![MESH Mode](https://img.shields.io/badge/mesh%20mode-supported-brightgreen.svg)](#)
[![GitHub issues](https://img.shields.io/github/issues/kimocoder/rtl8188eus.svg)](https://github.com/kimocoder/rtl8188eus/issues)
[![GitHub forks](https://img.shields.io/github/forks/kimocoder/rtl8188eus.svg)](https://github.com/kimocoder/rtl8188eus/network)
[![GitHub stars](https://img.shields.io/github/stars/kimocoder/rtl8188eus.svg)](https://github.com/kimocoder/rtl8188eus/stargazers)
[![GitHub license](https://img.shields.io/github/license/kimocoder/rtl8812au.svg)](https://github.com/kimocoder/rtl8188eus/blob/master/LICENSE)<br>
[![Android](https://img.shields.io/badge/android%20(8)-supported-brightgreen.svg)](#)
[![aircrack-ng](https://img.shields.io/badge/aircrack--ng-supported-blue.svg)](#)

This is a pure Realtek release, not from vendor but from all the Realtek multichip "bases"
we've seen, this must be the newest, most stable and effective one.
The performance and code quality has been improved and thats about time.

# HowTo build/install
1. You will need to blacklist another driver in order to use this one instead of the kernel provided.
   We included a "realtek_blacklist.conf" file in the folder:<br>
2. "cp realtek_blacklist.conf /etc/modprobe.d/"<br>
3. "make && make install"<br>
4. "rmmod 8188eu && insmod 8188eu.ko"

# MONITOR MODE howto
Use these steps to enter monitor mode.
```
airmon-ng check-kill
ip link set <interface> down
iw dev <interface> set type monitor
```
Frame injection test may be performed with
```
aireplay -9 <interface>
```

# NetworkManager configuration
Add these lines below to "NetworkManager.conf" and ADD YOUR ADAPTER MAC below [keyfile]
This will make the Network-Manager ignore the device, and therefor don't cause problems.
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

# TODO
* Implement txpower control
* Add HT (RX) Greenfield capability
* Add newer kernel support
* Optimize and tweak the Makefile

* Do a complete walkthrough of new base


