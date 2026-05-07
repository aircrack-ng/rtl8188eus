# RTL8188EUS Driver Maintenance Guide

**Version:** v5.3.10 (Patched)  
**Date:** May 7, 2026  
**Maintainer:** System Administrator  
**Kernel Compatibility:** Linux 6.0+ (tested on 7.0.3-1-cachyos)

---

## Table of Contents
1. [Overview](#overview)
2. [Security Patches Applied](#security-patches-applied)
3. [DKMS Management](#dkms-management)
4. [Module Loading/Unloading](#module-loadingunloading)
5. [WiFi Connectivity Testing](#wifi-connectivity-testing)
6. [Kernel Update Procedure](#kernel-update-procedure)
7. [Troubleshooting Common Issues](#troubleshooting-common-issues)
8. [Advanced Configuration](#advanced-configuration)
9. [Rollback Procedures](#rollback-procedures)
10. [Development Notes](#development-notes)

---

## Overview

This driver provides support for Realtek RTL8188EUS USB WiFi adapters (USB ID: 0bda:8179). It has been patched with 7 critical security and stability fixes from the upstream Linux kernel.

### Key Files Structure
```
/home/vansh/rtl8188eus/           # Source directory
├── core/                          # Core driver functionality
│   ├── rtw_ap.c                  # Access Point mode (CVE fixes here)
│   └── ...
├── os_dep/linux/                 # Linux OS-dependent code
│   ├── usb_ops_linux.c          # USB operations (URB fix here)
│   └── usb_intf.c              # USB interface (altsetting fix here)
├── include/
│   └── rtw_version.h            # Driver version definition
├── dkms.conf                    # DKMS configuration
├── dkms-install.sh              # Basic DKMS installer
├── dkms-remove.sh              # DKMS remover
└── dkms-comprehensive-install.sh # Full automated installer (14 phases)
```

### Version Information
- **Runtime Version:** v5.3.10_28540.20180627
- **DKMS Package Version:** 5.3.10
- **Previous Version:** 5.3.9 (all patches applied)

---

## Security Patches Applied

### CVE-2021-28660: Buffer Overflow Vulnerability

**Risk:** High - Remote code execution possible via malformed beacon frames  
**Location:** `core/rtw_ap.c`, function `rtw_check_beacon_data()`

#### Patch 1: SSID Length Capping
```c
// Line ~1842
// Before:
ie_len = pnetwork->network.IELength - (ie - pnetwork->network.IEs);
// After:
ie_len = min_t(int, ie_len, sizeof(pbss_network->Ssid.Ssid));
```
**Impact:** Prevents SSID buffer overflow (max 32 bytes)

#### Patch 2: Mesh ID Length Capping
```c
// Line ~1857
// Before:
ie_len = pnetwork->network.IELength - (ie - pnetwork->network.IEs);
// After:
ie_len = min_t(int, ie_len, sizeof(pbss_network->mesh_id.Ssid));
```
**Impact:** Prevents Mesh ID buffer overflow (max 32 bytes)

#### Patch 3: Supported Rates Length Capping
```c
// Line ~1877
// Before:
ie_len = pnetwork->network.IELength - (ie - pnetwork->network.IEs);
// After:
ie_len = min_t(int, ie_len, NDIS_802_11_LENGTH_RATES_EX);
```
**Impact:** Prevents supported rates buffer overflow (max 16 bytes)

### USB Stability Fixes

#### Patch 4: URB Error Handling
**File:** `os_dep/linux/usb_ops_linux.c`  
**Function:** `usb_read_port()` (line ~1042)

```c
// Before:
if ((err) && (err != (-EPERM))) {
    ret = _FAIL;
}
return ret;

// After:
if (err)
    return _FAIL;
return _SUCCESS;
```
**Impact:** Eliminates "URB submitted while active" errors by properly failing on any USB submission error.

#### Patch 5: USB Interface Alternate Setting
**File:** `os_dep/linux/usb_intf.c`  
**Line:** ~520

```c
// Before:
phost_iface = &usb_intf->altsetting[0];

// After:
phost_iface = usb_intf->cur_altsetting;
```
**Impact:** Uses modern USB API instead of hardcoded first interface.

### Kernel 6.0+ Compatibility
**Status:** Already implemented in source  
**Code Location:** `os_dep/linux/usb_intf.c`

```c
#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 19) && \
     LINUX_VERSION_CODE < KERNEL_VERSION(6, 8, 0))
// ... struct usb_driver definition with .reset_resume
#endif
```
**Impact:** Ensures driver works with modern kernels (6.0+).

---

## DKMS Management

### What is DKMS?
Dynamic Kernel Module Support (DKMS) is a framework that allows kernel modules to be dynamically built for each kernel on your system. It integrates with package management and automatically rebuilds modules when kernel updates occur.

### DKMS Directory Structure
```
/usr/src/8188eu-5.3.10/              # Source copy for DKMS
├── core/
├── os_dep/
├── include/
├── dkms.conf                       # DKMS configuration
└── Makefile

/var/lib/dkms/8188eu/5.3.10/      # DKMS working directory
├── source -> /usr/src/8188eu-5.3.10
└── 7.0.3-1-cachyos/
    └── x86_64/
        ├── log/make.log          # Build log
        └── module/8188eu.ko.zst  # Built module

/lib/modules/7.0.3-1-cachyos/updates/dkms/
└── 8188eu.ko.zst                  # Installed module (compressed)
```

### Essential DKMS Commands

#### Check Status
```bash
dkms status 8188eu
# Output: 8188eu/5.3.10, 7.0.3-1-cachyos, x86_64: installed
```

#### Add Module to DKMS
```bash
sudo dkms add -m 8188eu -v 5.3.10
```

#### Build Module
```bash
sudo dkms build --force -m 8188eu -v 5.3.10
# Check build log:
cat /var/lib/dkms/8188eu/5.3.10/$(uname -r)/x86_64/log/make.log
```

#### Install Module
```bash
sudo dkms install --force -m 8188eu -v 5.3.10
```

#### Remove Module
```bash
sudo dkms remove -m 8188eu -v 5.3.10 --all
```

#### Reconfigure After Source Changes
```bash
# If you modify source in /home/vansh/rtl8188eus/
sudo rm -rf /usr/src/8188eu-5.3.10
sudo cp -r /home/vansh/rtl8188eus /usr/src/8188eu-5.3.10
sudo dkms add -m 8188eu -v 5.3.10
sudo dkms build --force -m 8188eu -v 5.3.10
sudo dkms install --force -m 8188eu -v 5.3.10
sudo rmmod 8188eu
sudo modprobe 8188eu
```

---

## Module Loading/Unloading

### Load Module
```bash
sudo modprobe 8188eu
# Or directly:
sudo insmod /lib/modules/$(uname -r)/updates/dkms/8188eu.ko.zst
```

### Unload Module
```bash
# First bring down the interface (if up)
sudo ip link set wlan0 down

# Then unload
sudo rmmod 8188eu
# Or:
sudo modprobe -r 8188eu
```

### Check Module Status
```bash
# Loaded modules
lsmod | grep 8188eu

# Module information
modinfo 8188eu

# Only version
modinfo 8188eu | grep version
# Expected: version:        v5.3.10_28540.20180627
```

### Auto-Load Configuration
The module is configured to load automatically at boot via:
```bash
cat /etc/modules-load.d/8188eu.conf
# Output: 8188eu
```

To disable auto-load:
```bash
sudo rm /etc/modules-load.d/8188eu.conf
```

To re-enable:
```bash
echo "8188eu" | sudo tee /etc/modules-load.d/8188eu.conf
```

---

## WiFi Connectivity Testing

### 1. Verify Hardware Detection
```bash
lsusb | grep Realtek
# Expected: Bus 001 Device 002: ID 0bda:8179 Realtek Semiconductor Corp. RTL8188EUS 802.11n Wireless Network Adapter
```

### 2. Check Network Interface
```bash
ip link show
# Look for wlan0 interface

# Or with iw:
iw dev
```

### 3. Scan for Networks
```bash
sudo iw dev wlan0 scan | grep SSID
# Or more detailed:
sudo iw dev wlan0 scan | head -50
```

### 4. Connect to WiFi (using nmtui)
```bash
sudo nmtui
# Navigate to "Activate a connection"
# Select your WiFi network and enter password
```

### 5. Connect to WiFi (command line)
```bash
# Using nmcli
sudo nmcli device wifi list
sudo nmcli device wifi connect "SSID" password "your_password" ifname wlan0
```

### 6. Test Connectivity
```bash
# Check IP address
ip addr show wlan0

# Test ping
ping -c 4 8.8.8.8

# Check DNS
cat /etc/resolv.conf
```

### 7. Monitor Connection
```bash
# Watch WiFi link quality
watch -n 1 "cat /proc/net/wireless"

# Check signal strength
iw dev wlan0 link
```

---

## Kernel Update Procedure

When you update your kernel, DKMS should automatically rebuild the module. Here's the manual procedure if needed:

### 1. Update Kernel
```bash
sudo pacman -Syu
# This will install new kernel headers and update kernel
```

### 2. Verify DKMS Rebuild
After reboot into new kernel:
```bash
dkms status 8188eu
# Should show "installed" for new kernel version
```

### 3. If DKMS Didn't Rebuild Automatically
```bash
# Check if new kernel headers are installed
ls /lib/modules/$(uname -r)/build

# If missing, install headers (CachyOS)
sudo pacman -S linux-cachyos-headers

# Then rebuild
sudo dkms build -m 8188eu -v 5.3.10
sudo dkms install -m 8188eu -v 5.3.10
```

### 4. Verify After Kernel Update
```bash
lsmod | grep 8188eu
modinfo 8188eu | grep version
iw dev
```

---

## Troubleshooting Common Issues

### Issue 1: Module Version Shows v5.3.9
**Symptom:**
```bash
modinfo 8188eu | grep version
# Shows: version:        v5.3.9_28540.20180627
```

**Cause:** Stale build artifacts or incorrect MODULE_VERSION macro.

**Solution:**
```bash
# Check source files
grep DRIVERVERSION /home/vansh/rtl8188eus/include/rtw_version.h
# Should show: #define DRIVERVERSION "v5.3.10_28540.20180627"

# Clean and rebuild
sudo dkms remove -m 8188eu -v 5.3.10 --all
sudo rm -rf /usr/src/8188eu-5.3.10
sudo cp -r /home/vansh/rtl8188eus /usr/src/8188eu-5.3.10
sudo dkms add -m 8188eu -v 5.3.10
sudo dkms build --force -m 8188eu -v 5.3.10
sudo dkms install --force -m 8188eu -v 5.3.10
sudo rmmod 8188eu
sudo modprobe 8188eu
modinfo 8188eu | grep version
```

### Issue 2: "Module cfg80211 is in use"
**Symptom:**
```bash
sudo modprobe -r 8188eu
# Error: modprobe: FATAL: Module cfg80211 is in use.
```

**Cause:** Another module (like brcmfmac) is using cfg80211.

**Solution:**
```bash
# Use rmmod instead
sudo ip link set wlan0 down
sudo rmmod 8188eu
sudo modprobe 8188eu
```

### Issue 3: Build Fails with "Hangup"
**Symptom:**
```bash
sudo dkms build -m 8188eu -v 5.3.10
# Build log shows: make[4]: *** [...] Hangup
```

**Cause:** Resource constraints during parallel compilation.

**Solution:**
```bash
# Edit dkms.conf to reduce parallelism
sudo nano /usr/src/8188eu-5.3.10/dkms.conf
# Change: MAKE="'make' -s -j$PROCS_NUM KVER=${kernelver} KSRC=/lib/modules/${kernelver}/build"
# To:     MAKE="'make' -s -j2 KVER=${kernelver} KSRC=/lib/modules/${kernelver}/build"

# Then rebuild
sudo dkms build --force -m 8188eu -v 5.3.10
```

### Issue 4: USB Device Not Recognized
**Symptom:**
```bash
lsusb | grep Realtek
# No output
```

**Solution:**
```bash
# 1. Check if device is plugged in
lsusb

# 2. Try different USB port
# 3. Check kernel messages
dmesg | tail -20

# 4. Reload module
sudo rmmod 8188eu
sudo modprobe 8188eu

# 5. Check if interface appears
ip link show
```

### Issue 5: WiFi Networks Not Showing
**Symptom:**
```bash
sudo iw dev wlan0 scan
# No networks or error
```

**Solution:**
```bash
# 1. Check interface is up
ip link show wlan0
# If down: sudo ip link set wlan0 up

# 2. Check RF kill
rfkill list

# 3. Check module parameters
systool -v -m 8188eu

# 4. Try setting interface up manually
sudo ifconfig wlan0 up
```

### Issue 6: Kernel Taint Warning
**Symptom:**
```bash
cat /proc/sys/kernel/tainted
# Shows: 12800
dmesg | grep taint
# Shows: 8188eu: module verification failed: signature and/or required key missing - tainting kernel
```

**Explanation:** This is normal for out-of-tree DKMS modules. "O" = Out-of-tree module, "E" = Unsigned module.

**Optional Fix (module signing):**
```bash
# Sign module with your MOK key
sudo /usr/lib/modules/$(uname -r)/build/scripts/sign-file sha256 \
    /var/lib/dkms/mok.key \
    /var/lib/dkms/mok.pub \
    /lib/modules/$(uname -r)/updates/dkms/8188eu.ko.zst

# Then re-register key with MOK manager on next boot
```

---

## Advanced Configuration

### Driver Parameters
View available parameters:
```bash
modinfo 8188eu | grep parm
# Output: parm:           rtw_chip_version:int
```

### Custom Build Options
Edit `Makefile` in source directory to enable/disable features:
```bash
# Example: Enable debug output
CONFIG_RTW_DEBUG = y
CONFIG_RTW_LOG_LEVEL = 4  # 0-7, higher = more verbose
```

### Multiple Kernel Support
DKMS automatically builds for all installed kernels:
```bash
# Check all installed kernels
ls /lib/modules/

# Build for specific kernel
sudo dkms build -m 8188eu -v 5.3.10 -k 6.18.22-1-cachyos-lts

# Install for specific kernel
sudo dkms install -m 8188eu -v 5.3.10 -k 6.18.22-1-cachyos-lts
```

---

## Rollback Procedures

### Rollback to Original Driver
If you need to revert to the original kernel driver:
```bash
# 1. Remove DKMS module
sudo dkms remove -m 8188eu -v 5.3.10 --all

# 2. Remove DKMS source
sudo rm -rf /usr/src/8188eu-5.3.10

# 3. Remove auto-load config
sudo rm -f /etc/modules-load.d/8188eu.conf

# 4. Load original module
sudo modprobe -r 8188eu  # If loaded
sudo modprobe 8188eu  # This will load original from /lib/modules/.../kernel/drivers/net/wireless/

# 5. Verify original
modinfo 8188eu | grep filename
# Should point to .../kernel/drivers/net/wireless/8188eu.ko
```

### Emergency Rollback Script
Create `/home/vansh/emergency-rollback.sh`:
```bash
#!/bin/bash
echo "Rolling back to original 8188eu driver..."
sudo dkms remove -m 8188eu -v 5.3.10 --all
sudo rm -rf /usr/src/8188eu-5.3.10
sudo rm -f /etc/modules-load.d/8188eu.conf
sudo rmmod 8188eu 2>/dev/null
sudo modprobe 8188eu
echo "Rollback complete. Using original driver."
echo "Check with: modinfo 8188eu | grep filename"
```
Make executable: `chmod +x /home/vansh/emergency-rollback.sh`

---

## Development Notes

### Source Code Modification Workflow
If you need to modify the driver source:

1. **Edit source** in `/home/vansh/rtl8188eus/`
2. **Update version** in `include/rtw_version.h` if needed
3. **Copy to DKMS source:**
   ```bash
   sudo rm -rf /usr/src/8188eu-5.3.10
   sudo cp -r /home/vansh/rtl8188eus /usr/src/8188eu-5.3.10
   ```
4. **Rebuild and install:**
   ```bash
   sudo dkms build --force -m 8188eu -v 5.3.10
   sudo dkms install --force -m 8188eu -v 5.3.10
   ```
5. **Test:**
   ```bash
   sudo rmmod 8188eu
   sudo modprobe 8188eu
   dmesg | grep 8188eu
   ```

### Creating Patches
To create a patch file for your changes:
```bash
# From home directory
diff -u /home/vansh/rtl8188eus.orig /home/vansh/rtl8188eus > rtl8188eus-v5.3.10.patch
```

### Git Integration
If using git for version control:
```bash
cd /home/vansh/rtl8188eus
git status
git add -A
git commit -m "Apply security patches: CVE-2021-28660, USB fixes"
git tag v5.3.10
```

---

## Quick Reference Card

### Daily Commands
```bash
dkms status 8188eu                      # Check DKMS status
lsmod | grep 8188eu                      # Check if loaded
modinfo 8188eu | grep version           # Check version
lsusb | grep Realtek                    # Check USB device
ip link show wlan0                      # Check interface
sudo iw dev wlan0 scan | head -20     # Scan networks
dmesg | grep -i 8188                    # Check kernel messages
```

### File Locations
| Purpose | Path |
|---------|------|
| Source | `/home/vansh/rtl8188eus/` |
| DKMS Source | `/usr/src/8188eu-5.3.10/` |
| DKMS Tree | `/var/lib/dkms/8188eu/5.3.10/` |
| Module | `/lib/modules/$(uname -r)/updates/dkms/8188eu.ko.zst` |
| Auto-load | `/etc/modules-load.d/8188eu.conf` |
| Build Log | `/var/lib/dkms/8188eu/5.3.10/$(uname -r)/x86_64/log/make.log` |

### Version Summary
| Component | Version |
|-----------|---------|
| Runtime Driver | v5.3.10_28540.20180627 |
| DKMS Package | 5.3.10 |
| Kernel | 7.0.3-1-cachyos |
| DKMS | 3.4.0 |
| Target Device | RTL8188EU (0bda:8179) |

---

**End of Maintenance Guide**
