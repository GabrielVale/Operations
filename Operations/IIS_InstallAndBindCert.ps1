# ecservice.rakuten.com.br

$servers = 'RKHOM02'
$session = New-PSSession -ComputerName 'RKHOM02' -UseSSL -Credential $Credential
#The script copies the .pfx file from your computer to the servers where it will be installed:
$servers | foreach-Object{copy-item -Path 'E:\PS\Cert\ecservice.rakuten.com.br.pfx' -Destination "\\$_\c$"}
# CertUtil.exe is used to install the .pfx file into the certificate store:
Invoke-command -Session $session {certutil -p 1 -importpfx 'c:\ecservice.rakuten.com.br.pfx'}
#The .pfx file is then deleted from the remote machine:
$servers | foreach-object {Remove-Item -Path "\\$_\c$\*.pfx"}


Invoke-Command -session $session {$CertShop = Get-ChildItem -Path Cert:\LocalMachine\My |
    where-Object {$_.subject -like "*ecservice.rakuten.com.br*" -and $_.FriendlyName -like "*ecservice.rakuten.com.br*"} |
    Select-Object -ExpandProperty Thumbprint}

Invoke-Command -session $session {Import-Module WebAdministration}

Invoke-Command -Session $session {get-item -Path "cert:\LocalMachine\My\$certShop" |
where { $_.Subject -match ‘www.gb.com.br’ } | Set-Item -Path IIS:\SslBindings\www.gb.com.br!443}