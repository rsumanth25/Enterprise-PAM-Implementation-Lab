\# UFW Firewall Configuration



\## Environment

\- Operating System: Ubuntu Server 24.04 LTS

\- Firewall: Uncomplicated Firewall (UFW)

\- SSH Port: 22



\## Implemented Rules



```bash

sudo ufw allow OpenSSH

sudo ufw default deny incoming

sudo ufw default allow outgoing

sudo ufw enable

