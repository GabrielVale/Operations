#Adiciona entrada no DNS para criação de ambiente core em desenvolvimento

$loja = Get-Content "E:\dns.txt"

ForEach ($dns in $loja)
{
Add-DnsServerResourceRecord -ComputerName RKDC01 `
                            -ZoneName "rakutendev.com.br" -A `
                            -Name "$dns.genesis.ecservice" `
                            -IPv4Address "10.0.0.15"

Add-DnsServerResourceRecord -ComputerName RKDC02 `
                            -ZoneName "rakutendev.com.br" -A `
                            -Name "manager.$dns.genesis.ecservice" `
                            -IPv4Address "10.0.0.48"
}







