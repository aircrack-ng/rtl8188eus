# Kali Quickstart

This guide is for the TP-Link TL-WN722N v2/v3 (`2357:010c`) using the out-of-tree `8188eu` driver for monitor-mode labs.

Use this driver when the stock `rtl8xxxu` driver can switch the interface to monitor mode but `airodump-ng` still shows no APs.

Tested on:
- Kali Linux arm64
- Kernel `6.18.12+kali-arm64`
- TP-Link TL-WN722N v2/v3 (`2357:010c`)

## 1. Install build dependencies

```bash
sudo apt update
sudo apt install -y git build-essential bc dkms linux-headers-$(uname -r) aircrack-ng iw usbutils
```

## 2. Clone this branch

```bash
git clone https://github.com/ikertejero/rtl8188eus.git
cd rtl8188eus
git checkout kali-6-18-support
```

## 3. Confirm the adapter is visible

```bash
lsusb | grep 2357:010c
iw dev
```

Expected result:
- `lsusb` shows `2357:010c TP-Link TL-WN722N v2/v3 [Realtek RTL8188EUS]`
- `iw dev` shows a wireless interface such as `wlan0`

## 4. Build and install the driver

Option A: direct install

```bash
make clean
make -j"$(nproc)"
sudo make install
sudo depmod -a
```

Option B: DKMS install

Run this only if the repository directory is named `rtl8188eus`.

```bash
sudo ./dkms-install.sh
```

## 5. Disable the stock Realtek drivers

```bash
sudo tee /etc/modprobe.d/realtek.conf >/dev/null <<'EOF'
blacklist r8188eu
blacklist rtl8xxxu
EOF
```

## 6. Switch to the out-of-tree driver

```bash
sudo modprobe -r rtl8xxxu r8188eu 8188eu 2>/dev/null || true
sudo modprobe 8188eu
```

## 7. Verify the correct module is active

```bash
lsmod | grep -E '8188|8xxx'
iw dev
```

Expected result:
- `8188eu` is loaded
- `rtl8xxxu` is not loaded
- your wireless interface is still present

## 8. Enable monitor mode

Replace `wlan0` if your interface has a different name.

```bash
sudo airmon-ng check kill
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo ip link set wlan0 up
iw dev wlan0 info
```

Expected result:
- `iw dev wlan0 info` shows `type monitor`

## 9. Verify real capture

```bash
sudo airodump-ng wlan0
```

Expected result:
- nearby APs and stations appear within a few seconds

If monitor mode switches successfully but `airodump-ng` shows nothing, you are still not on a working path for lab use.

## 10. Optional injection test

```bash
sudo aireplay-ng -9 wlan0
```

In our testing, passive capture was confirmed and injection remained environment-dependent, so treat `airodump-ng` as the primary acceptance check.

## 11. Reboot-safe flow

After a reboot, load the driver and retest:

```bash
sudo modprobe 8188eu
iw dev
```

Then repeat the monitor-mode steps above.

## 12. Revert to the stock driver

```bash
sudo modprobe -r 8188eu
sudo rm -f /etc/modprobe.d/realtek.conf
sudo depmod -a
sudo modprobe rtl8xxxu
```

If you installed through DKMS and want to remove it completely:

```bash
sudo ./dkms-remove.sh
```
