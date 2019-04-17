## Importando os CMDLets
Import-Module WebAdministration

##NO CASO DAS LOJAS GENESIS/CLASSIC NÃO ESQUECER DE ALTERAR AS VARIÁVEIS $Loja, $IP, $Time, $ftpUser, $ftpUserImg, $ftpisolate

#Variáveis
$Loja = "ElgScreen"
$IP = "172.16.15.64"

#Variáveis Pools
$logEventOnRecycle="Time,Memory,PrivateMemory"
$Time = "02:02"

#Variáveis FTP
$appPoolName = "DefaultAppPool"
$ftpprotocol = "ftp"
$bindingInformation = "$($IP):21:"
$bindings = "@{protocol=$("$ftpprotocol");bindingInformation=$($bindingInformation)}"
$target = '\\SOFS01\RAKUTEN\Repository\'+ $Loja +''
$ftpUser = "ikeda\$($Loja)ftp".ToLower()
$ftpUserImg = "ikeda\$($Loja)ftpimg".ToLower()
$ftpisolate = "$($Loja)ftpimg".ToLower()

#Variável appcmd
$appCmd = "C:\windows\system32\inetsrv\appcmd.exe"
$env:loja ="$Loja"
$env:produtos ="_FTP_$($Loja)/$ftpisolate/produtos"
$env:carac ="_FTP_$($Loja)/$ftpisolate/carac"
$env:looks ="_FTP_$($Loja)/$ftpisolate/looks"

#Criando Pools
New-Item IIS:\AppPools\$Loja 
Set-ItemProperty IIS:\AppPools\$Loja -name "recycling.periodicRestart" -Value @{time="0"}
Set-ItemProperty IIS:\AppPools\$Loja -name "recycling.periodicRestart.Schedule" -Value @{value=$Time}
Set-ItemProperty IIS:\AppPools\$Loja -name "recycling.logEventOnRecycle" -Value $logEventOnRecycle

New-Item IIS:\AppPools\$Loja'_IKCAdm' 
Set-ItemProperty IIS:\AppPools\$Loja'_IKCAdm' -name "recycling.periodicRestart" -Value @{time="0"}
Set-ItemProperty IIS:\AppPools\$Loja'_IKCAdm' -name "recycling.periodicRestart.Schedule" -Value @{value=$Time}
Set-ItemProperty IIS:\AppPools\$Loja'_IKCAdm' -name "recycling.logEventOnRecycle" -Value $logEventOnRecycle

#New-Item IIS:\AppPools\$Loja'_IKCTelevendas' 
#Set-ItemProperty IIS:\AppPools\$Loja'_IKCTelevendas' -name "recycling.periodicRestart" -Value @{time="0"}
#Set-ItemProperty IIS:\AppPools\$Loja'_IKCTelevendas' -name "recycling.periodicRestart.Schedule" -Value @{value=$Time}
#Set-ItemProperty IIS:\AppPools\$Loja'_IKCTelevendas' -name "recycling.logEventOnRecycle" -Value $logEventOnRecycle

New-Item IIS:\AppPools\$Loja'_IKCWebService'
Set-ItemProperty IIS:\AppPools\$Loja'_IKCWebService' -name "recycling.periodicRestart" -Value @{time="0"}
Set-ItemProperty IIS:\AppPools\$Loja'_IKCWebService' -name "recycling.periodicRestart.Schedule" -Value @{value=$Time}
Set-ItemProperty IIS:\AppPools\$Loja'_IKCWebService' -name "recycling.logEventOnRecycle" -Value $logEventOnRecycle

#Criando Diretório WebSite
#New-Item -type directory -path E:\IIS\Logs\$Loja 
#New-Item -type directory -path E:\IIS\Logs\$Loja\FTP
#New-Item -type directory -path E:\IIS\wwwroot\$Loja 
#New-Item -type directory -path E:\IIS\wwwroot\$Loja\IKCAdm 
#New-Item -type directory -path E:\IIS\wwwroot\$Loja\IKCTelevendas 
#New-Item -type directory -path E:\IIS\wwwroot\$Loja\IKCWebService 

#Criando WebSite

New-Website -Name $Loja -Port 80 -IPAddress $IP -PhysicalPath E:\IIS\wwwroot\$Loja -ApplicationPool $Loja 

New-WebBinding -Name $Loja -IP $IP -Port 443 -Protocol https

#Setando o caminho de Log
Set-ItemProperty IIS:\Sites\$($Loja) -name logFile.directory -value E:\IIS\Logs\$($Loja)
 
#Setando a liberação de IP
Set-WebConfigurationProperty -Filter /system.webserver/security/ipsecurity -Name allowUnlisted -Value True -Location $Loja -PSPath "IIS:\Sites\"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.162.55.141"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.162.55.142"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.162.55.10"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.99.132.189"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.99.132.190"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="189.86.40.140"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="186.211.113.108"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="186.211.113.155"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.148.124.253"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="189.111.239.100"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="186.231.63.234"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="186.230.7.154"; subnetMask="255.255.255.255"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="200.229.200.0"; subnetMask="255.255.255.0"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="177.43.228.48"; subnetMask="255.255.255.248"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="189.39.11.112"; subnetMask="255.255.255.240"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"
Add-WebConfiguration -Filter /system.webserver/security/ipsecurity -Value @{ipAddress="172.16.0.0"; subnetMask="255.255.0.0"; allowed="true"} -Location $Loja -PSPath "IIS:\Sites"

#Setando a autentição pelo usuário do Pool
#& $appcmd --% set config "%loja%" -section:system.webServer/security/authentication/anonymousAuthentication /enabled:"True" /commit:apphost
#& $appcmd --% set config "%loja%" -section:system.webServer/security/authentication/anonymousAuthentication /userName:"" /commit:apphost
#& $appcmd --% set config "%loja%" -section:system.webServer/security/authentication/anonymousAuthentication /password:"" /commit:apphost

#Criando ADM, WS e Televendas
New-Item IIS:\Sites\$Loja\IKCAdm -physicalPath E:\IIS\wwwroot\$Loja\IKCAdm -type Application
Set-ItemProperty IIS:\Sites\$Loja\IKCAdm -name applicationPool -value $Loja'_IKCAdm'

#New-Item IIS:\Sites\$Loja\IKCTelevendas -physicalPath E:\IIS\wwwroot\$Loja\IKCTelevendas -type Application
#Set-ItemProperty IIS:\Sites\$Loja\IKCTelevendas -name applicationPool -value $Loja'_IKCTelevendas'

New-Item IIS:\Sites\$Loja\IKCWebService -physicalPath E:\IIS\wwwroot\$Loja\IKCWebService -type Application
Set-ItemProperty IIS:\Sites\$Loja\IKCWebService -name applicationPool -value $Loja'_IKCWebService'


#Criando FTP
New-Item IIS:\Sites\'_FTP_'$Loja -bindings $bindings -physicalPath $target -Verbose:$false -Force | Out-Null
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -Name applicationPool -Value $appPoolName
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -Name ftpServer.security.authentication.basicAuthentication.enabled -Value $true
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -Name ftpServer.security.authentication.basicAuthentication.defaultLogonDomain -Value "IKEDA"
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -Name ftpServer.security.ssl.controlChannelPolicy -Value 0
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -Name ftpServer.security.ssl.dataChannelPolicy -Value 0
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -Name ftpserver.userisolation.mode -Value 0

#Setando o caminho de Log do FTP
Set-ItemProperty IIS:\Sites\'_FTP_'$Loja -name ftpServer.logFile.directory -value E:\IIS\Logs\$Loja\FTP

#Criando Diretório Virtual
New-Item IIS:\sites\'_FTP_'$Loja\$ftpisolate -physicalPath $target'\imagens' -type VirtualDirectory

#Permissão para o usuário de imagens
Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUser ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -location _FTP_$Loja
Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUserImg ;roles="";permissions='Read'} -PSPath IIS:\Sites -location _FTP_$Loja

Set-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUserImg ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -Location _FTP_$Loja/$ftpisolate/produtos
Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUser ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -Location _FTP_$Loja/$ftpisolate/produtos

Set-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUserImg ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -Location _FTP_$Loja/$ftpisolate/carac
Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUser ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -Location _FTP_$Loja/$ftpisolate/carac

Set-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUserImg ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -Location _FTP_$Loja/$ftpisolate/looks
Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType='Allow';users=$ftpUser ;roles="";permissions='Read, Write'} -PSPath IIS:\Sites -Location _FTP_$Loja/$ftpisolate/looks

#Restringindo Extensões nas pastas Produtos, Carac e Looks
& $appCmd --%  set config "%produtos%" -section:system.ftpServer/security/requestFiltering /+"fileExtensions.[fileExtension='.jpg',allowed='true']" /+"fileExtensions.[fileExtension='.png',allowed='true']" /+"fileExtensions.[fileExtension='gif',allowed='true']" /+"fileExtensions.[fileExtension='.swf',allowed='true']" /commit:apphost
& $appcmd --% set config "%produtos%" -section:system.ftpServer/security/requestFiltering -fileExtensions.allowUnlisted:"false" /commit:apphost

& $appCmd --%  set config "%carac%" -section:system.ftpServer/security/requestFiltering /+"fileExtensions.[fileExtension='.jpg',allowed='true']" /+"fileExtensions.[fileExtension='.png',allowed='true']" /+"fileExtensions.[fileExtension='gif',allowed='true']" /+"fileExtensions.[fileExtension='.swf',allowed='true']" /commit:apphost
& $appcmd --% set config "%carac%" -section:system.ftpServer/security/requestFiltering -fileExtensions.allowUnlisted:"false" /commit:apphost

& $appCmd --%  set config "%looks%" -section:system.ftpServer/security/requestFiltering /+"fileExtensions.[fileExtension='.jpg',allowed='true']" /+"fileExtensions.[fileExtension='.png',allowed='true']" /+"fileExtensions.[fileExtension='gif',allowed='true']" /+"fileExtensions.[fileExtension='.swf',allowed='true']" /commit:apphost
& $appcmd --% set config "%looks%" -section:system.ftpServer/security/requestFiltering -fileExtensions.allowUnlisted:"false" /commit:apphost


# Reiniciando o Serviço de FTP
Restart-WebItem IIS:\Sites\_FTP_$Loja


