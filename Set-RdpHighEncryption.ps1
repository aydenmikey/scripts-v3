#requires -RunAsAdministrator
[CmdletBinding(SupportsShouldProcess=$true)]
param([switch]$Apply)
$key='HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
Write-Host 'Current RDP settings:'
Get-ItemProperty $key | Select-Object MinEncryptionLevel,SecurityLayer,UserAuthentication | Format-List
Write-Warning 'High RDP encryption may affect legacy clients. Make a VM snapshot and validate README before applying.'
if(-not $Apply) {Write-Host 'Preview only. Use -Apply to change.';return}
if((Read-Host 'Type RDP to confirm') -cne 'RDP') {Write-Host 'Cancelled';return}
if($PSCmdlet.ShouldProcess($key,'Set MinEncryptionLevel to High (3)')) {
 Set-ItemProperty -Path $key -Name MinEncryptionLevel -Value 3 -ErrorAction Stop
 Write-Host 'RDP minimum encryption level set to High (3). Recheck compatibility.'
}
