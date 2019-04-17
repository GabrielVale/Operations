Invoke-Command -Computername IKDC03 -ScriptBlock {


#Variavel

$Loja = "ElgScreen"


#Definição do nome de usuário e senha

$UserRakuten = "$($loja)ftp".ToLower()
$UserCliente = "$($loja)ftpimg".ToLower()
Add-Type -AssemblyName System.Web 
$passwordftp = [System.Web.Security.Membership]::GeneratePassword(8,2) | Out-String 

#Cria usuário de FTP Rakuten


New-ADUser -DisplayName:"$UserRakuten" -GivenName:"$UserRakuten" -Name:"$UserRakuten" -Path:"OU=Users_FTP,DC=ikeda,DC=cluster" -SamAccountName:"$UserRakuten" -Server:"IKDC03.ikeda.cluster" -Type:"user" -UserPrincipalName:"$UserRakuten@ikeda.cluster"
# Set-ADAccountPassword -Identity:"CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -NewPassword:"System.Security.SecureString" -Reset:$true -Server:"IKDC03.ikeda.cluster"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$true -DoesNotRequirePreAuth:$false -Identity:"CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -PasswordNeverExpires:$true -Server:"IKDC03.ikeda.cluster" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -Server:"IKDC03.ikeda.cluster" -SmartcardLogonRequired:$false
#Cadastra a senha do usuário Rakuten
Set-ADAccountPassword "CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $passwordftp -Force)
#Edita a descrição do usuário com a senha
Set-ADUser $UserRakuten -Description "$passwordftp"
#Habilita a conta de usuário
Enable-ADAccount $UserRakuten


#Cria usuário de FTP Cliente

New-ADUser -DisplayName:"$UserCliente" -GivenName:"$UserCliente" -Name:"$UserCliente" -Path:"OU=Users_FTP,DC=ikeda,DC=cluster" -SamAccountName:"$UserCliente" -Server:"IKDC03.ikeda.cluster" -Type:"user" -UserPrincipalName:"$UserCliente@ikeda.cluster"
# Set-ADAccountPassword -Identity:"CN=$UserCliente,OU=Users_FTP,DC=ikeda,DC=cluster" -NewPassword:"System.Security.SecureString" -Reset:$true -Server:"IKDC03.ikeda.cluster"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$true -DoesNotRequirePreAuth:$false -Identity:"CN=$UserCliente,OU=Users_FTP,DC=ikeda,DC=cluster" -PasswordNeverExpires:$true -Server:"IKDC03.ikeda.cluster" -UseDESKeyOnly:$false


#Cria a Pasta da loja no SOFS
New-Item -type directory -path \\sofs01\RAKUTEN\Repository\$Loja

#Permissao usuario FTP Root
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\$UserRakuten","Modify", "ObjectInherit, ContainerInherit","None","Allow")
$Acl.SetAccessRule($Ar) 
Set-Acl "\\sofs01\RAKUTEN\Repository\$Loja" $Acl

#Permissao usuario FTP Imagens
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\$UserCliente","ListDirectory", "ObjectInherit, ContainerInherit","None","Allow")
$Acl.SetAccessRule($Ar) 
Set-Acl "\\sofs01\RAKUTEN\Repository\$Loja" $Acl

#Cria a Pasta Imagens dentro da $Loja
New-Item -type directory -path \\sofs01\RAKUTEN\Repository\$Loja\imagens
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja\imagens"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\ik_networkservice","Modify", "ObjectInherit, ContainerInherit","None","Allow")
$Acl.SetAccessRule($Ar) 
Set-Acl "\\sofs01\RAKUTEN\Repository\$Loja\imagens" $Acl

#Cria a Pasta Favoritos dentro da $Loja
New-Item -type directory -path \\sofs01\RAKUTEN\Repository\$Loja\Favoritos
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja\Favoritos"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\ik_networkservice","Modify", "ObjectInherit, ContainerInherit","None","Allow")
$Acl.SetAccessRule($Ar) 
Set-Acl "\\sofs01\RAKUTEN\Repository\$Loja\Favoritos" $Acl

#Cria a Pasta XML dentro da $Loja
New-Item -type directory -path \\sofs01\RAKUTEN\Repository\$Loja\XML
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja\XML"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\ik_networkservice","Modify", "ObjectInherit, ContainerInherit","None","Allow")
$Acl.SetAccessRule($Ar) 
Set-Acl "\\sofs01\RAKUTEN\Repository\$Loja\XML" $Acl

#Cria o arquivo sitemap.xml
$Location = "\\sofs01\RAKUTEN\Repository\$Loja"
New-Item -Path $Location -Name "sitemap.xml" -ItemType File
$rule = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\ik_networkservice","Modify", "ObjectInherit, ContainerInherit","None","Allow")
$acl.SetAccessRule($rule)
Set-Acl -Path "\\sofs01\RAKUTEN\Repository\$Loja\sitemap.xml" $acl


echo Usuário/Senha "$($Loja)ftp".ToLower() $passwordftp

 }



