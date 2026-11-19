# Scoring report mapping (provided screenshots, OKCUP Round 2)

These are **image-specific** scoring criteria, not a universal baseline. Actions marked REVIEW require examining the competition README and files. Automatic baseline is opt-in and may not match every image's expected settings.

## Windows 11 (25 flaws)

| Flaw | Approach |
|---|---|
| Forensics questions 1 and 2 | REVIEW: investigate and answer manually |
| Remove unauthorized users thaos, raedric | REVIEW: compare accounts with README; no automatic deletion |
| Remove durance, hiravias from Administrators | REVIEW: check authorized administrators |
| Remove devil from Backup Operators | REVIEW: check local group membership |
| User maneha password expires | REVIEW: inspect exact account name and expiry policy |
| Password history >= 11 | BASELINE: sets 12 |
| Passwords not stored using reversible encryption | BASELINE: disables reversible encryption |
| Lockout duration >= 15 minutes | BASELINE: sets 30 minutes |
| Audit Credential Validation success/failure | BASELINE: sets audit subcategory |
| Manage auditing and security log assigned to Administrators only | REVIEW: check User Rights Assignment |
| Run all administrators in Admin Approval Mode | BASELINE: EnableLUA |
| Remove Defender exclusion C:\ProgramData\Engwithan | REVIEW: verify suspicious exclusion before removal |
| AutoRun disabled | REVIEW: policy consistency and device requirements |
| Simple TCP/IP Services stopped / disabled | BASELINE: Windows11 profile |
| Windows updated to build 26300.9711 or later | REVIEW: apply approved OS updates; build is image-specific |
| Automatic updates enabled | BASELINE: policy (verify group policy precedence) |
| Remove patron card data CSV | REVIEW: preserve evidence and verify path before deletion |
| Remove Ophcrack archive | REVIEW: inspect archive |
| Remove Python | REVIEW: whether authorized/required |
| Remove Python backdoor soulbind.pyw | REVIEW: investigate task, service, file and hash before removal |
| RDP connection encryption high | REVIEW: RDP is environment-specific; test client compatibility |
| Chrome download restrictions | BASELINE: DownloadRestrictions policy |

## Windows Server 2022 (30 flaws)

| Flaw | Approach |
|---|---|
| Forensics questions 1, 2 and 3 | REVIEW: investigate manually |
| Remove users benweth, caldus | REVIEW: compare README |
| Remove furante from administrators | REVIEW: inspect group membership |
| Change insecure password for serafen | REVIEW: reset only authorized user to unique password |
| Disable Guest | BASELINE |
| Minimum password length >= 10 | BASELINE: sets 12 |
| Lockout duration >= 15 minutes | BASELINE: sets 30 |
| Minimum password age >= 1 day | BASELINE: sets 1 |
| Security Group Management success audit | BASELINE |
| Sensitive Privilege Use success audit | BASELINE |
| Only administrators take ownership | REVIEW: user rights assignment |
| Create token object assigned to No One | REVIEW: user rights assignment |
| Act as part of operating system assigned to No One | REVIEW: user rights assignment |
| Digitally sign Microsoft network server communications | REVIEW: SMB compatibility with required clients |
| Limit local logon to console only | REVIEW: clarify scoring setting and remote-management needs |
| Firewall protection enabled | BASELINE |
| File sharing disabled for Users share | REVIEW: protect required shares before changing |
| Defender SmartScreen warns/prevents bypass | REVIEW: distinguish Edge/Explorer policies |
| Print Spooler stopped/disabled | BASELINE: Server profile, only if not needed |
| 7-Zip updated | REVIEW: update via approved source |
| Windows downloads/installs updates | BASELINE: sets policy, then verify functioning |
| Remove plain-text password file on web server | REVIEW: investigate, backup and securely remove |
| Remove AnyDesk | REVIEW: confirm unauthorized |
| Remove PHP backdoor mg_cache.php | REVIEW: investigate and remediate web root |
| Apache ServerTokens Prod | REVIEW: requires Apache config location |
| Apache denies access to OS root directory | REVIEW: requires Apache config validation |
| Chrome HTTPS-only mode required | BASELINE: Chrome policy; verify browser honors it |

Note: Rows transcribed from user screenshot. Confirm spelling in the original HTML score report before using account names.
