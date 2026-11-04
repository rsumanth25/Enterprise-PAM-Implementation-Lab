#!/bin/bash

# Enterprise PAM Lab - User Offboarding Script

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with sudo."
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: sudo ./offboard-user.sh <username>"
    exit 1
fi

USERNAME="$1"
ADMIN_GROUP="pam_admins"

if [[ "$USERNAME" == "root" || "$USERNAME" == "sumanth" ]]; then
    echo "Error: Refusing to offboard a protected system/lab administrator."
    exit 1
fi

if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi

if getent group "$ADMIN_GROUP" >/dev/null; then
    gpasswd -d "$USERNAME" "$ADMIN_GROUP" || true
fi

usermod -L "$USERNAME"

echo "Account '$USERNAME' has been locked."
echo "Verify account status:"
passwd -S "$USERNAME"

echo "Note: Review active sessions, SSH keys and application access separately."