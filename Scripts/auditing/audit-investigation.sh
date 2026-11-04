#!/bin/bash

# Enterprise PAM Lab - Audit Investigation

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this script with sudo."
    exit 1
fi

echo "===== User Account Changes ====="
ausearch -k user_account_changes -ts today -i || true

echo
echo "===== Password-Related Events ====="
ausearch -k password_changes -ts today -i || true

echo
echo "===== Sudo Policy Changes ====="
ausearch -k sudo_policy_changes -ts today -i || true

echo
echo "===== Recent Sudo Execution Events ====="
ausearch -m USER_CMD -ts today -i || true