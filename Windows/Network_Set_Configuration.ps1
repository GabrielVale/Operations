# Author: Gabriel Vale
# Date: 10/12/2018
# Version 1.0

#WEBEXAMPLE01
$IPINT = "192.168.0.0"
$IPLB = "172.16.0.0"
New-NetIPAddress –InterfaceAlias “INTERNA” –IPv4Address $IPINT –PrefixLength 22
New-NetIPAddress –InterfaceAlias “LB” –IPv4Address $IPLB –PrefixLength 16 -DefaultGateway 172.16.0.0
Set-DnsClientServerAddress -InterfaceAlias “Wired Ethernet Connection” -ServerAddresses 172.16.0.0, 172.16.0.0

#WEBEXAMPLE02
$IPINT = "192.168.0.0"
$IPLB = "172.16.0.0"
New-NetIPAddress –InterfaceAlias “INTERNA” –IPv4Address $IPINT –PrefixLength 22
New-NetIPAddress –InterfaceAlias “LB” –IPv4Address $IPLB –PrefixLength 16 -DefaultGateway 172.16.0.0
Set-DnsClientServerAddress -InterfaceAlias “Wired Ethernet Connection” -ServerAddresses 172.16.0.0, 172.16.0.0
