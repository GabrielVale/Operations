$AliasName = Get-Content "E:\PS\Alias.txt"
$HostHeader = $AliasName.ToLower()
$WebsiteName = 'Genesis_5'
$WebManager = 'RKMManager'

# Windows directory creation
ForEach ($Alias in $AliasName)
{
$Path = Join-Path "E:\IIS\wwwroot\Genesis\Repository" -childpath $Alias
New-Item $Path -type directory
Copy-Item -Path 'E:\PS\Default Repository\*' -Destination "E:\IIS\wwwroot\Genesis\Repository\$Alias" -Recurse
Set-ItemProperty -LiteralPath E:\IIS\wwwroot\Genesis\Repository\$Alias\* -Name IsReadOnly -Value $false
}


# Include on IIS binding
ForEach ($HostURL in $HostHeader)
{
New-WebBinding -Name "$WebsiteName" -HostHeader "$HostURL.ecservice.rakuten.com.br" -Port 80 -Protocol http
New-WebBinding -Name "$WebsiteName" -HostHeader "$HostURL.ecservice.rakuten.com.br" -Port 443 -Protocol https -SslFlags 1
New-WebBinding -Name "$WebManager" -HostHeader "manager.$HostURL.ecservice.rakuten.com.br" -Port 80 -Protocol http
$cert = Get-ChildItem -Path Cert:\LocalMachine\My | where-Object {$_.subject -like "*.ecservice.rakuten.com.br*"}
New-Item -Path "IIS:\SslBindings\!443!$HostURL.ecservice.rakuten.com.br" -Value $cert -SSLFlags 1
}


