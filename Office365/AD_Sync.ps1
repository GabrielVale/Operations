
# Command to exec full sync

Invoke-Command -ComputerName RKDC01 -ScriptBlock {
    Import-Module adsync
    Start-ADSyncSyncCycle -PolicyType Initial
    }
########################################################
