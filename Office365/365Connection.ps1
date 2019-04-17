##Instalação do Módulo Office365##
Get-Module -Name PowerShellGet -ListAvailable | Select-Object -Property Name,Version,Path
Install-Module PowerShellGet -Force
Install-Module -Name AzureRM -AllowClobber
Import-Module -Name AzureRM
Install-Module -Name MSOnline -RequiredVersion 1.1.166.0 

