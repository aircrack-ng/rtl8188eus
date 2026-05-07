#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SRC="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

usage() {
    cat <<'EOF'
Usage: sudo ./scripts/install-pacman-hook.sh [--src <path>]

Installs:
  1) /usr/local/sbin/rtl8188eus-rebuild-hook
  2) /etc/pacman.d/hooks/95-rtl8188eus-rebuild.hook

The hook runs after transactions that modify kernel module trees and rebuilds
8188eu for all installed kernels.
EOF
}

require_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        echo "This script must run as root." >&2
        exit 1
    fi
}

SRC="${DEFAULT_SRC}"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --src)
            SRC="$2"
            shift 2
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

REBUILD_SCRIPT="${SRC}/scripts/rtl8188eus-rebuild.sh"
if [[ ! -x "${REBUILD_SCRIPT}" ]]; then
    echo "Missing executable rebuild script: ${REBUILD_SCRIPT}" >&2
    echo "Run: chmod +x scripts/rtl8188eus-rebuild.sh" >&2
    exit 1
fi

mkdir -p /usr/local/sbin
cat > /usr/local/sbin/rtl8188eus-rebuild-hook <<EOF
#!/usr/bin/env bash
set -euo pipefail
exec "${REBUILD_SCRIPT}" --all-kernels --src "${SRC}" --cc auto --no-load
EOF
chmod 0755 /usr/local/sbin/rtl8188eus-rebuild-hook

mkdir -p /etc/pacman.d/hooks
cat > /etc/pacman.d/hooks/95-rtl8188eus-rebuild.hook <<'EOF'
[Trigger]
Operation = Install
Operation = Upgrade
Type = Path
Target = usr/lib/modules/*/pkgbase
Target = usr/lib/modules/*/vmlinuz

[Action]
Description = Rebuilding rtl8188eus for installed kernels
When = PostTransaction
Exec = /usr/local/sbin/rtl8188eus-rebuild-hook
Depends = bash
EOF

echo "Installed /usr/local/sbin/rtl8188eus-rebuild-hook"
echo "Installed /etc/pacman.d/hooks/95-rtl8188eus-rebuild.hook"
