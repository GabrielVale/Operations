#Web

Invoke-Command -ComputerName "ikweb03","ikweb04","ikweb05","ikweb06","ikweb010","ikweb11","ikweb12","ikweb13","ikweb16","ikweb17","ikweb18","ikweb19","ikweb20","ikweb21","ikweb22","ikweb23","ikweb24","ikweb25","ikbusweb01","ikbusweb02" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}

#SQL

Invoke-Command -ComputerName "iksql01","iksql02" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}
Invoke-Command -ComputerName "iksql08","iksql09" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}
Invoke-Command -ComputerName "iksql10","iksql11" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}
Invoke-Command -ComputerName "iksql12","iksql13" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}
Invoke-Command -ComputerName "iksql14","iksql15" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}

#Any

Invoke-Command -ComputerName "ikbkp01","rksofs03","rksofs04","rkechost01","rkechost02","rkbot01","ikhom02","rkhom01","rkstage01","rkstage02" -ScriptBlock {Set-NetIPAddress -InterfaceAlias Interna -PrefixLength 22}

#Legacy

ikweb08
ikweb09
ikweb14
ikweb15
ikmon01
ikhom01
rak-mpintegra