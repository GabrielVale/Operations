$IKWEB03 = 'E:\Robos\DBCoreUpdater_One_IKWEB03'
$IKWEB05 = 'E:\Robos\DBCoreUpdater_Genesis_Classic_IKWEB05'
$IKWEB10 = 'E:\Robos\DBCoreUpdater_One_IKWEB10'
$IKWEB12 = 'E:\Robos\DBCoreUpdater_Genesis_Classic_IKWEB12'
$IKWEB22 = 'E:\Robos\DBCoreUpdater_Genesis_Classic_IKWEB22'
$IKWEB24 = 'E:\Robos\DBCoreUpdater_One_IKWEB24'
$RKFLASHWEB03 = 'E:\Robos\DBCoreUpdater_FlasStore'


#Remove config Antigo

Remove-Item -Path $IKWEB05\ConfigProd.xml
Remove-Item -Path $IKWEB12\ConfigProd.xml
Remove-Item -Path $IKWEB22\ConfigProd.xml
Remove-Item -Path $IKWEB03\ConfigProd.xml
Remove-Item -Path $IKWEB10\ConfigProd.xml
Remove-Item -Path $IKWEB24\ConfigProd.xml
Remove-Item -Path $RKFLASHWEB03\ConfigProd.xml


#Copia o arquivo atualizado para cada diretorio

Copy-Item E:\PS\ConfigProd_Genesis_Classic_IKWEB05.xml -Destination $IKWEB05 
Copy-Item E:\PS\ConfigProd_Genesis_Classic_IKWEB12.xml -Destination $IKWEB12 
Copy-Item E:\PS\ConfigProd_Genesis_Classic_IKWEB22.xml -Destination $IKWEB22
Copy-Item E:\PS\ConfigProd_One_IKWEB03.xml -Destination $IKWEB03
Copy-Item E:\PS\ConfigProd_One_IKWEB10.xml -Destination $IKWEB10
Copy-Item E:\PS\ConfigProd_One_IKWEB24.xml -Destination $IKWEB24
Copy-Item E:\PS\ConfigProd_FlashStore.xml -Destination $RKFLASHWEB03

#Renomeia o arquivo

Rename-Item -Path $IKWEB05\ConfigProd_Genesis_Classic_IKWEB05.xml -NewName ConfigProd.xml 
Rename-Item -Path $IKWEB12\ConfigProd_Genesis_Classic_IKWEB12.xml -NewName ConfigProd.xml 
Rename-Item -Path $IKWEB22\ConfigProd_Genesis_Classic_IKWEB22.xml -NewName ConfigProd.xml
Rename-Item -Path $IKWEB03\ConfigProd_One_IKWEB03.xml -NewName ConfigProd.xml
Rename-Item -Path $IKWEB10\ConfigProd_One_IKWEB10.xml -NewName ConfigProd.xml
Rename-Item -Path $IKWEB24\ConfigProd_One_IKWEB24.xml -NewName ConfigProd.xml
Rename-Item -Path $RKFLASHWEB03\ConfigProd_FlashStore.xml -NewName ConfigProd.xml


#Remove pacote Antigo

Remove-Item -Path $IKWEB05\Bkp\*  -recurse -force
Remove-Item -Path $IKWEB05\Scripts\* -recurse -force
Remove-Item -Path $IKWEB05\Pacote\* -recurse -force
Remove-Item -Path $IKWEB12\Bkp\* -recurse -force
Remove-Item -Path $IKWEB12\Scripts\* -recurse -force
Remove-Item -Path $IKWEB12\Pacote\* -recurse -force
Remove-Item -Path $IKWEB22\Bkp\* -recurse -force
Remove-Item -Path $IKWEB22\Scripts\* -recurse -force
Remove-Item -Path $IKWEB22\Pacote\* -recurse -force
Remove-Item -Path $IKWEB03\Bkp\* -recurse -force
Remove-Item -Path $IKWEB03\Scripts\* -recurse -force
Remove-Item -Path $IKWEB03\Pacote\* -recurse -force
Remove-Item -Path $IKWEB10\Bkp\* -recurse -force
Remove-Item -Path $IKWEB10\Scripts\* -recurse -force
Remove-Item -Path $IKWEB10\Pacote\* -recurse -force
Remove-Item -Path $IKWEB24\Bkp\* -recurse -force
Remove-Item -Path $IKWEB24\Scripts\* -recurse -force
Remove-Item -Path $IKWEB24\Pacote\* -recurse -force
Remove-Item -Path $RKFLASHWEB03\Bkp\* -recurse -force
Remove-Item -Path $RKFLASHWEB03\Scripts\* -recurse -force
Remove-Item -Path $RKFLASHWEB03\Pacote\* -recurse -force


#Copia o pacote novo para cada diretorio

Copy-Item E:\PS\Pacote\* -recurse -Destination $IKWEB05/pacote  
Copy-Item E:\PS\Scripts\* -recurse -Destination $IKWEB05/scripts 
Copy-Item E:\PS\Pacote\* -recurse -Destination $IKWEB12/pacote  
Copy-Item E:\PS\Scripts\* -recurse -Destination $IKWEB12/scripts 
Copy-Item E:\PS\Pacote\* -recurse -Destination $IKWEB22/pacote  
Copy-Item E:\PS\Scripts\* -recurse -Destination $IKWEB22/scripts  
Copy-Item E:\PS\Pacote\* -recurse -Destination $IKWEB03/pacote
Copy-Item E:\PS\Scripts\* -recurse -Destination $IKWEB03/scripts
Copy-Item E:\PS\Pacote\* -recurse -Destination $IKWEB10/pacote
Copy-Item E:\PS\Scripts\* -recurse -Destination $IKWEB10/scripts
Copy-Item E:\PS\Pacote\* -recurse -Destination $IKWEB24/pacote
Copy-Item E:\PS\Scripts\* -recurse -Destination $IKWEB24/scripts
Copy-Item E:\PS\Pacote\* -recurse -Destination $RKFLASHWEB03/pacote
Copy-Item E:\PS\Scripts\* -recurse -Destination $RKFLASHWEB03/scripts

#Copia o config novo para cada diretorio

Copy-Item E:\PS\WebConfigs\IKWEB05_Genesis_Classic\web.config -Destination $IKWEB05/pacote 
Copy-Item E:\PS\WebConfigs\IKWEB12_Genesis_Classic\web.config -Destination $IKWEB12/pacote 
Copy-Item E:\PS\WebConfigs\IKWEB22_Genesis_Classic\web.config -Destination $IKWEB22/pacote
Copy-Item E:\PS\WebConfigs\IKWEB03_One_1-7\web.config -Destination $IKWEB03/pacote
Copy-Item E:\PS\WebConfigs\IKWEB10_One\web.config -Destination $IKWEB10/pacote
Copy-Item E:\PS\WebConfigs\IKWEB24_One\web.config -Destination $IKWEB24/pacote
Copy-Item E:\PS\WebConfigs\RKFLASHWEB03\web.config -Destination $RKFLASHWEB03/pacote