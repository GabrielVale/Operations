# Date:     04/12/2018
# Author:   Gabriel Vale
# SymLink Release DBCore

$ErrorActionPreference   = "Stop"

$StoreList = Get-Content "E:\PS\iissites.txt"
$Release = "27.1"

foreach ($Store in $StoreList) {
    New-Item -ItemType SymbolicLink -Path "E:\IIS\wwwroot2\$Store" -Target "E:\IIS\wwwroot\release\$Release" -force
    Restart-WebAppPool $Store
}