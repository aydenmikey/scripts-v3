# Windows 11 | All 25 Scoring Flaws

One section per flaw from the supplied OKCUP Round 2 scoring screenshot. **Read the image README, take a VM snapshot, and preview changes** before making image-specific modifications. Some items are examples, not universal fixes. Commands assume **Windows PowerShell 5.1 as Administrator** and may require OS-specific modules.

**Checkpoint (November 19, 2026): 44 points, 13 solved, 12 outstanding.** Status labels reflect that screenshot and can change after rescoring.

## Jump to flaw

1. [Forensics Question 1](#flaw-01)
2. [Forensics Question 2](#flaw-02)
3. [Unauthorized user: thaos](#flaw-03)
4. [Unauthorized user: raedric](#flaw-04)
5. [durance is not an administrator](#flaw-05)
6. [hiravias is not an administrator](#flaw-06)
7. [devil is not a Backup Operator](#flaw-07)
8. [maneha password expires](#flaw-08)
9. [Password history 11 or more](#flaw-09)
10. [Reversible password encryption disabled](#flaw-10)
11. [Lockout duration 15 minutes or more](#flaw-11)
12. [Audit Credential Validation success and failure](#flaw-12)
13. [Manage auditing and security log: Administrators only](#flaw-13)
14. [UAC: all administrators in Admin Approval Mode](#flaw-14)
15. [Remove Defender exclusion: C:\ProgramData\Engwithan](#flaw-15)
16. [Disable AutoRun commands for all users](#flaw-16)
17. [Simple TCP/IP Services stopped and disabled](#flaw-17)
18. [Windows build 26300.9711 or later](#flaw-18)
19. [Configure Automatic Updates enabled](#flaw-19)
20. [Remove patron card data (CSV)](#flaw-20)
21. [Remove Ophcrack password cracker archive](#flaw-21)
22. [Remove Python](#flaw-22)
23. [Remove Python backdoor soulbind.pyw](#flaw-23)
24. [RDP connection encryption level High](#flaw-24)
25. [Chrome download restrictions block malicious downloads](#flaw-25)

---

<a id="flaw-01"></a>
## 01. Forensics Question 1 (8 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "$env:USERPROFILE\Desktop" -Force | Select-Object Name,FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Review the answer in the official scoring report.
```

**Notes:** Read the image README and question text. Investigate without altering evidence.

---

<a id="flaw-02"></a>
## 02. Forensics Question 2 (8 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "$env:USERPROFILE\Desktop" -Force | Select-Object Name,FullName
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Review the answer in the official scoring report.
```

**Notes:** The question wording is needed to provide a precise investigation.

---

<a id="flaw-03"></a>
## 03. Unauthorized user: thaos (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-LocalUser -Name "thaos" -ErrorAction SilentlyContinue
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalUser -Name "thaos"
```

**Verify**

```powershell
Get-LocalUser -Name "thaos" -ErrorAction SilentlyContinue
```

**Notes:** Only if README says unauthorized. Destructive account deletion; take snapshot first.

---

<a id="flaw-04"></a>
## 04. Unauthorized user: raedric (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-LocalUser -Name "raedric" -ErrorAction SilentlyContinue
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalUser -Name "raedric"
```

**Verify**

```powershell
Get-LocalUser -Name "raedric" -ErrorAction SilentlyContinue
```

**Notes:** Only if README says unauthorized.

---

<a id="flaw-05"></a>
## 05. durance is not an administrator (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-LocalGroupMember -Group "Administrators"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalGroupMember -Group "Administrators" -Member "durance"
```

**Verify**

```powershell
Get-LocalGroupMember -Group "Administrators"
```

**Notes:** Check README: removes privileges, not account.

---

<a id="flaw-06"></a>
## 06. hiravias is not an administrator (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-LocalGroupMember -Group "Administrators"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalGroupMember -Group "Administrators" -Member "hiravias"
```

**Verify**

```powershell
Get-LocalGroupMember -Group "Administrators"
```

**Notes:** Check README: removes privileges, not account.

---

<a id="flaw-07"></a>
## 07. devil is not a Backup Operator (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-LocalGroupMember -Group "Backup Operators"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-LocalGroupMember -Group "Backup Operators" -Member "devil"
```

**Verify**

```powershell
Get-LocalGroupMember -Group "Backup Operators"
```

**Notes:** Already confirmed empty in this image.

---

<a id="flaw-08"></a>
## 08. maneha password expires (3 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-LocalUser -Name "maneha" | Select-Object Name,Enabled,PasswordNeverExpires,PasswordExpires
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Set-LocalUser -Name "maneha" -PasswordNeverExpires $false
```

**Verify**

```powershell
Get-LocalUser -Name "maneha" | Select-Object Name,PasswordNeverExpires,PasswordExpires
```

**Notes:** Verify account must expire under the README; this changes account flag only.

---

<a id="flaw-09"></a>
## 09. Password history 11 or more (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
net accounts
```

**Suggested fix (run only if authorized and relevant)**

```powershell
net accounts /uniquepw:12
```

**Verify**

```powershell
net accounts
```

**Notes:** Local policy may be overridden by domain GPO.

---

<a id="flaw-10"></a>
## 10. Reversible password encryption disabled (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
secedit /export /cfg "$env:TEMP\policy-check.inf"; Select-String "$env:TEMP\policy-check.inf" -Pattern "ClearTextPassword"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
.\Start-Hardening.ps1 -Profile Windows11 -Apply
```

**Verify**

```powershell
secedit /export /cfg "$env:TEMP\policy-check.inf"; Select-String "$env:TEMP\policy-check.inf" -Pattern "ClearTextPassword"
```

**Notes:** Expect ClearTextPassword = 0. Use bundled baseline after preview.

---

<a id="flaw-11"></a>
## 11. Lockout duration 15 minutes or more (3 points)

**Status:** DONE 11/19

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

**Notes:** Check lockout threshold and reset window too.

---

<a id="flaw-12"></a>
## 12. Audit Credential Validation success and failure (3 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
auditpol /get /subcategory:"Credential Validation"
```

**Suggested fix (run only if authorized and relevant)**

```powershell
auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable
```

**Verify**

```powershell
auditpol /get /subcategory:"Credential Validation"
```

---

<a id="flaw-13"></a>
## 13. Manage auditing and security log: Administrators only (4 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeSecurityPrivilege"
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
secedit /export /cfg "$env:TEMP\rights.inf" /areas USER_RIGHTS; Select-String "$env:TEMP\rights.inf" -Pattern "SeSecurityPrivilege"
```

**Notes:** User Rights Assignment must use correct SID(s). Do not overwrite security templates blindly.

---

<a id="flaw-14"></a>
## 14. UAC: all administrators in Admin Approval Mode (4 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | Select-Object EnableLUA
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name EnableLUA -Value 1
```

**Verify**

```powershell
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System").EnableLUA
```

**Notes:** Might require restart.

---

<a id="flaw-15"></a>
## 15. Remove Defender exclusion: C:\ProgramData\Engwithan (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
(Get-MpPreference).ExclusionPath
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Remove-MpPreference -ExclusionPath "C:\ProgramData\Engwithan"
```

**Verify**

```powershell
(Get-MpPreference).ExclusionPath
```

**Notes:** Before removal, identify files and any legitimate dependency. Removal can improve scanning but does not itself delete malware.

---

<a id="flaw-16"></a>
## 16. Disable AutoRun commands for all users (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ErrorAction SilentlyContinue | Select-Object NoDriveTypeAutoRun,NoAutorun
```

**Suggested fix (run only if authorized and relevant)**

```powershell
New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name NoDriveTypeAutoRun -Value 255 -PropertyType DWord -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name NoAutorun -Value 1 -PropertyType DWord -Force | Out-Null
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Select-Object NoDriveTypeAutoRun,NoAutorun
```

**Notes:** System policy scope may matter; inspect GPO and user keys if score remains red.

---

<a id="flaw-17"></a>
## 17. Simple TCP/IP Services stopped and disabled (4 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-Service -Name SimpTcp -ErrorAction SilentlyContinue
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Stop-Service SimpTcp -ErrorAction SilentlyContinue; Set-Service SimpTcp -StartupType Disabled
```

**Verify**

```powershell
Get-Service -Name SimpTcp -ErrorAction SilentlyContinue
```

---

<a id="flaw-18"></a>
## 18. Windows build 26300.9711 or later (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ComputerInfo | Select-Object WindowsProductName,OsVersion,OsBuildNumber
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Start-Process ms-settings:windowsupdate
```

**Verify**

```powershell
Get-ComputerInfo | Select-Object OsBuildNumber,OsVersion
```

**Notes:** Specific build target is score-image-specific. Use trusted approved Windows Update, not unofficial upgrade packages.

---

<a id="flaw-19"></a>
## 19. Configure Automatic Updates enabled (4 points)

**Status:** DONE 11/19

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -ErrorAction SilentlyContinue | Select-Object NoAutoUpdate,AUOptions
```

**Suggested fix (run only if authorized and relevant)**

```powershell
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null; New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -PropertyType DWord -Value 0 -Force | Out-Null
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" | Select-Object NoAutoUpdate,AUOptions
```

**Notes:** A policy bit does not guarantee successful patching.

---

<a id="flaw-20"></a>
## 20. Remove patron card data (CSV) (3 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "C:\Users","C:\ProgramData" -Recurse -File -Filter "*.csv" -ErrorAction SilentlyContinue | Select-Object FullName,Length
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Check official score after handling the correctly identified file.
```

**Notes:** Identify exact file first; do not print patron information into reports or publish it. Preserve evidence and remove only as authorized.

---

<a id="flaw-21"></a>
## 21. Remove Ophcrack password cracker archive (3 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ChildItem "C:\Users","C:\ProgramData" -Recurse -File -ErrorAction SilentlyContinue | Where-Object Name -match "(?i)ophcrack" | Select-Object FullName,Length
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Confirm targeted archive no longer exists after authorized removal.
```

**Notes:** Never delete by wildcard without confirming paths.

---

<a id="flaw-22"></a>
## 22. Remove Python (4 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue | Where-Object DisplayName -match "^Python" | Select-Object DisplayName,DisplayVersion
```

**Suggested fix (run only if authorized and relevant)**

```powershell
Start-Process appwiz.cpl
```

**Verify**

```powershell
Get-Command python,py -ErrorAction SilentlyContinue
```

**Notes:** Confirm required services and backdoor analysis are complete before uninstalling.

---

<a id="flaw-23"></a>
## 23. Remove Python backdoor soulbind.pyw (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ScheduledTask | Where-Object {($_.Actions | Out-String) -match "soulbind|Engwithan"} | Select-Object TaskName,TaskPath,State,Actions; Get-ChildItem "C:\ProgramData\Engwithan" -Force -ErrorAction SilentlyContinue
```

**Fix:** Manual investigation required; do not run unverified destructive commands.

**Verify**

```powershell
Get-ScheduledTask | Where-Object {($_.Actions | Out-String) -match "soulbind|Engwithan"}; Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue
```

**Notes:** Record task, file hash and path first; identify persistence, then disable offending task and quarantine using approved process. Do not execute suspected files.

---

<a id="flaw-24"></a>
## 24. RDP connection encryption level High (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" | Select-Object MinEncryptionLevel,SecurityLayer,UserAuthentication
```

**Suggested fix (run only if authorized and relevant)**

```powershell
.\Modules\Set-RdpHighEncryption.ps1 -Apply
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" | Select-Object MinEncryptionLevel,SecurityLayer,UserAuthentication
```

**Notes:** Preview module first; may disconnect older clients.

---

<a id="flaw-25"></a>
## 25. Chrome download restrictions block malicious downloads (5 points)

**Status:** REVIEW

**Inspect (read-only)**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Google\Chrome" -ErrorAction SilentlyContinue | Select-Object DownloadRestrictions
```

**Suggested fix (run only if authorized and relevant)**

```powershell
.\Start-Hardening.ps1 -Profile Windows11 -Apply
```

**Verify**

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Google\Chrome" -ErrorAction SilentlyContinue | Select-Object DownloadRestrictions
```

**Notes:** Verify actual browser effective policy at chrome://policy, and follow image instructions.

---
