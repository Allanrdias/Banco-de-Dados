-- Realizar Backup do Banco de Dados
BACKUP DATABASE NomeDB TO DISK = 'C:\Backup.bak';

-- Criar login com senha
CREATE LOGIN NomeLogin WITH PASSWORD = 'SenhaLogin';

-- Criar usuário com login
CREATE USER NomeUsuario FOR LOGIN NomeLogin;

-- Liberar permissões e acessos
GRANT SELECT, INSERT, UPDATE, DELETE ON NomeTabela TO NomeUsuario;

-- Retirar permissões e acessos
REVOKE SELECT, INSERT, UPDATE, DELETE ON NomeDaTabela TO NovoUsuario;

/*
A auditoria é um processo que registra e rastreia as atividades
dos usuários no banco de dados. Isso é útil para entender quem fez
o quê no banco de dados. No SQL Server, você pode usaro recurso de
auditoria do SQL Server para rastrear eventos no nível do servidor
e do banco de dados. Por exemplo, você pode rastrear eventos de login
bem-sucedidos e malsucedidos, alterações de esquema ou consultas de
seleção em uma tabela específica.
*/

-- Criação de uma especificação de auditoria do servidor
USE master;
GO
CREATE SERVER AUDIT ServerAudit
TO FILE (FILEPATH = 'C:\\Auditoria\\')
WITH (ON_FAILURE = CONTINUE);
GO

-- Ativação da auditoria do servidor
ALTER SERVER AUDIT ServerAudit
WITH (STATE = ON);