#Created: 10/10/2018
#Author: Gabriel Vale


# Configurar nessa variável em quais Servidores será consultado e adicionado o IP
$websrv = 'IKWEB05', 'IKWEB06'

# Comando para consultar o nome exato do site a liberar o IP
Invoke-Command -ComputerName $websrv -ScriptBlock {
# Alterar nessa variável o nome ou parte dele entre aspas para consulta
$Site = "*urban*"
    Get-Website -Name "$Site" | Select name
}

# Comando para liberar o IP nos dois servidores da variável $websrv

Invoke-Command -ComputerName $websrv -ScriptBlock {

# Variável com o nome exato da loja a liberar o IP
$Site = "UrbanArts"
# Variável com o IP a ser liberado
$IP = '187.8.21.10'
# Variável com a máscara (Especificada para um IP)
$Mask = '255.255.255.255'
    Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress=$IP; subnetMask=$Mask; allowed="true"} -Location $Site -PSPath "IIS:\Sites"
}
