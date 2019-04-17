$File1 = '\\10.0.0.23\RKFiles\IT\FTP\Genesis\IKCTelevendas\bin\IKCCheckout 2.2.dll'
$File2 = '\\ikweb22\e$\IIS\wwwroot\BelezaDeMulher\IKCTelevendas\bin\IKCCheckout 2.2.dll'
$File3 = '\\ikweb22\e$\IIS\wwwroot\BrinquedosMil\IKCTelevendas\bin\IKCCheckout 2.2.dll'

Get-FileHash $File1,$File2,$File3 -Algorithm MD5
