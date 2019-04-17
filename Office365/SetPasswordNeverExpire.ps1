##Instalação do Módulo Office365##
Get-Module -Name PowerShellGet -ListAvailable | Select-Object -Property Name,Version,Path
Install-Module PowerShellGet -Force
Install-Module -Name AzureRM -AllowClobber
Import-Module -Name AzureRM
Install-Module -Name MSOnline -RequiredVersion 1.1.166.0 


##Comando para configurar senha do usuário para nunca expirar##
Connect-MsolService
Set-MsolUser -UserPrincipalName backoffice@flashstore.com.br -PasswordNeverExpires $true 

#Verifica quais contas nunca expiram##
Get-MSOLUser  | Select UserPrincipalName, PasswordNeverExpires

#Verifica se uma conta específica nunca expira##
Get-MSOLUser -UserPrincipalName backoffice@flashstore.com.br | Select UserPrincipalName, PasswordNeverExpires