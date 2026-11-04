\# Security Audit Test Cases



| Test ID | Test Scenario | Expected Result |

|---|---|---|

| AU-01 | Start auditd | Service is active |

| AU-02 | Load audit rules | Rules appear in auditctl |

| AU-03 | Modify a user account | Account change event is recorded |

| AU-04 | Execute sudo command | Privileged command event is recorded |

| AU-05 | Search account audit events | Matching events are displayed |

| AU-06 | Search password-related events | Matching file access events are displayed |



\## Verification Commands



```bash

sudo systemctl status auditd

sudo auditctl -l

sudo ausearch -k user\_account\_changes -ts recent -i

sudo ausearch -x sudo -ts recent -i

