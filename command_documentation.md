RTL8188EUS Production Workflow (No DKMS)

Target platform:
- CachyOS / Arch-family
- Kernel 6.19+ (including clang-built kernels)
- aircrack-ng rtl8188eus tree with local 6.19 patches

Non-goals:
- No DKMS usage

------------------------------------------------------------
1) One-Time Persistent Driver Install
------------------------------------------------------------

From repo root:

```bash
chmod +x scripts/rtl8188eus-install.sh scripts/rtl8188eus-rebuild.sh scripts/install-pacman-hook.sh
sudo ./scripts/rtl8188eus-install.sh --cc auto --refresh-initramfs
```

What this does:
- Builds 8188eu against current kernel headers
- Installs module to:
	- /lib/modules/$(uname -r)/kernel/drivers/net/wireless/8188eu.ko
- Runs depmod for that kernel
- Writes persistent modprobe policy:
	- /etc/modprobe.d/rtl8188eus.conf
- Writes autoload policy:
	- /etc/modules-load.d/rtl8188eus.conf
- Reloads module immediately

Installed modprobe policy:

```conf
# /etc/modprobe.d/rtl8188eus.conf
blacklist r8188eu
blacklist rtl8xxxu
softdep 8188eu pre: cfg80211
```

Autoload policy:

```conf
# /etc/modules-load.d/rtl8188eus.conf
8188eu
```

------------------------------------------------------------
2) Verification Checklist (Copy/Paste)
------------------------------------------------------------

```bash
uname -r
modinfo -F filename 8188eu
modinfo -F vermagic 8188eu
lsmod | grep -E '(^8188eu|^rtl8xxxu|^r8188eu)'
modprobe -c | grep -E 'blacklist (r8188eu|rtl8xxxu)'
cat /etc/modules-load.d/rtl8188eus.conf
dmesg | grep -i 8188eu | tail -n 40
```

Expected state:
- `8188eu` module filename points to `/lib/modules/<running-kernel>/kernel/drivers/net/wireless/8188eu.ko`
- `vermagic` starts with current `uname -r`
- `8188eu` is loaded
- `r8188eu` and `rtl8xxxu` are not loaded

------------------------------------------------------------
3) Kernel Update Workflow
------------------------------------------------------------

Option A (recommended): automatic post-transaction rebuild hook

```bash
sudo ./scripts/install-pacman-hook.sh
```

This installs:
- `/usr/local/sbin/rtl8188eus-rebuild-hook`
- `/etc/pacman.d/hooks/95-rtl8188eus-rebuild.hook`

Behavior:
- After kernel module tree changes, pacman runs the rebuild hook
- Hook rebuilds 8188eu for all installed kernels (`/lib/modules/*`)
- Runs `depmod` for each rebuilt kernel

Option B: explicit manual rebuild command

```bash
sudo ./scripts/rtl8188eus-rebuild.sh --all-kernels --cc auto
```

Option C: single-kernel rebuild (running kernel only)

```bash
sudo ./scripts/rtl8188eus-rebuild.sh --kernel "$(uname -r)" --cc auto --load-running
```

Post-update quick verification:

```bash
modinfo -F vermagic 8188eu
uname -r
sudo modprobe -r 8188eu 2>/dev/null || true
sudo modprobe 8188eu
```

------------------------------------------------------------
4) Dual Interface Operating Mode (AP + Monitor)
------------------------------------------------------------

Goal:
- Internal WiFi: AP/hotspot mode
- USB RTL8188EUS: monitor/injection

1. Identify interfaces and PHY mapping:

```bash
iw dev
nmcli device status
```

2. Start hotspot on internal WiFi (example interface `wlp2s0`):

```bash
nmcli device wifi hotspot ifname wlp2s0 ssid LabAP password 'StrongPass123!'
```

3. Put USB adapter in monitor mode (example `wlan1`):

```bash
sudo ip link set wlan1 down
sudo iw dev wlan1 set type monitor
sudo ip link set wlan1 up
```

Alternative (dedicated monitor virtual interface):

```bash
sudo iw phy phy1 interface add wlan1mon type monitor
sudo ip link set wlan1mon up
```

4. Lock channel before capture/injection:

```bash
sudo ip link set wlan1mon down
sudo iw dev wlan1mon set channel 11 HT20
sudo ip link set wlan1mon up
```

5. Injection sanity test:

```bash
sudo aireplay-ng -9 wlan1mon
```

------------------------------------------------------------
5) Troubleshooting Quick Actions
------------------------------------------------------------

Module mismatch after reboot/update:

```bash
sudo ./scripts/rtl8188eus-rebuild.sh --kernel "$(uname -r)" --cc auto --load-running
```

Conflicting modules accidentally loaded:

```bash
sudo modprobe -r r8188eu rtl8xxxu 8188eu 2>/dev/null || true
sudo modprobe 8188eu
```

Reset monitor interface cleanly:

```bash
sudo ip link set wlan1mon down 2>/dev/null || true
sudo iw dev wlan1mon del 2>/dev/null || true
sudo iw phy phy1 interface add wlan1mon type monitor
sudo ip link set wlan1mon up
```

------------------------------------------------------------
6) Reliability Rules
------------------------------------------------------------

- Keep this source tree in a stable path (do not move it after hook install).
- Re-run `install-pacman-hook.sh` if the repo path changes.
- Ensure matching kernel headers are installed for every kernel you boot.
- If kernel packaging changes heavily, run manual fallback:
	- `sudo ./scripts/rtl8188eus-rebuild.sh --all-kernels --cc auto`


