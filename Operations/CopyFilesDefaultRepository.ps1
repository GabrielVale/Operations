$loja = 'Invel'


New-Item -Path \\rkweb01\wwwroot\IKCLoja\Genesis\Repository `
         -Name $loja -ItemType Directory


Copy-Item -Path "E:\PS\Default Repository\*" `
          -Destination \\rkweb01\wwwroot\IKCLoja\Genesis\Repository\$loja `
          -Recurse


Set-ItemProperty -LiteralPath \\rkweb01\wwwroot\IKCLoja\Genesis\Repository\$loja\* `
                 -name IsReadOnly `
                 -value $false