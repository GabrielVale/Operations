#Cadastra MAC Address nos servidores DHCP

$macaddress = '6432A813DE90'
$hostname = 'RK423'

Add-DhcpServerv4Filter -List Allow `
                       -MacAddress $macaddress `
                       -ComputerName RKDC01 `
                       -Description $hostname
                       

Add-DhcpServerv4Filter -List Allow `
                       -MacAddress $macaddress `
                       -ComputerName RKDC02 `
                       -Description $hostname