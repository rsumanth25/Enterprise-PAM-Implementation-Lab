#!/bin/bash

# Enterprise PAM Lab - Password Policy Management

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with sudo."
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: sudo ./password-policy.sh <username>"
    exit 1
fi

USERNAME="$1"

if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi

# Configure password aging policy
chage -m 1 -M 90 -W 14 "$USERNAME"

echo "Password policy configured for: $USERNAME"
echo "Minimum password age: 1 day"
echo "Maximum password age: 90 days"
echo "Warning period: 14 days"

echo
echo "Current password policy:"
chage -l "$USERNAME"