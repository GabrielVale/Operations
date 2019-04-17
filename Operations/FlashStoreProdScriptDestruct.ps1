$AliasName = Get-Content "E:\PS\Alias.txt"
$HostHeader = Get-Content "E:\PS\URL.txt"
$WebsiteName = 'FlashStore'
# Windows directory creation
ForEach ($Alias in $AliasName)
{
$Path = Join-Path "E:\IIS\wwwroot\Genesis\Repository" -childpath $Alias
Remove-item $Path -Recurse -Force
}

# Include on IIS binding
ForEach ($HostURL in $HostHeader)
{
Remove-WebBinding -Name "$WebsiteName" -HostHeader "$HostURL.flashstore.com.br" -Port 80 -Protocol http
Remove-WebBinding -Name "$WebsiteName" -HostHeader "$HostURL.flashstore.com.br" -Port 443 -Protocol https

}
