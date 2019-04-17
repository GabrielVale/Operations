#Gerar Senha Aelatoria
##GeneratePassword(8,2) onde 8 é a quantidade total de caracteres e 2 é a quantidade de caracteres não alfanuméricos

Add-Type -AssemblyName System.Web 
for($counter = 1; $counter -le 10; $counter++)
	         {
[System.Web.Security.Membership]::GeneratePassword(8,2)
}
