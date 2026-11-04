#!/bin/bash

# Enterprise PAM Lab - System Verification

set -uo pipefail

echo "=================================="
echo " ENTERPRISE PAM LAB VERIFICATION "
echo "=================================="

echo
echo "[1] PAM Admin Group"
getent group pam_admins || echo "Group not found"

echo
echo "[2] PAM Admin Account"
id pam_admin 2>/dev/null || echo "Account not found"

echo
echo "[3] Standard User Account"
id pam_user 2>/dev/null || echo "Account not found"

echo
echo "[4] Offboarded Support Account"
id pam_support 2>/dev/null || echo "Account not found"

echo
echo "[5] Auditd Service"
systemctl is-active auditd || true

echo
echo "[6] UFW Firewall"
ufw status verbose

echo
echo "[7] SSH Service"
systemctl is-active ssh || true

echo
echo "Verification completed."