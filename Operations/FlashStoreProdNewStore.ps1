$AliasName = Get-Content "E:\PS\Alias.txt"

$HostURL = $AliasName.ToLower()
$WebsiteName = 'FlashStore2'

# Windows directory creation
ForEach ($Alias in $AliasName)
{
$Path = Join-Path "\\rkrepository.file.core.windows.net\repository\" -childpath $Alias
New-Item $Path -type directory
Copy-Item -Path 'E:\PS\Default Repository\*' -Destination "\\rkrepository.file.core.windows.net\repository\$Alias" -Recurse
}
ForEach ($URL in $HostURL)
{
# Include on IIS binding

New-WebBinding -Name "$WebsiteName" -HostHeader "$URL.flashstore.com.br" -Port 80 -Protocol http
New-WebBinding -Name "$WebsiteName" -HostHeader "$URL.flashstore.com.br" -Port 443 -Protocol https
$cert = Get-ChildItem -Path Cert:\LocalMachine\My | where-Object {$_.subject -like "*.flashstore.com.br*"}
New-Item -Path "IIS:\SslBindings\!443!$URL.flashstore.com.br" -Value $cert -SSLFlags 1
}
