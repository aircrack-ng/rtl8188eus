<p align="center">
<img src="./.media/rtl8188eus_logo.png" alt="rtl8188eus logo" width="50%"/>
</p>

##### Realtek rtl8188eus &amp; rtl8188eu &amp; rtl8188etv WiFi drivers

[![Monitor mode](https://img.shields.io/badge/monitor%20mode-supported-brightgreen.svg)](#)
[![Frame Injection](https://img.shields.io/badge/frame%20injection-supported-brightgreen.svg)](#)
[![MESH Mode](https://img.shields.io/badge/mesh%20mode-supported-brightgreen.svg)](#)
[![GitHub issues](https://img.shields.io/github/issues/aircrack-ng/rtl8188eus.svg)](https://github.com/aircrack-ng/rtl8188eus/issues)
[![GitHub forks](https://img.shields.io/github/forks/aircrack-ng/rtl8188eus.svg)](https://github.com/aircrack-ng/rtl8188eus/network)
[![GitHub stars](https://img.shields.io/github/stars/aircrack-ng/rtl8188eus.svg)](https://github.com/aircrack-ng/rtl8188eus/stargazers)
[![GitHub license](https://img.shields.io/github/license/aircrack-ng/rtl8812au.svg)](https://github.com/aircrack-ng/rtl8188eus/blob/master/LICENSE)<br>
[![Android](https://img.shields.io/badge/android%20(8)-supported-brightgreen.svg)](#)
[![aircrack-ng](https://img.shields.io/badge/aircrack--ng-supported-blue.svg)](#)

Trying to find a solution? See [troubleshooting](https://github.com/KanuX-14/rtl8188eus/blob/v5.3.9/TROUBLESHOOTING.md).

## Supports

- Android 7
- MESH Support
- Monitor mode
- Frame injection
- Up to kernel v5.8+<br>
... And a bunch of various wifi chipsets

## Building

You will need to blacklist another driver in order to use this one.

##### With the automated script:

|   Package |   Command                                                                                                 |
|-----------|-----------------------------------------------------------------------------------------------------------|
|   curl    |   sh -c "$(curl -fsSL https://raw.githubusercontent.com/KanuX-14/rtl8188eus/v5.3.9/scripts/build.sh)"     |
|   wget    |   sh -c "$(wget -O- https://raw.githubusercontent.com/KanuX-14/rtl8188eus/v5.3.9/scripts/build.sh)"       |
|   fetch   |   sh -c "$(fetch -o - https://raw.githubusercontent.com/KanuX-14/rtl8188eus/v5.3.9/scripts/build.sh)"     |

##### Without the automated script:

Keep in mind that the script checks your system and install the dependencies.<br>
It also checks whether the file have or not have a variable inside.<br>
As you wish to do all by yourself, the dependency list is right under:

|   Package     |   URL                                             |
|---------------|---------------------------------------------------|
|   bc          |   https://ftp.gnu.org/gnu/bc/                     |
|   gawk        |   https://ftp.gnu.org/gnu/gawk/                   |
|   gcc         |   https://ftp.gnu.org/gnu/gcc/                    |
|   git         |   https://github.com/git/git                      |
|   make        |   https://ftp.gnu.org/gnu/make/                   |
|   net-tools   |   https://sourceforge.net/projects/net-tools/     |
|   zenity      |   https://gitlab.gnome.org/GNOME/zenity           |

It is necessary the usage of kernel headers. Each distribution have a different package.<br>
They can also be manually compiled. See [this](https://www.kernel.org/doc/html/latest/kbuild/modules.html).

#### Compilation:

```sh
git clone --recursive https://github.com/KanuX-14/rtl8188eus.git
cd rtl8188eus
printf "blacklist r8188eu\n" | sudo tee "/etc/modprobe.d/realtek.conf"
sudo rmmod r8188eu
make && sudo make install clean
sudo modprobe 8188eu
```

#### The toggle-monitor script:

With this, the toggle script will appear in your DE's menu. Under `Accessories` and `Internet`.

```sh
sudo cp toggle-monitor.sh /usr/local/bin/toggle-monitor
sudo chown $USER:$USER /usr/local/bin/toggle-monitor
sudo chmod +x /usr/local/bin/toggle-monitor
sudo cp rtl8188eus-toggle-monitor.desktop /usr/share/applications
```

## Monitor mode

Interface can be both identified as `wlan0` or `wlp1s0`. It may depend on how much wireless devices are connected.<br>
Use the command to list all the available interfaces:
```sh
ip address
```

Use these steps to enter monitor mode.
```sh
sudo airmon-ng check kill
sudo ip link set <interface> down
sudo iw dev <interface> set type monitor
```

Frame injection test may be performed with.<br>
(after kernel v5.2 scanning is slow, run a scan or simply an airodump-ng first!)

```sh
aireplay -9 <interface>
```

## Disable Monitor mode

Use these steps to disable monitor mode. (not possible if your device's MAC address is added to `unmanaged-devices` variable under "NetworkManager.conf")
```sh
sudo service NetworkManager start
sudo iw dev <interface> set type managed
sudo ip link set <interface> up
```

If the adapter still refuses to go back, try:
```sh
sudo service NetworkManager restart
```

## NetworkManager configuration

Copy "NetworkManager.conf" to "NetworkManager.conf.bak" to create a backup.<br>
Add these lines below to "NetworkManager.conf" and ADD YOUR ADAPTER MAC below `[keyfile]`.<br>
This will make the Network-Manager ignore the device, and therefore don't cause problems.

```sh
[device]
wifi.scan-rand-mac-address=no

[ifupdown]
managed=false

[connection]
wifi.powersave=0

[main]
plugins=keyfile

[keyfile]
unmanaged-devices=A0:B1:C2:D3:E4:F5 #Your device's MAC address here
```

# Credits
Realtek       - https://www.realtek.com<br>
Alfa Networks - https://www.alfa.com.tw<br>
aircrack-ng.  - https://www.aircrack-ng.org<br>

And all those who may be using or contributing to it of anykind. Thanks!<br>
