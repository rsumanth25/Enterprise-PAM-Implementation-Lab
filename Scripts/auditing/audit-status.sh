#!/bin/bash

# Enterprise PAM Lab - Audit Service Status

set -euo pipefail

echo "===== Auditd Service Status ====="

if ! command -v auditctl >/dev/null 2>&1; then
    echo "Error: auditd is not installed."
    exit 1
fi

systemctl is-active auditd
systemctl is-enabled auditd

echo
echo "===== Active Audit Rules ====="
auditctl -l

echo
echo "===== Audit Log Size ====="
du -h /var/log/audit/audit.log