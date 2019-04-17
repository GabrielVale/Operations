#Identificar PID em diversos ambientes

$Ambiente = "IKWEB05","IKWEB06", "IKWEB22", "IKWEB23"

Get-WmiObject -NameSpace 'root\WebAdministration' `
              -class 'WorkerProcess' `
              -ComputerName $Ambiente | `
              Select AppPoolName,ProcessId,PSComputerName | `
              Sort-Object PSComputerName | `
              Set-Content E:\IIS\WPlist.txt

#Identificar Pool pelo PID

#Get-WmiObject -NameSpace 'root\WebAdministration' -class 'WorkerProcess' | where ProcessId -like "*168648*" | Select AppPoolName, ProcessId