\# SSH Security Configuration



\## Environment

\- Client: Kali Linux

\- Server: Ubuntu Server 24.04 LTS

\- SSH Port: 22

\- Server IP: 10.0.2.15



\## Implemented Security Controls



\- OpenSSH server installed and enabled.

\- SSH public-key authentication enabled.

\- Ed25519 SSH key generated on Kali Linux.

\- Public key copied to the Ubuntu server.

\- Key-based SSH login successfully tested.

\- Root password-based SSH login disabled.



\## Verified SSH Settings



| Setting | Value |

|---|---|

| PubkeyAuthentication | yes |

| PasswordAuthentication | yes |

| PermitRootLogin | without-password |



\## Security Notes



Password authentication remains enabled as a recovery option.

SSH key-based authentication was verified using a fresh connection.



Private SSH keys must never be committed to GitHub.

