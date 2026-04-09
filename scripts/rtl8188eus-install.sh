#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SRC="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

usage() {
    cat <<'EOF'
Usage: sudo ./scripts/rtl8188eus-install.sh [options]

Builds and installs 8188eu for one kernel, writes persistent module config,
updates module dependencies, and optionally loads the module immediately.

Options:
  --src <path>          Driver source tree (default: repo root)
  --kernel <kver>       Target kernel release (default: uname -r)
  --cc <auto|clang|gcc> Compiler mode (default: auto)
  --jobs <n>            Parallel build jobs (default: nproc)
  --no-load             Do not modprobe the module after install
  --refresh-initramfs   Run mkinitcpio -P after writing modprobe config
  -h, --help            Show this help
EOF
}

require_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        echo "This script must run as root." >&2
        exit 1
    fi
}

require_cmd() {
    local cmd="$1"
    if ! command -v "${cmd}" >/dev/null 2>&1; then
        echo "Missing required command: ${cmd}" >&2
        exit 1
    fi
}

CC_MODE="auto"
SRC="${DEFAULT_SRC}"
KVER="$(uname -r)"
JOBS="$(nproc)"
LOAD_NOW=1
REFRESH_INITRAMFS=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --src)
            SRC="$2"
            shift 2
            ;;
        --kernel)
            KVER="$2"
            shift 2
            ;;
        --cc)
            CC_MODE="$2"
            shift 2
            ;;
        --jobs)
            JOBS="$2"
            shift 2
            ;;
        --no-load)
            LOAD_NOW=0
            shift
            ;;
        --refresh-initramfs)
            REFRESH_INITRAMFS=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
done

require_root
require_cmd make
require_cmd install
require_cmd depmod
require_cmd modprobe

if [[ ! -f "${SRC}/Makefile" ]]; then
    echo "Invalid source tree: ${SRC}" >&2
    exit 1
fi

KSRC="/lib/modules/${KVER}/build"
if [[ ! -d "${KSRC}" ]]; then
    echo "Kernel build directory not found: ${KSRC}" >&2
    echo "Install headers for ${KVER} first." >&2
    exit 1
fi

CC_VALUE=""
LD_VALUE=""
case "${CC_MODE}" in
    auto)
        if [[ -r "${KSRC}/.config" ]] && grep -q '^CONFIG_CC_IS_CLANG=y' "${KSRC}/.config"; then
            CC_VALUE="clang"
            LD_VALUE="ld.lld"
        fi
        ;;
    clang)
        CC_VALUE="clang"
        LD_VALUE="ld.lld"
        ;;
    gcc)
        CC_VALUE="gcc"
        LD_VALUE=""
        ;;
    *)
        echo "Invalid --cc value: ${CC_MODE}" >&2
        exit 1
        ;;
esac

if [[ -n "${CC_VALUE}" ]]; then
    require_cmd "${CC_VALUE}"
fi
if [[ -n "${LD_VALUE}" ]]; then
    require_cmd "${LD_VALUE}"
fi

MAKE_ARGS=("-C" "${SRC}" "-j${JOBS}" "KVER=${KVER}" "KSRC=${KSRC}")
if [[ -n "${CC_VALUE}" ]]; then
    MAKE_ARGS+=("CC=${CC_VALUE}")
fi
if [[ -n "${LD_VALUE}" ]]; then
    MAKE_ARGS+=("LD=${LD_VALUE}")
fi

echo "[build] kernel=${KVER} src=${SRC} cc=${CC_VALUE:-kernel-default}"
make "${MAKE_ARGS[@]}" clean
make "${MAKE_ARGS[@]}"

DEST="/lib/modules/${KVER}/kernel/drivers/net/wireless/8188eu.ko"
echo "[install] ${DEST}"
install -D -m 0644 "${SRC}/8188eu.ko" "${DEST}"

echo "[config] /etc/modprobe.d/rtl8188eus.conf"
cat > /etc/modprobe.d/rtl8188eus.conf <<'EOF'
# Prefer patched aircrack-ng rtl8188eus over in-kernel alternatives.
blacklist r8188eu
blacklist rtl8xxxu
softdep 8188eu pre: cfg80211
EOF

echo "[config] /etc/modules-load.d/rtl8188eus.conf"
cat > /etc/modules-load.d/rtl8188eus.conf <<'EOF'
8188eu
EOF

echo "[depmod] ${KVER}"
depmod -a "${KVER}"

if [[ "${REFRESH_INITRAMFS}" -eq 1 ]]; then
    if command -v mkinitcpio >/dev/null 2>&1; then
        echo "[mkinitcpio] refreshing initramfs presets"
        mkinitcpio -P
    else
        echo "[mkinitcpio] skipped (mkinitcpio not found)"
    fi
fi

if [[ "${LOAD_NOW}" -eq 1 ]]; then
    echo "[modprobe] reloading target module"
    modprobe -r r8188eu rtl8xxxu 8188eu 2>/dev/null || true
    modprobe 8188eu
fi

echo "[verify] filename: $(modinfo -F filename 8188eu 2>/dev/null || echo unavailable)"
echo "[verify] vermagic: $(modinfo -F vermagic 8188eu 2>/dev/null || echo unavailable)"
echo "[verify] loaded modules:"
lsmod | grep -E '(^8188eu|^rtl8xxxu|^r8188eu)' || true

echo "[done] install workflow completed"
