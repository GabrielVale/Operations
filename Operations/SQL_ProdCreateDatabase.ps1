##Instalar o modulo SQL Server no powershell
#Install-Module -Name SqlServer
#

#Efetua Backup da base DBRGOneOficial no SQL Local
Invoke-Sqlcmd -Query `
"BACKUP DATABASE [DBRGOneOficial] TO  DISK = N'E:\DBRGOneOficial.bak' WITH  COPY_ONLY, NOFORMAT, INIT,  NAME = N'DBRGOneOficial-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10;" `
-ServerInstance "10.0.0.110"

#Copia o backup feito para o servidor de Produção (Nó ativo do Cluster)
Copy-Item '\\10.0.0.110\e$\DBRGOneOficial.bak' -Destination \\192.168.0.76\F$\ -Force

# Restaura o banco em Produção
### Modelo
#Efetue replace no bloco abaixo da palavra Modelo para o nome do Alias da loja. Se houver mais de uma loja, fazer o replace e executar somente o bloco abaixo para cada uma.
Invoke-Sqlcmd -Query `
    "
--# Esse comando cria a pasta destino do Full Text
EXECUTE master.dbo.xp_create_subdir N'F:\FTDs\DBRGModelo'
GO
RESTORE DATABASE [DBRGModelo] FROM  DISK = N'F:\DBRGOneOficial.bak' WITH  FILE = 1,  
MOVE N'DBIKCLoja_Data' TO N'F:\MDFs\DBRGModelo.mdf',  
MOVE N'DBIKCLoja_Indices' TO N'F:\NDFs\DBRGModelo.ndf',  
MOVE N'DBIKCLoja_Log' TO N'L:\LDFs\DBRGModelo.ldf',  
MOVE N'ftrow_Produtos' TO N'F:\FTDs\DBRGModelo\DBRGModelo.ndf',  NOUNLOAD,  REPLACE,  STATS = 10
GO

-- MUDA A BASE PARA SIMPLE NO RECOVERY MODEL
ALTER DATABASE [DBRGModelo] SET RECOVERY SIMPLE WITH NO_WAIT
GO
ALTER DATABASE [DBRGModelo] SET RECOVERY SIMPLE 
GO
USE [master]
GO
ALTER DATABASE [DBRGModelo] SET COMPATIBILITY_LEVEL = 100
GO

-- EXCLUI OS USUÁRIOS QUE JÁ VEM NA BASE
USE [DBRGModelo]
GO
/****** Object:  User [UIKCLoja]    Script Date: 02/17/2014 11:11:14 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'UIKCLoja')
DROP USER [UIKCLoja]
GO
/****** Object:  User [UIKCGenesisBeta3]    Script Date: 02/17/2014 11:11:14 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'UIKCGenesisBeta3')
DROP USER [UIKCGenesisBeta3]
GO
/****** Object:  User [UIKRelInter]    Script Date: 02/17/2014 11:11:14 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'UIKRelInter')
DROP USER [UIKRelInter]
GO
/****** Object:  User [URKECSearch]    Script Date: 02/17/2014 11:11:14 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'URKECSearch')
DROP USER [URKECSearch]
GO
/****** Object:  User [URKStoreReport]    Script Date: 02/17/2014 11:11:14 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'URKStoreReport')
DROP USER [URKStoreReport]
GO
/****** Object:  User [[URGModelo]]    Script Date: 02/17/2014 11:11:14 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'URGModelo')
DROP USER [URGModelo]
GO


-- CRIA OS USUÁRIOS NAS BASES
USE [master]
GO
CREATE LOGIN [URGModelo] WITH PASSWORD=N'PRGModelo', DEFAULT_DATABASE=[DBRGModelo], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [DBIKCorreios]
GO
CREATE USER [URGModelo] FOR LOGIN [URGModelo]
GO
USE [DBIKCorreios]
GO
EXEC sp_addrolemember N'db_datareader', N'URGModelo'
GO
USE [DBRGModelo]
GO
CREATE USER [URGModelo] FOR LOGIN [URGModelo]
GO
USE [DBRGModelo]
GO
EXEC sp_addrolemember N'db_owner', N'URGModelo'
GO
USE [msdb]
GO
CREATE USER [URGModelo] FOR LOGIN [URGModelo]
GO
USE [msdb]
GO
EXEC sp_addrolemember N'DatabaseMailUserRole', N'URGModelo'

--LIMPA AS TABELAS TIKCLOG, TIKCLOGWEBSERVICE, TIKCLOGERRO
USE DBRGModelo
GO
TRUNCATE TABLE TIKCLOG
GO
TRUNCATE TABLE TIKCLOGWEBSERVICE
GO
TRUNCATE TABLE TIKCLOGERRO
GO

-- FAZ O DUMP E SHRINK NA BASE
USE MASTER
GO
DBCC SHRINKDATABASE('DBRGModelo',0)
    " `
-ServerInstance "192.168.0.227"
