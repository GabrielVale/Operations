# Date:     03/12/2018
# Author:   Gabriel Vale
# SymLink DBCore

$Store = "Genesis"
$Release = "27.1"

# Create or edit a SymLink
New-Item -ItemType SymbolicLink -Path "E:\IIS\wwwroot\$Store" -Target "E:\IIS\wwwroot\release\$Release" -force

### IIS ###

# Load IIS module:
Import-Module WebAdministration
# Set a name of the site we want to recycle the pool for:
$site = "Genesis"
# Get pool name by the site name:
$pool = (Get-Item "IIS:\Sites\$site"| Select-Object applicationPool).applicationPool
# Recycle the application pool:
Restart-WebAppPool $pool