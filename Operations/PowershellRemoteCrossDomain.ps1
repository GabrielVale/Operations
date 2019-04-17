# Created: 10/10/2018
# Author: Gabriel Vale

# Script para conectar em uma instancia de powershell remoto em outro domínio.
# É necessário esse procedimento pois a conexão precisa ser através de SSL

# Gera arquivo SSL, exporta o arquivo e habilita o acesso remoto por SSL no firewall
$SERVERLIST = Get-Content "E:\PS\servidores.txt"

ForEach ($SERVERNAME in $SERVERLIST)
{
Invoke-Command -ComputerName $SERVERNAME -ScriptBlock 
    {
        Set-ExecutionPolicy Unrestricted; 
        $Cert = New-SelfSignedCertificate -CertstoreLocation 'Cert:\LocalMachine\My' -DnsName "$Using:SERVERNAME";
        Export-Certificate -Cert $Cert -FilePath "E:\$Using:SERVERNAME.crt";
        Enable-PSRemoting -SkipNetworkProfileCheck -Force;
        New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint –Force;
        New-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Name "Windows Remote Management (HTTPS-In)" -Profile Any -LocalPort 5986 -Protocol TCP;
        Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpsListener -Value true;
        Disable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"                       
    }
}
# Copia os certificados gerados para um repositorio específico
ForEach ($SERVERNAME in $SERVERLIST)
{
Invoke-Command {Copy-Item \\$SERVERNAME\E$\$SERVERNAME.crt -Destination \\$computername\e$\PS\Cert -Force }
}

#--------------------------------------------------------------------------------------------------------

# No computador local #
# Iniciar o serviço Windows Remote
start-service winrm
# Habilitar o PowerShell Remoto
Enable-PSRemoting –force
# importa certificado dos servidores desejados
$CERTLIST = Get-Content "E:\PS\certificados.txt"
ForEach ($CERT in $CERTLIST)
    {
        $PathCert = 'E:\PS\Cert'
        Import-Certificate -Filepath "$PathCert\$CERT.crt" -CertStoreLocation "Cert:\LocalMachine\Root"
        Set-Item WSMan:\localhost\Client\TrustedHosts -Concatenate -Value "$CERT" -Force
    }
#Salva a credencial na sessão PS
$Credential = get-credential
# Conecta no host remoto
Enter-PSSession -ComputerName 'RKMPBOT01' -UseSSL -Credential $Credential

