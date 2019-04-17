Invoke-command -ComputerName '' -ScriptBlock {

Get-ADUser -Filter {name -Like "*distrib*"} -Properties description | Select sAMAccountName,description
}