\# Access Control Test Cases



| Test ID | Test Scenario | Expected Result |

|---|---|---|

| AC-01 | Verify pam\_admin group | Group exists |

| AC-02 | Check pam\_admin privileges | Sudo privileges are available |

| AC-03 | Check pam\_user privileges | Administrative privileges are denied |

| AC-04 | Inspect sudoers configuration | pam\_admins policy is present |

| AC-05 | Validate sudoers syntax | visudo reports valid configuration |



\## Verification Commands



```bash

getent group pam\_admins

sudo -l -U pam\_admin

sudo -l -U pam\_user

sudo visudo -cf /etc/sudoers

