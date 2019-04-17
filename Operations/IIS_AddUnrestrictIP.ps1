$ServerA = 'IKWEB05'
$ServerB = 'IKWEB06'

Invoke-Command -ComputerName $ServerA, $ServerB -ScriptBlock {
    Get-Website -Name "Amend" | Select name
}

Invoke-Command -ComputerName $ServerA, $ServerB -ScriptBlock {
$Site = 'Amend'
$IP = '179.228.202.60'
$Mask = '255.255.255.255'

Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress=$IP; subnetMask=$Mask; allowed="true"} -Location $Site -PSPath "IIS:\Sites"
}