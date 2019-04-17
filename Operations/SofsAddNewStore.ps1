
$Loja = "Modelo"
$ftpUser = "modeloftp"
$ftpUserImg = "modeloftpimg"


#Cria a Pasta da Modelo no WWWRoot
New-Item -type directory -path \\sofs01\RAKUTEN\Repository\$Loja

#Permissao usuario FTP Root
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\$ftpUser","Modify", "ObjectInherit, ContainerInherit","None","Allow")
$Acl.SetAccessRule($Ar) 
Set-Acl "\\sofs01\RAKUTEN\Repository\$Loja" $Acl

#Permissao usuario FTP Imagens
$Acl = Get-Acl "\\sofs01\RAKUTEN\Repository\$Loja"
$Ar = New-Object system.security.accesscontrol.filesystemaccessrule("ikeda\$ftpUserimg","ListDirectory", "ObjectInherit, ContainerInherit","None","Allow")
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
