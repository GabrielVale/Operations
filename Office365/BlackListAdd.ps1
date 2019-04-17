1. Following powershell command can be used to extract the configuration of the Connection Filtering

Get-HostedConnectionFilterPolicy | select | Export-csv C:MYDocsAllowIP.csv



2. Following powershell command can be used to allow or block the IP or IP Range.

Set-HostedConnectionFilterPolicy “Default” -IPAllowList 192.168.1.10,192.168.1.23 -IPBlockList 10.10.10.10/24,172.17.17.0/16

Or

Set-HostedConnectionFilterPolicy “Default” –IPAllowList @{Add=”192.168.2.10″,”192.169.3.0/18″,”192.168.4.1-192.168.4.5″;Remove=”192.168.1.10″}