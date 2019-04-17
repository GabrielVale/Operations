#Acrescenta IPs adicionais para a placa de Rede LB

$a = 3

while ($a -le 254) 
{
    New-NetIPAddress -InterfaceAlias LB –IPAddress 172.16.13.$a -PrefixLength 16
    $a++
}