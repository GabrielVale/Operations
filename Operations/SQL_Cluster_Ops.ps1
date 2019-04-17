## List active node on cluster sql ##
# Habilitar a Feature FailOver Cluster no Windows para instalar o módulo
import-module failoverclusters
#Listar nessa variável os clusters
$sqlcluster = 'IKSQLCLUSTER05', 'IKSQLCLUSTER06', 'IKSQLCLUSTER08', 'IKSQLCLUSTERSVC', 'IKSQLCLUSTER09'
foreach ($srvhost in $sqlcluster) 
    {
        get-clustergroup -cluster $srvhost |
        ? name -eq 'Cluster Group'  |
        select OwnerNode `
    }