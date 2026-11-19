# Windows 11 score checkpoint (from supplied screenshot, November 19, 2026)

**44 points, 13 of 25 flaws solved.** Black entries were scored as completed; red entries were still outstanding at the screenshot. The scoring system, not this toolkit, is authoritative.

## Completed (13)

- Unauthorized users `thaos` and `raedric` removed
- `durance` and `hiravias` no longer Administrators
- `devil` no longer Backup Operator
- Password history at least 11
- Reversible password encryption disabled
- Lockout duration at least 15 minutes
- Credential Validation auditing success and failure
- Manage auditing and security log assigned to Administrators only
- UAC administrator approval mode enabled
- Simple TCP/IP Services stopped and disabled
- Automatic Updates enabled

## Still outstanding (12)

1. Forensics question 1 (8 points), manual investigation
2. Forensics question 2 (8 points), manual investigation
3. `maneha` password expires (3 points), check actual account settings and README
4. Defender exclusion for `C:\ProgramData\Engwithan` removed (4 points), review exact excluded path and evidence first
5. AutoRun commands disabled for all users (5 points), inspect registry and policy precedence
6. Windows build at least `26300.9711` (4 points), approved OS update required
7. Patron card CSV removed (3 points), locate and verify exact file without destructive guesses
8. Ophcrack password-cracker archive removed (3 points), identify archive first
9. Python removed (4 points), check dependencies before uninstalling
10. `soulbind.pyw` Python backdoor removed (5 points), inspect persistence and preserve evidence
11. RDP encryption level High (5 points), requires configuration review
12. Chrome malicious-download restrictions (5 points), inspect effective browser policy

**Note:** The color of some rows may change between score refreshes. Never assume a specific point gain until verified by the official score report.
