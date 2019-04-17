$File = Import-Csv .\***CSVNAME***

$File | ForEach-Object {CommandExample -ExempleParam $_.columnA -ExempleParam @varexemple -ExempleParam $_.columnB }


<# Exemplo prático
	$File = Import-Csv .\addrecord.csv
	$File | foreach {Add-DnsServerResourceRecordA -Name $_.name -ZoneName ikeda.local -IPv4Address $_.ip }
#>