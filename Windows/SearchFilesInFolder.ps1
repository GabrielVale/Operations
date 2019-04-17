$AliasStore = Get-Content "E:\PS\lojas.txt"


# Windows directory creation
ForEach ($Store in $AliasStore)
{
$Path = Join-Path "\\Sofs01\rakuten\Repository\" -childpath $Store\imagens\categorias
Get-ChildItem $Path -exclude "*gitkeep*"
}