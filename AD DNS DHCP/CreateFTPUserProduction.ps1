#Criação de usuário FTP
#Variaveis

$PASS = ''
$PASSIMG = ''
$UserRakuten = 'modeloftp'
$UserCliente = 'modeloftpimg'


#Cria usuário de FTP Rakuten

New-ADUser -DisplayName:"$UserRakuten" -GivenName:"$UserRakuten" -Name:"$UserRakuten" -Path:"OU=Users_FTP,DC=ikeda,DC=cluster" -SamAccountName:"$UserRakuten" -Server:"IKDC03.ikeda.cluster" -Type:"user" -UserPrincipalName:"$UserRakuten@ikeda.cluster"
# Set-ADAccountPassword -Identity:"CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -NewPassword:"System.Security.SecureString" -Reset:$true -Server:"IKDC03.ikeda.cluster"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$true -DoesNotRequirePreAuth:$false -Identity:"CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -PasswordNeverExpires:$true -Server:"IKDC03.ikeda.cluster" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -Server:"IKDC03.ikeda.cluster" -SmartcardLogonRequired:$false
#Cadastra a senha do usuário Rakuten
Set-ADAccountPassword "CN=$UserRakuten,OU=Users_FTP,DC=ikeda,DC=cluster" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $PASS -Force)
#Edita a descrição do usuário com a senha
Set-ADUser $UserRakuten -Description "$PASS"
#Habilita a conta de usuário
Enable-ADAccount $UserRakuten


#Cria usuário de FTP Cliente

New-ADUser -DisplayName:"$UserCliente" -GivenName:"$UserCliente" -Name:"$UserCliente" -Path:"OU=Users_FTP,DC=ikeda,DC=cluster" -SamAccountName:"$UserCliente" -Server:"IKDC03.ikeda.cluster" -Type:"user" -UserPrincipalName:"$UserCliente@ikeda.cluster"
# Set-ADAccountPassword -Identity:"CN=$UserCliente,OU=Users_FTP,DC=ikeda,DC=cluster" -NewPassword:"System.Security.SecureString" -Reset:$true -Server:"IKDC03.ikeda.cluster"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$true -DoesNotRequirePreAuth:$false -Identity:"CN=$UserCliente,OU=Users_FTP,DC=ikeda,DC=cluster" -PasswordNeverExpires:$true -Server:"IKDC03.ikeda.cluster" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=$UserCliente,OU=Users_FTP,DC=ikeda,DC=cluster" -Server:"IKDC03.ikeda.cluster" -SmartcardLogonRequired:$false
#Cadastra a senha do usuário Cliente
Set-ADAccountPassword "CN=$UserCliente,OU=Users_FTP,DC=ikeda,DC=cluster" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $PASSIMG -Force)
#Edita a descrição do usuário com a senha
Set-ADUser $UserCliente -Description "$PASSIMG"
#Habilita a conta de usuário
Enable-ADAccount $UserCliente

