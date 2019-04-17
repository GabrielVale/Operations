#Script renomeia o computador, ingressa ao dominio e configurar endereço IP para LB e Interna
#Obs: As placas de rede devem ser renomeadas para LB e Interna

$hostname =    'RKWEB05'
$iplb =        '172.16.173.190'
$iplbsnat =    '172.16.173.191'
$ipint =       '192.168.0.168'

#Define IP da rede LB
New-NetIPAddress -InterfaceAlias LB `
                 -IPAddress $iplb `
                 -PrefixLength 16 `
                 -DefaultGateway 172.16.150.1

#Define IP SNAT da rede LB 
New-NetIPAddress -InterfaceAlias LB `
                 -IPAddress $iplbsnat `
                 -PrefixLength 16

#Define IP da rede interna
New-NetIPAddress -InterfaceAlias Interna `
                 -IPAddress $ipint `
                 -PrefixLength 24

#Define os servidores DNS da rede LB
Set-DnsClientServerAddress -InterfaceAlias LB `
                           -ServerAddresses ("172.16.174.1","172.16.174.3")

#Define os servidores DNS da rede interna
Set-DnsClientServerAddress -InterfaceAlias Interna `
                           -ServerAddresses ("192.168.0.34","192.168.0.134")

#Renomeia o computador e ingressa ao dominio
Add-Computer -DomainName rakuten.com.br -NewName $hostname -Credential rakuten\administrator

#Desabilita o firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#Instala a chave e ativa o Windows
slmgr /ipk c289d-73ng8-gk7ct-g9mg7-mbgpj
slmgr /ato

