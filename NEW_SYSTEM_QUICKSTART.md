# rtl8188eus New System Quickstart

Use this on a fresh Arch/CachyOS-style machine after cloning the repository.

## 1) Clone and enter repo

```bash
git clone https://github.com/aircrack-ng/rtl8188eus.git
cd rtl8188eus
```

## 2) Install required packages

```bash
sudo pacman -S --needed base-devel linux-headers
```

If you boot an LTS kernel, also install matching headers:

```bash
sudo pacman -S --needed linux-lts-headers
```

## 3) Make scripts executable

```bash
chmod +x scripts/rtl8188eus-install.sh scripts/rtl8188eus-rebuild.sh scripts/install-pacman-hook.sh
```

## 4) Build + install driver for current kernel

```bash
sudo ./scripts/rtl8188eus-install.sh --cc auto --refresh-initramfs
```

## 5) (Recommended) enable automatic rebuild after kernel updates

```bash
sudo ./scripts/install-pacman-hook.sh
```

## 6) Load driver now and verify

```bash
sudo modprobe -r r8188eu rtl8xxxu 2>/dev/null || true
sudo modprobe 8188eu
lsmod | grep 8188eu
modinfo -F vermagic 8188eu
uname -r
```

## 7) Quick troubleshooting

If the module does not load after a kernel update:

```bash
sudo ./scripts/rtl8188eus-rebuild.sh --kernel "$(uname -r)" --cc auto --load-running
```
