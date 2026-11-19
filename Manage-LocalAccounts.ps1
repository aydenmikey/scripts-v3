#requires -Version 5.1
#requires -RunAsAdministrator
<#
  Interactive local-account management. No hardcoded credentials or unattended mass removal.
  Use only after identifying authorized users and roles from the image README.
#>
[CmdletBinding()]
param([ValidateSet('List','RemoveUsers','RemoveAdmins','RemoveBackupOperators','ResetPassword','SetPasswordExpiration')]
[string]$Action='List', [string[]]$Names)
$ErrorActionPreference='Stop'
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
$mySid=$identity.User.Value
if($Action -eq 'List') {
 Get-LocalUser | Select-Object Name,Enabled,PasswordExpires,SID | Format-Table -AutoSize
 foreach($group in @('Administrators','Backup Operators')) {
   Write-Host "`n$group" -ForegroundColor Cyan
   Get-LocalGroupMember -Group $group -ErrorAction Continue | Format-Table -AutoSize
 }
 return
}
if(-not $Names -or $Names.Count -eq 0) {
 $answer=Read-Host 'Enter usernames separated by commas'
 $Names=@($answer -split ',' | ForEach-Object {$_.Trim()} | Where-Object {$_} | Select-Object -Unique)
}
if(-not $Names) { Write-Host 'No accounts supplied'; return }
$selected=@()
foreach($n in $Names) {
 try {$u=Get-LocalUser -Name $n -ErrorAction Stop} catch {Write-Warning "Not found: $n";continue}
 $rid=$u.SID.Value.Split('-')[-1]
 if($u.SID.Value -eq $mySid -or $rid -in @('500','501','503','504')) {
   Write-Warning "Protected current/built-in account: $n"; continue
 }
 $selected+= $u
}
if(-not $selected) {Write-Host 'Nothing eligible to change.';return}
Write-Host "`nProposed operation: $Action" -ForegroundColor Yellow
$selected | Select-Object Name,Enabled,SID | Format-Table -AutoSize
Write-Warning 'Confirm each selected user/role against the image README. User deletion cannot be undone by the CSV log.'
if((Read-Host 'Type CONFIRM to proceed') -cne 'CONFIRM') {Write-Host 'Cancelled';return}
$logdir=Join-Path (Split-Path $PSScriptRoot -Parent) 'Backups'
New-Item -ItemType Directory -Path $logdir -Force | Out-Null
$log=Join-Path $logdir ('Accounts-{0}.csv' -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
$results=foreach($u in $selected) {
 try {
  switch($Action) {
   RemoveUsers {Remove-LocalUser -SID $u.SID -ErrorAction Stop}
   RemoveAdmins {Remove-LocalGroupMember -Group 'Administrators' -Member $u.Name -ErrorAction Stop}
   RemoveBackupOperators {Remove-LocalGroupMember -Group 'Backup Operators' -Member $u.Name -ErrorAction Stop}
   ResetPassword {
    $pwd=Read-Host "New unique password for $($u.Name)" -AsSecureString
    Set-LocalUser -Name $u.Name -Password $pwd -ErrorAction Stop
   }
   SetPasswordExpiration {Set-LocalUser -Name $u.Name -PasswordNeverExpires $false -ErrorAction Stop}
  }
  Write-Host "[OK] $Action : $($u.Name)" -ForegroundColor Green
  [pscustomobject]@{Time=Get-Date;Action=$Action;User=$u.Name;SID=$u.SID.Value;Result='OK'}
 } catch {
  Write-Warning "Failed $($u.Name): $($_.Exception.Message)"
  [pscustomobject]@{Time=Get-Date;Action=$Action;User=$u.Name;SID=$u.SID.Value;Result=$_.Exception.Message}
 }
}
$results | Export-Csv -LiteralPath $log -NoTypeInformation
Write-Host "Saved results: $log"
