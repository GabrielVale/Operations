## Importando os CMDLets
Import-Module WebAdministration

## Pegar o id_hash do certificado
Get-ChildItem cert:\localmachine\my

## Nome do WebSite 
$siteName = 'Genesis_5'

## Passando o id_hash e guardando na variável
$newCert = Get-ChildItem cert:\localmachine\my\0FF565A3EF8CDFE65F1A9CDF5508767AD1E24EFA

## Pegando todos os host name https do WebSite informado acima
$binding = Get-WebBinding -Name $siteName -Protocol "https"

## Setando o certificado nos host name
$binding.AddSslCertificate($newCert.GetCertHashString(), "my")


