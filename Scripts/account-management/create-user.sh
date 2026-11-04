#!/bin/bash

# Enterprise PAM Lab - User Onboarding Script

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with sudo."
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: sudo ./create-user.sh <username>"
    exit 1
fi

USERNAME="$1"

if id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' already exists."
    exit 1
fi

adduser "$USERNAME"

echo "User '$USERNAME' successfully created."
id "$USERNAME"