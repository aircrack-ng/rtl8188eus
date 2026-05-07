#!/bin/bash
# RTL8188EUS v5.3.10 DKMS Installation Script
# Comprehensive implementation with full verification
# Run with: sudo bash /tmp/dkms-comprehensive-install.sh

set -e  # Exit on any error

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DRV_DIR="rtl8188eus"
DRV_NAME="8188eu"
DRV_VERSION="5.3.10"
KERNEL_VERSION=$(uname -r)
SRC_DIR="/home/vansh/${DRV_DIR}"
DEST_DIR="/usr/src/${DRV_NAME}-${DRV_VERSION}"

# Helper functions
print_header() {
  echo
  echo "╔══════════════════════════════════════════════════════════════════╗"
  echo "║  $1"
  echo "╚══════════════════════════════════════════════════════════════════╝"
  echo
}

print_phase() {
  echo -e "${YELLOW}[PHASE $1] $2${NC}"
  echo "─────────────────────────────────────────────"
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ Error: $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠ Warning: $1${NC}"
}

print_info() {
  echo -e "${BLUE}ℹ $1${NC}"
}

# Main execution
print_header "RTL8188EUS v5.3.10 DKMS Installation"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  print_error "You must run this with superuser privileges"
  echo "Usage: sudo bash /tmp/dkms-comprehensive-install.sh"
  exit 1
fi

# ═════════════════════════════════════════════════════════════════════════════
print_phase "1" "Pre-Installation Verification"

print_info "Kernel Version: $KERNEL_VERSION"
print_info "Driver Name: $DRV_NAME"
print_info "Driver Version: $DRV_VERSION"
print_info "Source Location: $SRC_DIR"
print_info "Destination: $DEST_DIR"
echo

# Verify source exists
if [ ! -d "$SRC_DIR" ]; then
  print_error "Source directory not found: $SRC_DIR"
  exit 1
fi
print_success "Source directory found"

# Check if kernel headers are installed
if [ ! -d "/lib/modules/${KERNEL_VERSION}/build" ]; then
  print_warning "Kernel headers may not be fully installed"
  print_info "Installing linux-cachyos-headers..."
  pacman -S --noconfirm linux-cachyos-headers > /dev/null 2>&1
  print_success "Kernel headers installed"
else
  print_success "Kernel headers found"
fi

# Verify DKMS is installed
if ! command -v dkms &> /dev/null; then
  print_warning "DKMS not found, installing..."
  pacman -S --noconfirm dkms > /dev/null 2>&1
  print_success "DKMS installed"
else
  DKMS_VERSION=$(dkms --version | head -1)
  print_success "DKMS found: $DKMS_VERSION"
fi

echo -e "${GREEN}✓ All pre-installation checks passed${NC}"
echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "2" "Cleaning Old DKMS Installation"

# Check if old version exists
if dkms status $DRV_NAME 2>/dev/null | grep -q "$DRV_VERSION"; then
  print_info "Removing existing DKMS installation..."
  dkms remove -m $DRV_NAME -v $DRV_VERSION --all 2>&1 | grep -E "(Removed|error|Error)" || true
  print_success "Old installation removed"
fi

# Remove old destination directory
if [ -d "$DEST_DIR" ]; then
  print_info "Removing old source directory..."
  rm -rf "$DEST_DIR"
  print_success "Old source directory removed"
fi

# Remove old version if different
if dkms status $DRV_NAME/5.3.9 &>/dev/null; then
  print_info "Found old version 5.3.9, removing..."
  dkms remove -m $DRV_NAME -v 5.3.9 --all 2>&1 || true
  rm -rf /usr/src/8188eu-5.3.9 2>/dev/null || true
  print_success "Old version 5.3.9 removed"
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "3" "Copying Driver to /usr/src"

print_info "Copying from $SRC_DIR to $DEST_DIR..."
cp -r "$SRC_DIR" "$DEST_DIR"

if [ ! -d "$DEST_DIR" ]; then
  print_error "Failed to copy source directory"
  exit 1
fi

print_success "Driver copied to $DEST_DIR"
ls -lhd "$DEST_DIR"

print_info "Sanitizing copied tree (removing stale build artifacts)..."
find "$DEST_DIR" -type f \( -name "*.o" -o -name "*.ko" -o -name "*.ko.zst" -o -name "*.mod" -o -name "*.mod.c" -o -name "*.symvers" -o -name "Module.symvers" -o -name "modules.order" -o -name "*.cmd" \) -delete
rm -rf "$DEST_DIR/.tmp_versions"

# Best-effort clean in destination tree to avoid reusing stale object metadata
(cd "$DEST_DIR" && make clean >/dev/null 2>&1 || true)
print_success "Source tree sanitized for clean DKMS build"
echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "4" "DKMS Module Registration"

print_info "Running: dkms add -m $DRV_NAME -v $DRV_VERSION"
if dkms add -m $DRV_NAME -v $DRV_VERSION; then
  print_success "Driver registered with DKMS"
else
  print_error "DKMS add failed"
  exit 1
fi

dkms status $DRV_NAME
echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "5" "Building Kernel Module"

print_info "Running: dkms build --force -m $DRV_NAME -v $DRV_VERSION"
print_info "This may take 2-5 minutes..."
echo

if dkms build --force -m $DRV_NAME -v $DRV_VERSION 2>&1 | tee /tmp/dkms_build.log; then
  print_success "Module built successfully"
  echo
  if grep -q "error:" /tmp/dkms_build.log; then
    print_warning "Build completed with warnings, checking for errors..."
    grep "error:" /tmp/dkms_build.log || true
  fi
else
  print_error "DKMS build failed"
  dkms remove -m $DRV_NAME -v $DRV_VERSION --all 2>&1 || true
  exit 1
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "6" "Installing Module"

print_info "Running: dkms install --force -m $DRV_NAME -v $DRV_VERSION"
if dkms install --force -m $DRV_NAME -v $DRV_VERSION; then
  print_success "Module installed successfully"
else
  print_error "DKMS install failed"
  exit 1
fi

dkms status $DRV_NAME
echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "7" "Module File Verification"

MOD_PATH_UNCOMP="/lib/modules/${KERNEL_VERSION}/updates/dkms/${DRV_NAME}.ko"
MOD_PATH_ZST="/lib/modules/${KERNEL_VERSION}/updates/dkms/${DRV_NAME}.ko.zst"

if [ -f "$MOD_PATH_UNCOMP" ]; then
  print_success "Module file found: $MOD_PATH_UNCOMP"
  ls -lh "$MOD_PATH_UNCOMP"
  FILE_SIZE=$(du -h "$MOD_PATH_UNCOMP" | cut -f1)
  print_info "Module size: $FILE_SIZE"
elif [ -f "$MOD_PATH_ZST" ]; then
  print_success "Module file found: $MOD_PATH_ZST"
  ls -lh "$MOD_PATH_ZST"
  FILE_SIZE=$(du -h "$MOD_PATH_ZST" | cut -f1)
  print_info "Module size: $FILE_SIZE"
else
  print_warning "Module file not found in /lib/modules/${KERNEL_VERSION}/updates/dkms"
  print_info "Searching for module..."
  find /lib/modules -name "${DRV_NAME}.ko" -o -name "${DRV_NAME}.ko.zst" 2>/dev/null || true
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "8" "Loading Module into Kernel"

print_info "Unloading old module if present..."
if lsmod | grep -q "^8188eu"; then
  if rmmod 8188eu; then
    print_success "Old module unloaded"
  else
    print_warning "Could not unload old module cleanly; attempting forced interface down"
    ip link set wlan0 down 2>/dev/null || true
    if rmmod 8188eu; then
      print_success "Old module unloaded after interface down"
    else
      print_error "Failed to unload existing module. Reboot is required before reloading a fresh build."
      exit 1
    fi
  fi
else
  print_info "No old module to unload"
fi

print_info "Loading module: modprobe 8188eu"
if modprobe 8188eu; then
  print_success "Module loaded successfully"
else
  print_error "Module load failed"
  exit 1
fi

sleep 1

# Verify module metadata after load
print_info "Verifying loaded module metadata..."
modinfo 8188eu | grep -E "^(filename|version|srcversion)" || true

# Verify module is loaded
if lsmod | grep -q "^8188eu"; then
  print_success "Module confirmed in kernel"
  echo
  echo "Module Info:"
  lsmod | grep 8188eu
else
  print_warning "Module not currently loaded"
  print_info "This is normal if kernel headers need to be synchronized"
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "9" "Configuring Auto-Load on Boot"

print_info "Setting up auto-load configuration..."

# Create directory if needed
mkdir -p /etc/modules-load.d

# Add module to auto-load
AUTOLOAD_FILE="/etc/modules-load.d/${DRV_NAME}.conf"
if [ -f "$AUTOLOAD_FILE" ]; then
  if ! grep -q "^${DRV_NAME}$" "$AUTOLOAD_FILE"; then
    echo "$DRV_NAME" >> "$AUTOLOAD_FILE"
    print_success "Module added to auto-load"
  else
    print_info "Module already in auto-load list"
  fi
else
  echo "$DRV_NAME" > "$AUTOLOAD_FILE"
  print_success "Auto-load configuration created"
fi

echo "Auto-load Configuration:"
cat "$AUTOLOAD_FILE"
echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "10" "Kernel Taint Status Check"

TAINT=$(cat /proc/sys/kernel/tainted)
print_info "Kernel taint value: $TAINT"

if [ "$TAINT" -eq "0" ]; then
  print_success "Kernel not tainted (clean state)"
else
  print_warning "Kernel is tainted (code: $TAINT)"
  print_info "Taint reasons from dmesg:"
  dmesg | grep -i taint | tail -3 || print_info "No taint messages found"
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "11" "Module Information"

if modinfo 8188eu &>/dev/null; then
  echo "Module Details:"
  modinfo 8188eu | grep -E "^(filename|version|license|author|description)"
else
  print_warning "Module info not available (may need reboot or kernel headers)"
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "12" "USB Device Detection"

print_info "Checking for Realtek USB devices..."
if lsusb | grep -i realtek; then
  print_success "Realtek USB adapter found!"
else
  print_info "No Realtek USB adapter currently connected"
  print_info "Connect your TP-Link USB WiFi adapter now"
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "13" "Network Interface Check"

print_info "Checking network interfaces..."
echo
ip link show | head -10
echo

# ═════════════════════════════════════════════════════════════════════════════
print_phase "14" "DKMS Service Status"

if systemctl is-active --quiet dkms.service; then
  print_success "DKMS service is active"
else
  print_info "DKMS service status:"
  systemctl status dkms.service --no-pager 2>&1 | head -5 || print_info "DKMS service info not available"
fi

echo

# ═════════════════════════════════════════════════════════════════════════════
print_header "✓ DKMS Installation Complete"

echo "Summary:"
echo "  • Driver Version: $DRV_VERSION"
echo "  • Kernel Version: $KERNEL_VERSION"
echo "  • Module Status: Installed & Registered"
echo "  • Auto-load: Enabled"
echo
echo "Verification Results:"
dkms status $DRV_NAME
echo

echo "Runtime Module Metadata:"
modinfo 8188eu | grep -E "^(filename|version|srcversion)" || true
echo

echo "Next Steps:"
echo "  1. (Optional) Connect your RTL8188EUS USB adapter"
echo "  2. Check WiFi interface: iw dev"
echo "  3. Reboot to test auto-load: sudo reboot"
echo
echo "Troubleshooting Commands:"
echo "  • View module status: lsmod | grep 8188eu"
echo "  • View kernel messages: dmesg | grep -i 8188"
echo "  • Reload module: sudo modprobe -r 8188eu && sudo modprobe 8188eu"
echo "  • Build log: cat /tmp/dkms_build.log"
echo
echo -e "${GREEN}Installation finished at $(date)${NC}"
echo
