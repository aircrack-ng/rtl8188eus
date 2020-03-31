## Some Important Points

Do not change your kernel name or version in any manner while preparing the module or else it will not work and you will get errors like insmod 8188.ko >> fatal error exec format failed. This happens when you use build script from kali site and on the other hand you build your modules manually.

For example say during the time of building kernel your situation was like /lib/modules/3.10.35-kali and while making the module your position is say /lib/modules/3.10.35_kali or anything else. This kind of thing will not work. So first built your kernel then just after that build your modules.


## Toolchain Used for building this module - gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf

## 2.Your kernel should enabled below. check in /proc/config.gz or device_defconfig

CONFIG_MODULES (loadable module support)

CONFIG_MODULE_FORCE_LOAD (forced module loading)

CONFIG_MODULE_UNLOAD (module unloading)

CONFIG_MODULE_FORCE_UNLOAD (forced module loading)

CONFIG_CFG80211_WEXT (wireless extension compability)

CONFIG_MAC80211 (IEEE 802.11 Networking Stack)


## Step 1- Do the following: After building the kernel stay inside that directory so the first line is irrelevant.


Cd android kernel-sourcedirectory on your pc or laptop

mkdir ../kernel-headers (make kernel-headers directory outside kernel source)

make O=../kernel-headers someone_defconfig

make O=../kernel-headers modules_prepare (prepare module)

make O=../kernel-headers modules INSTALL_MOD_PATH=../kernel-headers (make modules)

make O=../kernel-headers modules_install INSTALL_MOD_PATH=../kernel-headers(install modules)



## Build Kernel Headers ( shown for armhf/arm only do changes for arm64)

make headers_install CROSS_COMPILE=$path-your-cross-compiler ARCH=arm SUBARCH=arm INSTALL_HDR_PATH=../kernel-headers (install kernel headers on the same directory ie “kernel-headers”)

-Note eg: CROSS_COMPILE= /home/user/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-


## Build RTL8188EUS driver/modules

```
cd ../
git clone https://github.com/aircrack-ng/rtl8188eus -b v5.3.9
cd rtl8188eus


Now enter rtl8188eus directory using your file manager and edit the “makefile” as follows: for armhf

---------Platform Related (armhf/arm only for arm64 change respective line)------------

Line number 94-95

CONFIG_PLATFORM_I386_PC = n

CONFIG_PLATFORM_ARM_RPI = y

------------------For ARM ToolChain use Hardware FLOATING line number 1044-1053-------------------
(Again for armhf/arm do the following but for arm64 first find your respective section then do the
 editing.)

ifeq ($(CONFIG_PLATFORM_ARM_RPI), y)

EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN

EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT

ARCH ?= arm

CROSS_COMPILE ?=toolchain path (give urs)

KVER ?= 3.18.35-kali	(give urs version /lib/modules/)

KSRC := fullpath not shown include it/kernel-headers/lib/modules/3.18.35-kali/build	(give urs)

MODDESTDIR := fullpath not shown include it/3.18.35-kali/kernel/drivers/net/wireless/	(give urs)

INSTALL_PREFIX := leave as it is

Endif

## Step 4- from inside of rtl8188eus directory 

export ARCH=arm

Make

Done enjoy your 8188eu.ko inside this same directory. Transfer it to your nethunter by reflashing
kernel after including it inside /lib/modules/(uname -r)/. 

## Load the driver (8188eu.ko)
```
su
cd /system/lib/modules
insmod 8188eu.ko
```
ENJOY........
