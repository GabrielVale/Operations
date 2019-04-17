$AliasName = Get-Content "E:\PS\Alias.txt"

$HostURL = $AliasName.ToLower()
$WebsiteName = 'FlashStore2'

# Windows directory delete
ForEach ($Alias in $AliasName)
{
$Path = Join-Path "\\rkrepository.file.core.windows.net\repository\" -childpath $Alias
Remove-Item $Path -type directory -Recurse -force
}
# Remove IIS binding
ForEach ($URL in $HostURL)
{
Remove-WebBinding -Name "$WebsiteName" -HostHeader "$URL.flashstore.com.br" -Port 80 -Protocol http
Remove-WebBinding -Name "$WebsiteName" -HostHeader "$URL.flashstore.com.br" -Port 443 -Protocol https
}

