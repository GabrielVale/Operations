$servers = 'RKHOM01'
$URL = 'rakuten.com.br'
$CertPath = 'E:\iis\Certificados\rakuten.com.br.pfx'
$session = New-PsSession –ComputerName $servers
Invoke-command -Session $session {certutil -p 1 -importpfx E:\iis\Certificados\rakuten.com.br.pfx}

Invoke-Command -session $session {$CertShop = Get-ChildItem -Path Cert:\LocalMachine\My | where-Object {$_.subject -like '*rakuten.com.br, OU=Domain Control Validated' } | Select-Object -ExpandProperty Thumbprint}

Invoke-Command -session $session {Import-Module WebAdministration}
#Invoke-Command -Session $session {Get-Item IIS:\SslBindings\10.0.0.10!443 | Remove-Item}
Invoke-Command -Session $session {get-item -Path "cert:\LocalMachine\My\$certShop" | new-item -path IIS:\SslBindings\10.0.0.10!443}

