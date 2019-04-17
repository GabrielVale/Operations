$Servers = 10.0.3.10
$Script = {ipmo PSWindowsUpdate; Get-WUInstall -AcceptAll -AutoReboot | Out-File C:\PSWindowsUpdate.log}


Invoke-WUInstall -ComputerName $Servers -Script $Script

