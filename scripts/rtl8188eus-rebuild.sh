#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SRC="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

usage() {
    cat <<'EOF'
Usage: sudo ./scripts/rtl8188eus-rebuild.sh [options]

Rebuilds and reinstalls 8188eu for one or more kernels.

Options:
  --src <path>            Driver source tree (default: repo root)
  --kernel <kver>         Rebuild only this kernel
  --all-kernels           Rebuild every installed kernel with /lib/modules/*/build
  --cc <auto|clang|gcc>   Compiler mode (default: auto)
  --jobs <n>              Parallel build jobs (default: nproc)
  --load-running          Reload 8188eu on the running kernel after rebuild
  --no-load               Never reload module at end (overrides --load-running)
  -h, --help              Show this help
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

SRC="${DEFAULT_SRC}"
TARGET_KERNEL=""
ALL_KERNELS=0
CC_MODE="auto"
JOBS="$(nproc)"
LOAD_RUNNING=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --src)
            SRC="$2"
            shift 2
            ;;
        --kernel)
            TARGET_KERNEL="$2"
            shift 2
            ;;
        --all-kernels)
            ALL_KERNELS=1
            shift
            ;;
        --cc)
            CC_MODE="$2"
            shift 2
            ;;
        --jobs)
            JOBS="$2"
            shift 2
            ;;
        --load-running)
            LOAD_RUNNING=1
            shift
            ;;
        --no-load)
            LOAD_RUNNING=0
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

if [[ "${ALL_KERNELS}" -eq 1 && -n "${TARGET_KERNEL}" ]]; then
    echo "Use either --all-kernels or --kernel, not both." >&2
    exit 1
fi

require_root
require_cmd make
require_cmd install
require_cmd depmod

if [[ ! -f "${SRC}/Makefile" ]]; then
    echo "Invalid source tree: ${SRC}" >&2
    exit 1
fi

declare -a KERNELS=()
if [[ -n "${TARGET_KERNEL}" ]]; then
    KERNELS+=("${TARGET_KERNEL}")
elif [[ "${ALL_KERNELS}" -eq 1 ]]; then
    while IFS= read -r kver; do
        KERNELS+=("${kver}")
    done < <(find /lib/modules -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
else
    KERNELS+=("$(uname -r)")
fi

build_one() {
    local kver="$1"
    local ksrc="/lib/modules/${kver}/build"

    if [[ ! -d "${ksrc}" ]]; then
        echo "[skip] ${kver}: missing ${ksrc}" >&2
        return 1
    fi

    local cc_value=""
    local ld_value=""
    case "${CC_MODE}" in
        auto)
            if [[ -r "${ksrc}/.config" ]] && grep -q '^CONFIG_CC_IS_CLANG=y' "${ksrc}/.config"; then
                cc_value="clang"
                ld_value="ld.lld"
            fi
            ;;
        clang)
            cc_value="clang"
            ld_value="ld.lld"
            ;;
        gcc)
            cc_value="gcc"
            ld_value=""
            ;;
        *)
            echo "Invalid --cc value: ${CC_MODE}" >&2
            return 1
            ;;
    esac

    if [[ -n "${cc_value}" ]]; then
        require_cmd "${cc_value}"
    fi
    if [[ -n "${ld_value}" ]]; then
        require_cmd "${ld_value}"
    fi

    local -a make_args=("-C" "${SRC}" "-j${JOBS}" "KVER=${kver}" "KSRC=${ksrc}")
    if [[ -n "${cc_value}" ]]; then
        make_args+=("CC=${cc_value}")
    fi
    if [[ -n "${ld_value}" ]]; then
        make_args+=("LD=${ld_value}")
    fi

    echo "[build] ${kver} cc=${cc_value:-kernel-default}"
    make "${make_args[@]}" clean
    make "${make_args[@]}"

    local dest="/lib/modules/${kver}/kernel/drivers/net/wireless/8188eu.ko"
    echo "[install] ${dest}"
    install -D -m 0644 "${SRC}/8188eu.ko" "${dest}"

    echo "[depmod] ${kver}"
    depmod -a "${kver}"
}

ok=0
failed=0
for kver in "${KERNELS[@]}"; do
    if build_one "${kver}"; then
        ok=$((ok + 1))
    else
        failed=$((failed + 1))
    fi
done

if [[ "${LOAD_RUNNING}" -eq 1 ]]; then
    if [[ "${failed}" -eq 0 ]]; then
        echo "[modprobe] reloading module on running kernel"
        modprobe -r r8188eu rtl8xxxu 8188eu 2>/dev/null || true
        modprobe 8188eu || true
    else
        echo "[modprobe] skipped due to rebuild failures" >&2
    fi
fi

echo "[summary] success=${ok} failed=${failed}"
if [[ "${failed}" -ne 0 ]]; then
    exit 1
fi
