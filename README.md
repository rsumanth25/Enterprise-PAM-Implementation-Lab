\# Enterprise Privileged Access Management (PAM) Implementation Lab



A hands-on Linux-based Privileged Access Management (PAM) lab demonstrating privileged account lifecycle management, role-based access control (RBAC), credential management, password policies, security auditing, SSH key authentication, and firewall configuration.



\## Project Overview



Privileged Access Management (PAM) helps organizations secure, control, monitor, and manage access to critical systems and privileged accounts.



This project implements a simulated enterprise PAM environment using Kali Linux and Ubuntu Server. It demonstrates how privileged and standard accounts can be managed through access controls, credential protection, password policies, audit logging, and secure remote administration.



The lab was designed to understand practical PAM operations and foundational concepts relevant to enterprise PAM platforms such as CyberArk.



\*\*Note:\*\* This is a Linux-based PAM simulation, not an actual CyberArk deployment.



\## Objectives



\- Implement privileged and standard user account management.

\- Configure role-based access control using Linux groups and sudo policies.

\- Demonstrate account onboarding and offboarding procedures.

\- Securely store credentials using an encrypted password vault.

\- Configure password rotation and password aging policies.

\- Monitor account and privilege-related changes using Linux Auditd.

\- Implement SSH key-based authentication.

\- Configure firewall rules to restrict unauthorized incoming connections.

\- Develop Bash scripts for administrative operations and verification.



\## Architecture



The lab uses two virtual machines and an encrypted credential vault.



| Component | Purpose |

|---|---|

| Kali Linux | Administrative and testing workstation |

| Ubuntu Server 24.04 LTS | Managed Linux target server |

| KeePassXC | Encrypted credential storage |

| OpenSSH | Secure remote administration |

| Auditd | Security event monitoring |

| UFW | Host-based firewall |



\### Architecture Diagram



```text

&#x20;            ADMINISTRATOR

&#x20;                  |

&#x20;                  |

&#x20;            KALI LINUX

&#x20;         Administrative VM

&#x20;                  |

&#x20;         +--------+--------+

&#x20;         |                 |

&#x20;      KeePassXC          SSH Client

&#x20;  Encrypted Vault           |

&#x20;                            |

&#x20;                      SSH Port 22

&#x20;                            |

&#x20;                    VIRTUALBOX NAT

&#x20;                        NETWORK

&#x20;                            |

&#x20;                            |

&#x20;                     UBUNTU SERVER

&#x20;                      10.0.2.15

&#x20;                            |

&#x20;         +------------------+------------------+

&#x20;         |                  |                  |

&#x20;     Account             Access             Security

&#x20;    Management           Control            Monitoring

&#x20;         |                  |                  |

&#x20;     User Accounts       Sudo/RBAC           Auditd

&#x20;     Onboarding          pam\_admins          Audit Logs

&#x20;     Offboarding         Standard Users      Event Search

&#x20;         |

&#x20;     Password Policy

&#x20;     Password Aging

&#x20;         |

&#x20;     SSH Security

&#x20;     UFW Firewall

```



\## Technology Stack



| Category | Technologies |

|---|---|

| Operating Systems | Kali Linux, Ubuntu Server 24.04 LTS |

| Virtualization | Oracle VirtualBox |

| PAM Concepts | Privileged Account Management, RBAC |

| Credential Management | KeePassXC |

| Authentication | OpenSSH, SSH Key Authentication |

| Access Control | Linux Groups, Sudoers |

| Password Management | Linux `passwd`, `chage` |

| Security Auditing | Auditd, ausearch, auditctl |

| Firewall | UFW |

| Scripting | Bash |

| Version Control | Git, GitHub |



\## Implemented Security Controls



\### 1. Privileged Account Management



Created separate privileged and standard user accounts to demonstrate controlled administrative access.



Lab accounts:



\- `sumanth` – Ubuntu lab administrator.

\- `pam\_admin` – Privileged administrative account.

\- `pam\_user` – Standard user account.

\- `pam\_support` – Support account used for onboarding and offboarding demonstrations.



\### 2. Role-Based Access Control (RBAC)



Created a dedicated Linux group named `pam\_admins`.



Configured the sudoers policy:



```text

%pam\_admins ALL=(ALL:ALL) ALL

```



This allows members of the `pam\_admins` group to execute commands with administrative privileges.



Standard users remain outside the privileged group.



Configuration file: `Configuration/sudoers/pam\_admins`



\### 3. Account Onboarding and Offboarding



Demonstrated account onboarding by:



\- Creating a new support account.

\- Verifying the account.

\- Assigning approved privileged group membership.

\- Recording the account in the credential vault.



Demonstrated account offboarding by:



\- Removing privileged group membership.

\- Locking the account.

\- Verifying account status.



Example commands:



```bash

sudo adduser pam\_support

sudo usermod -aG pam\_admins pam\_support

id pam\_support

```



Offboarding:



```bash

sudo gpasswd -d pam\_support pam\_admins

sudo usermod -L pam\_support

sudo passwd -S pam\_support

```



\### 4. Credential Management



Used KeePassXC to create an encrypted credential database.



Organized credentials into separate groups:



\- Ubuntu Server

\- Privileged Accounts

\- Standard Accounts



Stored lab account credentials in their respective entries.



\*\*Security:\*\* The KeePassXC database and master password are intentionally excluded from this repository.



\### 5. Password Management



Implemented manual password rotation and password aging policies.



Configured the following policy for `pam\_admin`:



| Policy | Value |

|---|---:|

| Minimum password age | 1 day |

| Maximum password age | 90 days |

| Password warning period | 14 days |



Commands:



```bash

sudo passwd pam\_admin

sudo chage -m 1 -M 90 -W 14 pam\_admin

sudo chage -l pam\_admin

```



This demonstrates manual password management. Automated password rotation using CyberArk CPM was not implemented.



\### 6. Security Auditing and Monitoring



Installed and enabled Linux Auditd.



Created audit rules to monitor important account and privilege-related configuration files.



Configuration: `Configuration/auditd/pam-lab.rules`



```text

\-w /etc/passwd -p wa -k user\_account\_changes

\-w /etc/shadow -p wa -k password\_changes

\-w /etc/group -p wa -k group\_changes

\-w /etc/sudoers -p wa -k sudo\_policy\_changes

\-w /etc/sudoers.d/ -p wa -k sudo\_policy\_changes

```



Loaded and verified the rules:



```bash

sudo augenrules --load

sudo auditctl -l

```



Generated and investigated audit events:



```bash

sudo usermod -c "PAM audit test" pam\_user



sudo ausearch -k user\_account\_changes -ts recent -i

sudo ausearch -k password\_changes -ts recent -i

sudo ausearch -x sudo -ts recent -i

```



These rules monitor the specified files and directories. They do not independently capture every privileged command.



\### 7. SSH Key-Based Authentication



Generated an Ed25519 key pair on Kali Linux.



```bash

ssh-keygen -t ed25519 -C "pam-lab-kali"

```



Copied the public key to Ubuntu:



```bash

ssh-copy-id sumanth@10.0.2.15

```



Verified a fresh SSH connection using key-based authentication:



```bash

ssh sumanth@10.0.2.15

```



Verified SSH settings:



```bash

sudo sshd -T | grep -E 'pubkeyauthentication|passwordauthentication|permitrootlogin'

```



Observed configuration:



```text

pubkeyauthentication yes

passwordauthentication yes

permitrootlogin without-password

```



Password authentication was retained as a recovery option.



\### 8. Firewall Configuration



Configured Uncomplicated Firewall (UFW) on Ubuntu Server.



Implemented rules:



```bash

sudo ufw allow OpenSSH

sudo ufw default deny incoming

sudo ufw default allow outgoing

sudo ufw enable

```



Verified the firewall:



```bash

sudo ufw status verbose

```



The firewall was enabled with incoming traffic denied by default, outgoing traffic allowed, and SSH permitted.



A new SSH connection was successfully established after firewall activation.



\## Project Scripts



The `Scripts/` directory contains reusable Bash scripts for administrative operations.



| Script | Purpose |

|---|---|

| `account-management/create-user.sh` | Create a Linux user |

| `account-management/assign-privileges.sh` | Add a user to the privileged group |

| `account-management/offboard-user.sh` | Remove privileged membership and lock an account |

| `password-management/password-policy.sh` | Configure password aging |

| `auditing/audit-status.sh` | Check Auditd status, rules and log size |

| `auditing/audit-investigation.sh` | Search account, password and sudo-related audit events |

| `verification/verify-pam-lab.sh` | Check lab accounts and security services |



The scripts are provided as reusable examples. The Auditd status script was executed successfully in the Ubuntu environment. The remaining scripts should be reviewed and tested in a controlled lab before operational use.



\## Repository Structure



```text

Enterprise-PAM-Implementation-Lab/

│

├── README.md

├── .gitignore

├── .gitattributes

│

├── Documentation/

│

├── Configuration/

│   ├── sudoers/

│   │   └── pam\_admins

│   ├── auditd/

│   │   └── pam-lab.rules

│   ├── ssh/

│   │   └── ssh-hardening-notes.md

│   └── firewall/

│       └── ufw-rules.md

│

├── Scripts/

│   ├── account-management/

│   ├── password-management/

│   ├── auditing/

│   └── verification/

│

├── Test-Cases/

│   ├── account-management-tests.md

│   ├── access-control-tests.md

│   ├── password-policy-tests.md

│   ├── audit-tests.md

│   └── ssh-firewall-tests.md

│

└── Screenshots/

&#x20;   ├── 01-Virtual-Machine-Setup/

&#x20;   ├── 02-SSH-Connectivity/

&#x20;   ├── 03-Account-Management/

&#x20;   ├── 04-Role-Based-Access-Control/

&#x20;   ├── 05-Credential-Vault/

&#x20;   ├── 06-Account-Onboarding/

&#x20;   ├── 07-Account-Offboarding/

&#x20;   ├── 08-Password-Management/

&#x20;   ├── 09-Security-Auditing/

&#x20;   ├── 10-SSH-Key-Authentication/

&#x20;   └── 11-Firewall-Configuration/

```



\## Installation and Setup



\### Prerequisites



\- Oracle VirtualBox.

\- Kali Linux VM.

\- Ubuntu Server 24.04 LTS VM.

\- KeePassXC.

\- Network connectivity between the virtual machines.



\### Step 1: Configure the Virtual Machines



Create a VirtualBox NAT Network and attach both virtual machines to it.



Example lab addressing:



| Machine | IP Address |

|---|---|

| Kali Linux | 10.0.2.3 |

| Ubuntu Server | 10.0.2.15 |



\### Step 2: Install Ubuntu Dependencies



```bash

sudo apt update

sudo apt upgrade -y



sudo apt install openssh-server ufw auditd audispd-plugins curl wget vim -y



sudo systemctl enable --now ssh

sudo systemctl enable --now auditd

```



\### Step 3: Configure Access Controls



Create the privileged group and configure the sudoers policy as described in the RBAC section.



Validate the configuration:



```bash

sudo visudo -cf /etc/sudoers

sudo -l -U pam\_admin

sudo -l -U pam\_user

```



\### Step 4: Configure Auditing



Place the audit rules file under:



```text

/etc/audit/rules.d/pam-lab.rules

```



Load and verify:



```bash

sudo augenrules --load

sudo auditctl -l

```



\### Step 5: Configure SSH and Firewall



Set up SSH public-key authentication, then allow SSH before enabling UFW.



```bash

sudo ufw allow OpenSSH

sudo ufw default deny incoming

sudo ufw default allow outgoing

sudo ufw enable

sudo ufw status verbose

```



\## Testing and Evidence



The `Test-Cases/` directory contains test scenarios for:



\- Account lifecycle management.

\- Privileged and standard user access.

\- Password policy configuration.

\- Audit event monitoring.

\- SSH authentication and firewall connectivity.



The `Screenshots/` directory contains visual evidence of the lab setup and implemented controls.



\## CyberArk Concepts and Learning Outcomes



This project provides a practical foundation for understanding enterprise PAM workflows and their relationship to CyberArk components.



| CyberArk Component | Related Concept in This Lab |

|---|---|

| Digital Vault | Encrypted credential storage concepts |

| Safes | Credential grouping and access organization concepts |

| CPM | Password management and rotation concepts |

| PSM | Controlled privileged session access concepts |



These are conceptual mappings only. CyberArk Vault, Safes, CPM and PSM were not deployed in this project.



\### Key Learning Outcomes



\- Linux privileged account administration.

\- User provisioning and deprovisioning.

\- Role-based access control.

\- Credential protection.

\- Password aging policies.

\- Security audit monitoring and investigation.

\- SSH authentication security.

\- Host firewall configuration.

\- Bash scripting and security documentation.



\## Future Enhancements



\- Implement centralized identity management using OpenLDAP.

\- Integrate LDAP authentication with Linux clients.

\- Explore Active Directory integration.

\- Implement automated password rotation and verification.

\- Explore CyberArk Digital Vault, CPM and PSM in a supported lab environment.

\- Improve audit reporting and privileged session monitoring.

\- Add automated test coverage for administrative scripts.



\## Disclaimer



This project was created for educational and cybersecurity laboratory purposes.



All testing was performed in an isolated VirtualBox environment using lab accounts and systems under the project owner's control.



The scripts and configurations are educational examples and should be reviewed, tested and adapted before use in production environments.



\---



\*\*Author:\*\* Rayeni Sumanth Reddy  

\*\*GitHub:\*\* \[@rsumanth25](https://github.com/rsumanth25)



