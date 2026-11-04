\# Password Policy Test Cases



| Test ID | Test Scenario | Expected Result |

|---|---|---|

| PP-01 | Rotate privileged account password | Password updated successfully |

| PP-02 | Configure maximum password age | 90 days |

| PP-03 | Configure minimum password age | 1 day |

| PP-04 | Configure warning period | 14 days |

| PP-05 | Verify password aging | chage displays configured values |



\## Verification Command



```bash

sudo chage -l pam\_admin

