# RTL8188EUS Driver - Quick Start Guide

**Version:** v5.3.10 (Patched)  
**Date:** May 7, 2026  
**Kernel:** 7.0.3-1-cachyos (CachyOS)

---

## What Was Done Today

✅ **7 Security Patches Applied** (CVE-2021-28660 fixes)  
✅ **USB Stability Fixes** (URB error handling)  
✅ **Driver Version Updated** (5.3.9 → 5.3.10)  
✅ **DKMS Integration** (automatic kernel updates)  
✅ **Module Load/Unload Working**  
✅ **USB Device Detected** (0bda:8179)  
✅ **wlan0 Interface Active**  
✅ **Reboot Persistence Verified**  

---

## Essential Commands

### Check Status
```bash
dkms status 8188eu
lsmod | grep 8188eu
modinfo 8188eu | grep version
lsusb | grep Realtek
ip link show wlan0
```

### Load/Unload Module
```bash
sudo modprobe 8188eu          # Load
sudo rmmod 8188eu            # Unload
sudo ip link set wlan0 down    # Bring down interface
```

### WiFi Connectivity
```bash
sudo iw dev wlan0 scan | head -20    # Scan networks
sudo nmtui                          # GUI connection tool
sudo nmcli device wifi list          # CLI list networks
```

### View Logs
```bash
dmesg | grep -i 8188
cat /var/lib/dkms/8188eu/5.3.10/$(uname -r)/x86_64/log/make.log
```

---

## File Locations

| Purpose | Path |
|---------|------|
| **Source** | `/home/vansh/rtl8188eus/` |
| **DKMS Source** | `/usr/src/8188eu-5.3.10/` |
| **Module** | `/lib/modules/$(uname -r)/updates/dkms/8188eu.ko.zst` |
| **Auto-load** | `/etc/modules-load.d/8188eu.conf` |
| **Build Log** | `/var/lib/dkms/8188eu/5.3.10/$(uname -r)/x86_64/log/make.log` |

---

## Installation (If Needed on Another Machine)

### Quick Install
```bash
sudo bash /home/vansh/rtl8188eus/dkms-comprehensive-install.sh
```

### Manual Install
```bash
# 1. Copy source
sudo cp -r /home/vansh/rtl8188eus /usr/src/8188eu-5.3.10

# 2. Register with DKMS
sudo dkms add -m 8188eu -v 5.3.10

# 3. Build
sudo dkms build --force -m 8188eu -v 5.3.10

# 4. Install
sudo dkms install --force -m 8188eu -v 5.3.10

# 5. Load
sudo modprobe 8188eu

# 6. Verify
dkms status 8188eu
modinfo 8188eu | grep version
```

---

## Verification Checklist

After any change, verify these:

- [ ] `dkms status 8188eu` → `installed`
- [ ] `lsmod | grep 8188eu` → module loaded
- [ ] `modinfo 8188eu | grep version` → `v5.3.10_28540.20180627`
- [ ] `lsusb | grep Realtek` → `0bda:8179`
- [ ] `ip link show wlan0` → interface exists
- [ ] `cat /etc/modules-load.d/8188eu.conf` → `8188eu`

---

## Common Issues & Fixes

### Module version shows v5.3.9
```bash
sudo dkms remove -m 8188eu -v 5.3.10 --all
sudo rm -rf /usr/src/8188eu-5.3.10
sudo cp -r /home/vansh/rtl8188eus /usr/src/8188eu-5.3.10
sudo dkms add -m 8188eu -v 5.3.10
sudo dkms build --force -m 8188eu -v 5.3.10
sudo dkms install --force -m 8188eu -v 5.3.10
sudo rmmod 8188eu && sudo modprobe 8188eu
```

### "Module cfg80211 is in use"
```bash
sudo ip link set wlan0 down
sudo rmmod 8188eu
sudo modprobe 8188eu
```

### Build fails with "Hangup"
```bash
# Edit /usr/src/8188eu-5.3.10/dkms.conf
# Change MAKE line to use -j2 instead of -j$PROCS_NUM
sudo dkms build --force -m 8188eu -v 5.3.10
```

### WiFi not working after reboot
```bash
dkms status 8188eu  # Should show "installed"
lsmod | grep 8188eu  # Should show module
ip link show wlan0  # Should show interface
sudo modprobe 8188eu  # Try manual load
```

---

## Documentation Files

| File | Purpose |
|------|---------|
| `IMPLEMENTATION_SUMMARY.md` | Complete technical summary (this document's big brother) |
| `MAINTENANCE_GUIDE.md` | Detailed maintenance procedures |
| `PATCHES_APPLIED.md` | Security patch documentation |
| `PATCHING_REPORT.md` | Patching completion report |
| `DKMS_INSTALLATION_STATUS.md` | Installation status & guide |
| `QUICKSTART.md` | This quick reference guide |
| `dkms-comprehensive-install.sh` | 14-phase automated installer |
| `dkms-install.sh` | Basic DKMS installer |
| `dkms-remove.sh` | DKMS remover |

---

## Key Version Info

| Component | Version |
|-----------|---------|
| **Runtime Driver** | v5.3.10_28540.20180627 |
| **DKMS Package** | 5.3.10 |
| **Kernel** | 7.0.3-1-cachyos |
| **DKMS** | 3.4.0 |
| **Target Device** | RTL8188EU (0bda:8179) |

---

## Security Status

✅ **CVE-2021-28660** - Buffer overflow vulnerabilities patched  
✅ **USB URB Errors** - "submitted while active" fixed  
✅ **Kernel 6.0+** - Compatibility verified  

---

## Support

### If Something Goes Wrong
1. Check logs: `dmesg | grep -i 8188`
2. Verify DKMS: `dkms status 8188eu`
3. Rebuild: Run `sudo bash /home/vansh/rtl8188eus/dkms-comprehensive-install.sh`
4. Rollback: `sudo dkms remove -m 8188eu -v 5.3.10 --all`

### Key Commands to Remember
```bash
sudo modprobe 8188eu              # Load module
sudo rmmod 8188eu                # Unload module
dkms status 8188eu                # Check DKMS
modinfo 8188eu | grep version    # Check version
lsusb | grep Realtek              # Check USB device
ip link show wlan0                # Check interface
```

---

**End of Quick Start Guide**

*For detailed documentation, see:*
- *IMPLEMENTATION_SUMMARY.md*
- *MAINTENANCE_GUIDE.md*
