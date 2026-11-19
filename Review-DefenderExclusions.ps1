#requires -RunAsAdministrator
[CmdletBinding(SupportsShouldProcess=$true)]
param([string]$Path,[switch]$Remove)
$pref=Get-MpPreference
Write-Host 'Current Defender exclusions:'
$pref | Select-Object ExclusionPath,ExclusionProcess,ExclusionExtension | Format-List
if(-not $Remove) {Write-Host 'Read-only. Specify -Path and -Remove to remove one reviewed path exclusion.';return}
if([string]::IsNullOrWhiteSpace($Path)) {throw 'Provide an exact -Path.'}
if(@($pref.ExclusionPath) -notcontains $Path) {throw 'Exact exclusion path not found. Nothing changed.'}
Write-Warning 'Inspect and confirm this exclusion is unauthorized before removing it.'
if((Read-Host 'Type REMOVE to confirm') -cne 'REMOVE'){Write-Host 'Cancelled';return}
if($PSCmdlet.ShouldProcess($Path,'Remove one Defender path exclusion')) {
 Remove-MpPreference -ExclusionPath $Path -ErrorAction Stop
 Write-Host 'Removed exclusion. Review threats and scan safely.'
}
