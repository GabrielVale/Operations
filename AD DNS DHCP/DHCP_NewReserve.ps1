

$name = 'RAK017'
$ip = '10.0.1.28'
$macadd = '78-2B-CB-C0-51-5B'



Add-DhcpServerv4Reservation -ComputerName RKDC01 `
                            -ScopeId 10.0.0.0 `                            -IPAddress $ip `                            -Name $name `                            -Description $name `                            -Type Both `                            -ClientId $macadd
Add-DhcpServerv4Reservation -ComputerName RKSRV02 `
                            -ScopeId 10.0.0.0 `                            -IPAddress $ip `                            -Name $name `                            -Description $name `                            -Type Both `                            -ClientId $macadd