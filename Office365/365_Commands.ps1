#Comando para se conectar ao office365

$UserCredential = Get-Credential
Connect-MsolService -Credential $UserCredential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session



#Removendo a seção

Remove-PSSession $Session

__________________________________________________________________________________


#Pegar configurações da sala de reunião

#Este exemplo permite as solicitações de reuniões de usuários que não sejam membros da organização do Exchange.

Set-CalendarProcessing -Identity "Sala Ameyoko" -ProcessExternalMeetingMessages $true



__________________________________________________________________________________


#Segue alguns exemplos de comando para administrar as contas de email do office365:


#Redirecionamento de Email Padrão:

Set-Mailbox  fernando.fukuda  -ForwardingAddress rene.abe@rakuten.com.br


#Redirecionamento de Email sem manter cópia na conta:

Set-Mailbox rene.abe  -ForwardingAddress  Suzan@o365info.com -DeliverToMailboxAndForward $False

#Caso seja necessário configurar resposta automática é necessário:

Set-Mailbox patricia.quadros -ForwardingAddress rene.abe -DeliverToMailboxAndForward $True

#Resposta automática:

Set-MailboxAutoReplyConfiguration -Identity "aurea.sabiori" -AutoReplyState scheduled -StartTime 06/01/2016 -EndTime 01/01/2020 -InternalMessage "Aurea Sabiori não faz mais parte do quadro de funcionários da Rakuten. Favor encaminhar sua solicitação para ecc.ec@rakuten.com.br" -ExternalMessage "Aurea Sabiori não faz mais parte do quadro de funcionários da Rakuten. Favor encaminhar sua solicitação para ecc.ec@rakuten.com.br"

Set-MailboxAutoReplyConfiguration aurea.sabiori -AutoReplyState enabled -ExternalAudience all -InternalMessage "Aurea Sabiori não faz mais parte do quadro de funcionários da Rakuten. Favor encaminhar sua solicitação para ecc.ec@rakuten.com.br" -ExternalMessage "Aurea Sabiori não faz mais parte do quadro de funcionários da Rakuten. Favor encaminhar sua solicitação para ecc.ec@rakuten.com.br"


#Verificar se existe algum redirecionamento na caisa postal:

Get-Mailbox Fernando.fukuda | FL DeliverToMailboxAndForward,ForwardingAddress,ForwardingSmtpAddress

#Remover Redirecionamentos:

Set-Mailbox silvana.maschio  -ForwardingAddress $Null

#Criar caixa de e-mail

New-Mailbox -Name <Name> -UserPrincipalName <UPN> -Password (ConvertTo-SecureString -String '<Password>' -AsPlainText -Force) [-Alias <Alias>] [-FirstName <FirstName>] [-LastName <LastName>] [-DisplayName <DisplayName>] -[OrganizationalUnit <OU>]

#Criar lista de distribuição

New-DistributionGroup -Name "IT Administrators" -Alias itadmin -MemberJoinRestriction open

#Criar contas em lote

UserPrincipalName,FirstName,LastName,DisplayName,UsageLocation,AccountSkuId
ClaudeL@contoso.onmicrosoft.com,Claude,Loiselle,Claude Loiselle,US,contoso:ENTERPRISEPACK
LynneB@contoso.onmicrosoft.com,Lynne,Baxter,Lynne Baxter,US,contoso:ENTERPRISEPACK
ShawnM@contoso.onmicrosoft.com,Shawn,Melendez,Shawn Melendez,US,contoso:ENTERPRISEPACK

___________________________________________________________________________________


#Listar todos os dispositivos que estão conectados ao ActiveSync e exporta para um arquivo
Get-Mailbox -ResultSize Unlimited | ForEach {Get-MobileDeviceStatistics -Mailbox:$_.Identity | fl} | export-csv “ActiveSyncDevices.csv”

#Listar todas as contas do Office 365 (com informação de Departamento e Localização)

Get-MsolUser | Select-Object DisplayName, Department, UsageLocation


#Exporta para um arquivo o tamanho de todas as mailbox
get-mailbox | get-mailboxstatistics | select DisplayName,ItemCount,TotalItemSize | export-csv “MailboxSizes.csv”

#Exporta uma lista de todas as caixas de email para csv (na raiz da pasta do usuário ativo na estação)

Get-MsolUser | export-csv contas.csv

#Exporta uma lista de todas as caixas de e-mail com suas permissões)
#UserPrincipalName,ObjectWithAccess,ObjectType,AccessType,Inherited,AllowOrDeny test_shared@cogmotive.com,Alan Byrne(alan@cogmotive.com),UserMailbox,FullAccess,Allow test_shared@cogmotive.com,Cogmotive Reports(reports@cogmotive.com),MailUniversalDistributionGroup,FullAccess,Allow

#Lista todos os usuários e os grupos a quem ele pertence
https://www.cogmotive.com/blog/powershell/list-all-users-and-their-distribution-group-membership-in-office-365


#Permissão Enviar como (send as)
Add-RecipientPermission <help desk> -AccessRights SendAs -Trustee “david”


#Deixar a senha de todos os usuários iguais
Get-MsolUser | Set-MsolUserPassword -NewPassword senha -ForceChangePassword $False/$True

#Mudar a senha de um usuário

Set-MsolUserPassword -userPrincipalName patricia.quadros@rakuten.com.br -NewPassword R******#

_____________________________________________________________________________________

#Políticas para Grupos

#Remove restrições
Set-DistributionGroup -Identity gestores –RejectMessagesFrom $null


#riar restrição de envio de um usuário para grupo
Set-DistributionGroup -Identity infra –RejectMessagesFrom carlos.nucci

#Restrição de grupo enviar para Grupo
Set-DistributionGroup -Identity lideresEC -RejectMessagesFromDLMembers rh

#Criar restrição na qual o grupo só recebe mensagens de alguns membros
Set-DistributionGroup -Identity elas -AcceptMessagesOnlyFrom carlos.nucci,rene.abe

#Criar grupo de distribuição
New-DistributionGroup -Name "PPP-Geral" -PrimarySmtpAddress ppp-geral@rakuten.com.br -Members adriano.hirata@rakuten.com.br