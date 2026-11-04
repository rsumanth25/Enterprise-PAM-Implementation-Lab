\# SSH and Firewall Test Cases



| Test ID | Test Scenario | Expected Result |

|---|---|---|

| SF-01 | Generate Ed25519 SSH key | Key pair is generated |

| SF-02 | Copy public key to Ubuntu | Public key is installed |

| SF-03 | Establish fresh SSH connection | Key-based authentication succeeds |

| SF-04 | Inspect SSH configuration | Public key authentication enabled |

| SF-05 | Enable UFW | Firewall becomes active |

| SF-06 | Verify incoming policy | Default deny |

| SF-07 | Verify outgoing policy | Default allow |

| SF-08 | Verify SSH firewall rule | Port 22 allowed |

| SF-09 | Test SSH after firewall activation | Connection succeeds |



\## Verification Commands



```bash

sudo sshd -T

sudo ufw status verbose

ssh sumanth@10.0.2.15

