\# Account Management Test Cases



| Test ID | Test Scenario | Expected Result |

|---|---|---|

| AM-01 | Create a new user | User account is created successfully |

| AM-02 | Create an existing username | Script rejects duplicate account |

| AM-03 | Assign privileged group | User is added to pam\_admins |

| AM-04 | Verify group membership | id command displays pam\_admins |

| AM-05 | Offboard a user | Privileged group membership is removed |

| AM-06 | Lock an offboarded account | Account password status shows L |

| AM-07 | Offboard protected account | Script rejects the operation |



\## Lab Evidence



\- User creation

\- Privilege assignment

\- Account offboarding

\- Account lock verification

