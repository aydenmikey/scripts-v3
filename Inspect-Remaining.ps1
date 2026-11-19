#requires -Version 5.1
<# Read-only triage for the unsolved OKCUP Windows 11 items. Does not delete evidence. #>
[CmdletBinding()]
param([switch]$Deep)
$ErrorActionPreference='Continue'
$root=Split-Path -Parent $PSScriptRoot
$dir=Join-Path $root 'Reports'
New-Item -Path $dir -ItemType Directory -Force | Out-Null
$out=Join-Path $dir ('Remaining-{0}.txt' -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
function Section([string]$Title,[scriptblock]$Body) {
 "`n==== $Title ====" | Out-File $out -Append -Encoding UTF8
 try { & $Body 2>&1 | Out-String -Width 240 | Out-File $out -Append -Encoding UTF8 }
 catch {"ERROR: $_" | Out-File $out -Append -Encoding UTF8}
}
Section 'Account expiration' {
 Get-LocalUser | Select-Object Name,Enabled,PasswordExpires,PasswordLastSet | Format-Table -AutoSize
}
Section 'Defender exclusions' {Get-MpPreference | Select-Object ExclusionPath,ExclusionProcess,ExclusionExtension | Format-List}
Section 'Explorer AutoRun policies' {
 Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -ErrorAction SilentlyContinue |
  Select-Object NoDriveTypeAutoRun,NoAutorun | Format-List
}
Section 'Scheduled tasks with non-Microsoft actions' {
 Get-ScheduledTask | Where-Object {$_.TaskPath -notlike '\Microsoft\*'} |
  Select-Object TaskName,TaskPath,State,@{n='Action';e={($_.Actions | ForEach-Object { $_.Execute+' '+$_.Arguments }) -join ' | '}} |
  Format-Table -Wrap -AutoSize
}
Section 'Service executable locations' {
 Get-CimInstance Win32_Service | Where-Object {$_.PathName -match 'ProgramData|AppData|Temp|Python'} |
 Select-Object Name,State,PathName | Format-Table -Wrap -AutoSize
}
Section 'Suspect folder inventory (names only)' {
 if(Test-Path 'C:\ProgramData\Engwithan') {
  Get-ChildItem 'C:\ProgramData\Engwithan' -Recurse -Force -File -ErrorAction SilentlyContinue |
  Select-Object FullName,Length,LastWriteTime | Format-Table -Wrap -AutoSize
 }
}
Section 'Python installs' {
 Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue |
  Where-Object {$_.DisplayName -match 'Python|Ophcrack'} |
  Select-Object DisplayName,DisplayVersion,InstallLocation | Format-Table -AutoSize
}
Section 'RDP encryption properties' {
 Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -ErrorAction SilentlyContinue |
 Select-Object MinEncryptionLevel,SecurityLayer,UserAuthentication | Format-List
}
Section 'Chrome download policy' {
 Get-ItemProperty 'HKLM:\SOFTWARE\Policies\Google\Chrome' -ErrorAction SilentlyContinue |
 Select-Object DownloadRestrictions,SafeBrowsingProtectionLevel,HttpsOnlyMode | Format-List
}
Section 'Windows version' {Get-CimInstance Win32_OperatingSystem | Select-Object Caption,Version,BuildNumber | Format-List}
if($Deep) {
 Section 'Filename triage of user and public data' {
  Get-ChildItem 'C:\Users' -Recurse -Force -File -ErrorAction SilentlyContinue |
   Where-Object {$_.Name -match '(?i)patron.*\.csv$|ophcrack|soulbind\.pyw$'} |
   Select-Object -First 100 FullName,Length,LastWriteTime | Format-Table -AutoSize
 }
}
Write-Host "Read-only report saved: $out" -ForegroundColor Green
