#!/bin/bash

# Enterprise PAM Lab - Privilege Assignment Script

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with sudo."
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: sudo ./assign-privileges.sh <username>"
    exit 1
fi

USERNAME="$1"
ADMIN_GROUP="pam_admins"

if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi

if ! getent group "$ADMIN_GROUP" >/dev/null; then
    groupadd "$ADMIN_GROUP"
fi

usermod -aG "$ADMIN_GROUP" "$USERNAME"

echo "Privileges assigned to '$USERNAME'."
echo "Group membership:"
id "$USERNAME"

echo "Note: User must start a new login session for group changes to apply."