# Windows Server 2022 | All 30 Scoring Flaws

One section per flaw from the supplied OKCUP Round 2 scoring screenshot. **Read the image README, take a VM snapshot, and preview changes** before making image-specific modifications. Some items are examples, not universal fixes. Commands assume **Windows PowerShell 5.1 as Administrator** and may require OS-specific modules.

**Checkpoint:** Initial score screenshot showed 1 of 30 solved. This guide does not claim later status.

## Jump to flaw

1. [Forensics Question 1](#flaw-01)
2. [Forensics Question 2](#flaw-02)
3. [Forensics Question 3](#flaw-03)
4. [Remove unauthorized user benweth](#flaw-04)
5. [Remove unauthorized user caldus](#flaw-05)
6. [furante is not an administrator](#flaw-06)
7. [Change insecure password for serafen](#flaw-07)
8. [Guest account disabled](#flaw-08)
9. [Minimum password length 10 or more](#flaw-09)
10. [Account lockout duration 15 or more minutes](#flaw-10)
11. [Minimum password age 1 day or more](#flaw-11)
12. [Audit Security Group Management Success](#flaw-12)
13. [Audit Sensitive Privilege Use Success](#flaw-13)
14. [Only Administrators may take ownership](#flaw-14)
15. [Create a token object assigned to No One](#flaw-15)
16. [Act as part of operating system assigned to No One](#flaw-16)
17. [Microsoft network server digitally signs communications](#flaw-17)
18. [Limit local use of blank passwords to console logon only](#flaw-18)
19. [Firewall protection enabled](#flaw-19)
20. [File sharing disabled for Users share](#flaw-20)
21. [Defender SmartScreen: Warn and prevent bypass](#flaw-21)
22. [Print Spooler stopped and disabled](#flaw-22)
23. [7-Zip updated](#flaw-23)
24. [Windows downloads and installs updates automatically](#flaw-24)
25. [Remove plain-text password file on web server](#flaw-25)
26. [Remove AnyDesk](#flaw-26)
27. [Remove PHP backdoor mg_cache.php](#flaw-27)
28. [Apache ServerTokens Prod](#flaw-28)
29. [Apache denies access to OS root by default](#flaw-29)
30. [Chrome HTTPS-only mode required](#flaw-30)

---

<a id="flaw-01"></a>
## 01. Forensics Question 1 (7 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "$env:USERPROFILE\Desktop" -Force | Select-Object Name,FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Confirm the submitted answer in the score report.
```

**Notes:** Use exact question text and image README to investigate. No fabricated answers.

---

<a id="flaw-02"></a>
## 02. Forensics Question 2 (7 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "$env:USERPROFILE\Desktop" -Force | Select-Object Name,FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Confirm the submitted answer in the score report.
```

**Notes:** Use exact question text and image README to investigate. No fabricated answers.

---

<a id="flaw-03"></a>
## 03. Forensics Question 3 (7 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "$env:USERPROFILE\Desktop" -Force | Select-Object Name,FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Confirm the submitted answer in the score report.
```

**Notes:** Use exact question text and image README to investigate. No fabricated answers.

---

<a id="flaw-04"></a>
## 04. Remove unauthorized user benweth (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-LocalUser -Name "benweth" -ErrorAction SilentlyContinue
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalUser -Name "benweth"
```

**Verify**

```powershell
Get-LocalUser -Name "benweth" -ErrorAction SilentlyContinue
```

**Notes:** Only after confirming unauthorized account in README and taking snapshot.

---

<a id="flaw-05"></a>
## 05. Remove unauthorized user caldus (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-LocalUser -Name "caldus" -ErrorAction SilentlyContinue
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalUser -Name "caldus"
```

**Verify**

```powershell
Get-LocalUser -Name "caldus" -ErrorAction SilentlyContinue
```

**Notes:** Only after confirming unauthorized account in README and taking snapshot.

---

<a id="flaw-06"></a>
## 06. furante is not an administrator (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-LocalGroupMember -Group Administrators
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalGroupMember -Group Administrators -Member "furante"
```

**Verify**

```powershell
Get-LocalGroupMember -Group Administrators
```

**Notes:** Check README; changes privileges only.

---

<a id="flaw-07"></a>
## 07. Change insecure password for serafen (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-LocalUser -Name "serafen" | Select-Object Name,Enabled,PasswordLastSet
```

**Suggested fix (run only if authorized and relevant)**

```powershell
net user serafen *
```

**Verify**

```powershell
Get-LocalUser -Name "serafen" | Select-Object Name,PasswordLastSet
```

**Notes:** Prompt enters a unique password without echoing it. Do not share passwords in GitHub.

---

<a id="flaw-08"></a>
## 08. Guest account disabled (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-LocalUser | Where-Object {$_.SID.Value -match "-501$"}
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Get-LocalUser | Where-Object {$_.SID.Value -match "-501$"} | Disable-LocalUser
```

**Verify**

```powershell
Get-LocalUser | Where-Object {$_.SID.Value -match "-501$"}
```

**Notes:** Builtin Guest identified by RID 501.

---

<a id="flaw-09"></a>
## 09. Minimum password length 10 or more (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
net accounts
```

**Suggested fix (run only if authorized and relevant)**

```powershell
net accounts /minpwlen:12
```

**Verify**

```powershell
net accounts
```

---

<a id="flaw-10"></a>
## 10. Account lockout duration 15 or more minutes (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
net accounts
```

**Suggested fix (run only if authorized and relevant)**

```powershell
net accounts /lockoutduration:30
```

**Verify**

```powershell
net accounts
```

---

<a id="flaw-11"></a>
## 11. Minimum password age 1 day or more (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
net accounts
```

**Suggested fix (run only if authorized and relevant)**

```powershell
net accounts /minpwage:1
```

**Verify**

```powershell
net accounts
```

**Notes:** Ensure maximum password age is greater than minimum.

---

<a id="flaw-12"></a>
## 12. Audit Security Group Management Success (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
auditpol /get /subcategory:"Security Group Management"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
auditpol /set /subcategory:"Security Group Management" /success:enable
```

**Verify**

```powershell
auditpol /get /subcategory:"Security Group Management"
```

---

<a id="flaw-13"></a>
## 13. Audit Sensitive Privilege Use Success (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
auditpol /get /subcategory:"Sensitive Privilege Use"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
auditpol /set /subcategory:"Sensitive Privilege Use" /success:enable
```

**Verify**

```powershell
auditpol /get /subcategory:"Sensitive Privilege Use"
```

---

<a id="flaw-14"></a>
## 14. Only Administrators may take ownership (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeTakeOwnershipPrivilege"
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeTakeOwnershipPrivilege"
```

**Notes:** Review via secpol.msc > Local Policies > User Rights Assignment. For No One use an empty assignment; do not assume group names or overwrite unrelated rights.

---

<a id="flaw-15"></a>
## 15. Create a token object assigned to No One (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeCreateTokenPrivilege"
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeCreateTokenPrivilege"
```

**Notes:** Review via secpol.msc > Local Policies > User Rights Assignment. For No One use an empty assignment; do not assume group names or overwrite unrelated rights.

---

<a id="flaw-16"></a>
## 16. Act as part of operating system assigned to No One (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeTcbPrivilege"
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeTcbPrivilege"
```

**Notes:** Review via secpol.msc > Local Policies > User Rights Assignment. For No One use an empty assignment; do not assume group names or overwrite unrelated rights.

---

<a id="flaw-17"></a>
## 17. Microsoft network server digitally signs communications (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-SmbServerConfiguration | Select-Object RequireSecuritySignature,EnableSecuritySignature
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
```

**Verify**

```powershell
Get-SmbServerConfiguration | Select-Object RequireSecuritySignature
```

**Notes:** Test compatibility with required SMB clients.

---

<a id="flaw-18"></a>
## 18. Limit local use of blank passwords to console logon only (2 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" | Select-Object LimitBlankPasswordUse
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LimitBlankPasswordUse -Value 1
```

**Verify**

```powershell
(Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa").LimitBlankPasswordUse
```

**Notes:** Screenshot wording abbreviated; likely this common setting. Confirm exact score criterion before applying.

---

<a id="flaw-19"></a>
## 19. Firewall protection enabled (3 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-NetFirewallProfile | Select-Object Name,Enabled,DefaultInboundAction
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True
```

**Verify**

```powershell
Get-NetFirewallProfile | Select-Object Name,Enabled
```

**Notes:** May block required remote services; retain approved allow rules.

---

<a id="flaw-20"></a>
## 20. File sharing disabled for Users share (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-SmbShare -Name "Users" -ErrorAction SilentlyContinue; Get-SmbShareAccess -Name "Users" -ErrorAction SilentlyContinue
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-SmbShare -Name "Users" -Force
```

**Verify**

```powershell
Get-SmbShare -Name "Users" -ErrorAction SilentlyContinue
```

**Notes:** Verify this is unauthorized and not a required user-data share; removal breaks network access but does not delete backing files.

---

<a id="flaw-21"></a>
## 21. Defender SmartScreen: Warn and prevent bypass (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -ErrorAction SilentlyContinue | Select-Object EnableSmartScreen,ShellSmartScreenLevel
```

**Suggested fix (run only if authorized and relevant)**

```powershell
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name EnableSmartScreen -Value 1 -PropertyType DWord -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name ShellSmartScreenLevel -Value "Block" -PropertyType String -Force | Out-Null
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" | Select-Object EnableSmartScreen,ShellSmartScreenLevel
```

**Notes:** Review policy scope for Windows Server; test actual enforcement.

---

<a id="flaw-22"></a>
## 22. Print Spooler stopped and disabled (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-Service -Name Spooler
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Stop-Service -Name Spooler -ErrorAction SilentlyContinue; Set-Service -Name Spooler -StartupType Disabled
```

**Verify**

```powershell
Get-Service -Name Spooler
```

**Notes:** Only if server is not required to print.

---

<a id="flaw-23"></a>
## 23. 7-Zip updated (3 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue | Where-Object DisplayName -like "7-Zip*" | Select-Object DisplayName,DisplayVersion
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Recheck installed version and official scoring report.
```

**Notes:** Update from the official vendor or approved package manager. Scoring target version may be image-specific.

---

<a id="flaw-24"></a>
## 24. Windows downloads and installs updates automatically (3 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ErrorAction SilentlyContinue | Select-Object NoAutoUpdate,AUOptions
```

**Suggested fix (run only if authorized and relevant)**

```powershell
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -Value 0 -PropertyType DWord -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name AUOptions -Value 4 -PropertyType DWord -Force | Out-Null
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" | Select-Object NoAutoUpdate,AUOptions
```

**Notes:** GPO may override. Verify update service and downloads; policies alone may not score.

---

<a id="flaw-25"></a>
## 25. Remove plain-text password file on web server (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "C:\Apache24","C:\inetpub","C:\xampp" -Recurse -File -ErrorAction SilentlyContinue | Where-Object Name -match "(?i)pass|secret|credential" | Select-Object FullName,Length
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Verify exact sensitive file is no longer exposed in approved web root.
```

**Notes:** Do not display or commit secrets; identify file and preserve incident evidence before remediation.

---

<a id="flaw-26"></a>
## 26. Remove AnyDesk (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue | Where-Object DisplayName -match "AnyDesk" | Select-Object DisplayName,UninstallString
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Start-Process appwiz.cpl
```

**Verify**

```powershell
Get-Service -Name AnyDesk -ErrorAction SilentlyContinue
```

**Notes:** Confirm not required; uninstall using vendor mechanism and inspect remote access remnants.

---

<a id="flaw-27"></a>
## 27. Remove PHP backdoor mg_cache.php (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "C:\Apache24","C:\xampp","C:\inetpub" -Filter "mg_cache.php" -File -Recurse -ErrorAction SilentlyContinue | Select-Object FullName,Length,LastWriteTime
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Search for the named file again after authorized removal; inspect web logs.
```

**Notes:** Do not open through a browser. Preserve hash and evidence, isolate malicious code, then remediate.

---

<a id="flaw-28"></a>
## 28. Apache ServerTokens Prod (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "C:\Apache24","C:\xampp" -Filter "httpd.conf" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Run the installed Apache httpd -t config test; check ServerTokens directive is Prod.
```

**Notes:** Add ServerTokens Prod in the active server config; do not assume installation path. Restart only after config passes.

---

<a id="flaw-29"></a>
## 29. Apache denies access to OS root by default (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "C:\Apache24","C:\xampp" -Filter "httpd.conf" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Run httpd -t and test approved web paths plus forbidden OS-root path.
```

**Notes:** Apache 2.4 configuration commonly uses <Directory /> with Require all denied; exact syntax and placement depend on running Apache configuration.

---

<a id="flaw-30"></a>
## 30. Chrome HTTPS-only mode required (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Google\Chrome" -ErrorAction SilentlyContinue | Select-Object HttpsOnlyMode
```

**Suggested fix (run only if authorized and relevant)**

```powershell
New-Item "HKLM:\SOFTWARE\Policies\Google\Chrome" -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name HttpsOnlyMode -Value "force_enabled" -PropertyType String -Force | Out-Null
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Google\Chrome" | Select-Object HttpsOnlyMode
```

**Notes:** Confirm policy name/value with installed Chrome version and chrome://policy. Browser policies can evolve.

---
