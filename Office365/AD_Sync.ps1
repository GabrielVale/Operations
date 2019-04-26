
# Command to exec full sync
$ADSyncServer = ''
Invoke-Command -ComputerName $ADSyncServer -ScriptBlock {
Import-Module adsync
Start-ADSyncSyncCycle -PolicyType Initial}
########################################################
