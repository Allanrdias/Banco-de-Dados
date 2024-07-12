-- Comentário
-- Criação de um banco de dados
CREATE DATABASE Aula1
 
-- Usar o banco de dados criado
USE Aula1
GO
 
-- Criação da tabela Aluno
CREATE TABLE Aluno
(
    id_aluno INTEGER PRIMARY KEY,
    nome VARCHAR(30) NOT NULL
)
 
-- 1 Forma de utilização do INSERT INTO
INSERT INTO Aluno (id_aluno, nome) VALUES (1, 'Allan')
 
-- 2 Forma de utilização do INSERT INTO
INSERT INTO Aluno VALUES (2, 'Alisson')
 
-- 3 Forma de utilização do INSERT INTO
INSERT INTO Aluno 
VALUES 
    (3, 'Cleber'),
    (4, 'Julia'),
    (5, 'Leticia')
 
-- Recuperar valores inseridos na tabela
SELECT * FROM Aluno -- * TUDO

-- Recuperar valores com seleção por campos
SELECT id_aluno, nome FROM Aluno
 

CREATE TABLE Professor
(
    id_professor INTEGER PRIMARY KEY IDENTITY, -- Auto incremento
    nome VARCHAR(MAX) NOT NULL,
    sexo CHAR(1) CHECK IN ('F', 'M')-- M or F
)
 
-- INSERT COM A RESTRIÇÃO IDENTITY para o campo id_professor
INSERT INTO Professor VALUES ('Allan', 'M') -- Não precisa adicionar valor para id_professor
 
-- INSERT SEM PASSAR VALOR PARA UM CAMPO NULL
INSERT INTO Professor VALUES ('Alisson', null)
INSERT INTO Professor (nome) VALUES('Julia')
INSERT INTO Professor (nome, sexo)
VALUES('Leticia', 'F')
 
-- Dropar/Excluir uma tabela
DROP TABLE Professor

-- Dropar/Excluir os registros de uma tabela, mantendo a estrutara
TRUNCATE TABLE Professor
 
-- SELECT COM WHERE/FILTRO
SELECT * FROM Professor WHERE sexo = 'M'

-- Selecionar apenas valores distintos (diferentes)
SELECT DISTINCT nome FROM Aluno
 
-- Selecionar o número de registros a serem retornados
SELECT TOP(3) nome, salario FROM Aluno
ORDER BY nome ASC / DESC
 
-- Alterar a tabela Alino incluindo um novo campo
ALTER TABLE Aluno
ADD fk_id_professor INT
 
-- Alterar a tabela Aluno add uma RESTRIÇÃO/CONSTRAINT FOREIGN KEY
ALTER TABLE Aluno
ADD CONSTRAINT FK_Professor_Aluno
FOREIGN KEY (fk_id_professor)
REFERENCES Professor (id_professor)
 
INSERT INTO Aluno VALUES (5, 'Carlos', 6)
SELECT * FROM Aluno
SELECT * FROM Professor
 
CREATE DATABASE Aula2
USE Aula2
GO
 
CREATE TABLE Aluno 
(
    id_aluno int primary key identity,
    nome varchar(MAX) not null,
    matricula decimal(5,2),
    rua varchar(MAX),
    numero varchar(10),
    bairro varchar(MAX),
    cidade varchar(50),
    estado varchar(MAX),
    data_nascimento DATE
)
 
INSERT INTO Aluno
VALUES('Carlos', 800.00, 'Rua Jacarai', 15, 'Alto Boqueirão', 'São Jose dos Pinhais', 'PR', '1976-05-23')
 
SELECT 
    id_aluno, 
    nome, 
    matricula, 
    CAST(ROUND(matricula * 0.1, 2) AS numeric(18,2)) AS Valor_reajuste, -- Utilizar o campo matricula para projetar um campo Valor reajuste 
    CAST(ROUND((matricula * 0.1 + matricula), 2) AS numeric(18,2)) AS Valor_total, -- Utilizar o campo matricula para projetar um campo Valor total usando a matemática
    rua + ', ' + numero + ', ' + bairro + ', ' + cidade + ', ' + estado as Rua_Numero_Bairro_Cidade_UF, -- Realizar a junção de 3 campos em 1 projeção
    DAY(data_nascimento) AS Dia, -- Recuperar o dia do campo data_nascimento
    MONTH(data_nascimento) AS Mês, -- Recuperar o mês do campo data_nascimento
    YEAR(data_nascimento) AS Ano 
FROM 
    Aluno 
WHERE 
    MONTH(data_nascimento) IN (5,6,8); -- Recuperar apenas onde estiver relacionado ao mês 5, 6 e 8
-- LIKE
SELECT nome FROM Aluno
WHERE nome LIKE 'Carlos' -- Valor exato
 
-- LIKE com operador CORINGA %
SELECT nome FROM Aluno
WHERE nome LIKE '%Carlos' -- Termina com Carlos
 
SELECT nome FROM Aluno
WHERE nome LIKE 'Carlos%' -- Começa com Carlos
 
SELECT nome FROM Aluno
WHERE nome LIKE '%Carlos%' -- Contiver Carlos
 
-- IS NULL
SELECT nome  FROM Aluno
WHERE rua IS NULL
 
-- IS NOT NULL
SELECT * FROM Aluno
WHERE rua IS NOT NULL
 
-- ORDER BY
SELECT * FROM Aluno
ORDER BY nome
 
SELECT * FROM Aluno
ORDER BY nome DESC
 
ALTER TABLE Aluno
ADD sexo CHAR(1) CHECK(sexo IN ('M', 'F'))
 
ALTER TABLE Aluno
ADD salario numeric(10,2)
 
DELETE FROM Aluno
 
INSERT INTO Aluno
VALUES('Joana', 800.00, 'Rua Jacarai', 15, 'Alto Boqueirão',
 'São Jose dos Pinhais', 'PR', '1976-05-23',  'F', 2500.00)
 
INSERT INTO Aluno
VALUES('Julia', 800.00, 'Rua Jacarai', 15, 'Alto Boqueirão', 
'São Jose dos Pinhais', 'PR', '1976-05-23', 10000.00, 'F')
 
INSERT INTO Aluno
VALUES('Alisson', 800.00, 'Rua Jacarai', 15, 'Alto Boqueirão', 
'São Jose dos Pinhais', 'PR', '1976-05-23', 10000.00, 'M')
 
INSERT INTO Aluno
VALUES('Carlos', 800.00, 'Rua Jacarai', 15, 'Alto Boqueirão', 
'São Jose dos Pinhais', 'PR', '1976-05-23', 5000.00, 'M')
 
-- GROUP BY
SELECT count(id_aluno), salario FROM Aluno
GROUP BY salario
ORDER BY salario ASC
 
-- AVG = Média
SELECT sexo, AVG(salario) FROM Aluno
GROUP BY sexo
 
-- SUM = Soma
SELECT sexo, SUM(salario) FROM Aluno
GROUP BY sexo
 
-- MAX = Maior
SELECT sexo, MAX(salario) FROM Aluno
GROUP BY sexo
 
-- MIN = Menor
SELECT sexo, MIN(salario) FROM Aluno
GROUP BY sexo
 
-- Sexo = M 
SELECT sexo, SUM(salario) FROM Aluno
WHERE sexo = 'M'
GROUP BY sexo
 
-- Sexo = F
SELECT count(id_aluno)
FROM Aluno
WHERE sexo = 'F'

-- HAVING
SELECT count(sexo) AS Qtd, sexo, AVG(salario) FROM Aluno
GROUP BY sexo
-- WHERE salario = 2500.00
HAVING SEXO = 'M'
ORDER BY sexo
 
-- CASE
SELECT sexo, salario,
CASE
  WHEN salario > 2500 THEN 'O salário é maior'
  WHEN salario <= 2500 THEN 'O salário é menor ou igual a 2500'
END AS Resultado 
FROM Aluno
 
CREATE TABLE Professor
(
    id_professor INTEGER PRIMARY KEY IDENTITY, -- Auto incremento
    nome VARCHAR(MAX) NOT NULL,
    sexo CHAR(1) -- M or F
)
 
ALTER TABLE Aluno
ADD fk_p_id_professor INTEGER
 
ALTER TABLE Aluno
ADD CONSTRAINT FK_Professor_Aluno FOREIGN KEY (fk_p_id_professor)
REFERENCES Professor (id_professor)
 
INSERT INTO Professor VALUES('Allan', 'M')
INSERT INTO Professor VALUES('Jose', 'M')
INSERT INTO Professor VALUES('Julia', 'F')
 
-- Apagar os registros da tabela mantendo a estrutura
TRUNCATE TABLE Aluno
 
-- JUNÇÃO de tabelas onde a primary key e foreign key coincidem
SELECT * FROM Aluno
INNER JOIN Professor
ON Professor.id_professor = Aluno.fk_p_id_professor
 
-- JUNÇÃO com apelido para acesso aos campos
SELECT A.id_aluno, A.nome, A.salario, A.sexo, P.id_professor, P.nome FROM Aluno A
INNER JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
 
-- JUNÇÃO de tabelas mantendo os registros da tabela a esquerda - Tabela A
SELECT A.id_aluno, A.nome, A.salario, A.sexo, P.id_professor, P.nome FROM Aluno A
LEFT JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
 
-- JUNÇÃO de tabelas mantendo os registros da tabela a direita - Tabela B
SELECT A.id_aluno, A.nome, A.salario, A.sexo, P.id_professor, P.nome FROM Aluno A
RIGHT JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
 
-- JUNÇÃO de tabelas mantendo os registros das duas tabelas - Tabela A e B
SELECT A.id_aluno, A.nome, A.salario, A.sexo, P.id_professor, P.nome FROM Aluno A
FULL JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
 
-- JUNÇÃO de tabelas mantendo os registros da tabela a direita onde id_aluno IS NULL
SELECT A.id_aluno, A.nome, A.salario, A.sexo, P.id_professor, P.nome FROM Aluno A
RIGHT JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
WHERE A.id_aluno IS NULL
 
-- JUNÇÃO de tabelas mantendo os registros da tabela a direita onde id_aluno IS NULL ou id_professor IS NULL
SELECT A.id_aluno, A.nome, A.salario, A.sexo, A.fk_p_id_professor, P.id_professor, P.nome FROM Aluno A
RIGHT JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
WHERE A.id_aluno IS NULL
OR P.id_professor IS NULL
 
-- INNER JOIN com AGREGAÇÃO
SELECT count(id_aluno) AS Qtd, P.nome AS Professor FROM Aluno A
INNER JOIN Professor P
ON P.id_professor = A.fk_p_id_professor
GROUP BY P.id_professor, P.nome

-- Criar uma tabela virtual
CREATE VIEW MediaSalarialF
AS SELECT count(sexo) AS Qtd, sexo, CAST(ROUND(AVG(salario),2) AS numeric(10,2)) AS Média FROM Aluno
GROUP BY sexo
HAVING SEXO = 'F'

CREATE VIEW MediaSalarialM
AS SELECT count(sexo) AS Qtd, sexo, CAST(ROUND(AVG(salario),2) AS numeric(10,2)) AS Média FROM Aluno
GROUP BY sexo
HAVING SEXO = 'M'

-- Recuperar uma tabela virtual
SELECT * FROM MediaSalarialf

/*CRIAÇÃO DOS INDICES */
CREATE INDEX idx_professor ON Professor(id_professor)


-- CRIAÇÃO DE TABELAS E UTILIZAÇÃO DE UMA TRIGGER
CREATE TABLE Professor
(
    id_professor INTEGER PRIMARY KEY IDENTITY, -- Auto incremento
    nome VARCHAR(MAX) NOT NULL,
    sexo CHAR(1), -- M or F
	salario decimal(10,2),
	data DATE
)

CREATE TABLE Historico
(
	id_historico INTEGER PRIMARY KEY IDENTITY,
	salario DECIMAL (10,2),
	data_atualizacao DATE
)

CREATE TRIGGER AumentoSalarial
ON Professor 
FOR INSERT
AS 
BEGIN
	DECLARE
	@VALOR DECIMAL(10,2), 
	@DATA DATE

	SELECT @VALOR = salario, @DATA = data FROM INSERTED

	INSERT INTO Historico
	VALUES (@VALOR, @DATA)
END

-- Dropar a trigger
DROP TRIGGER AumentoSalarial

/*Criação da stored procedure*/
CREATE PROCEDURE PegarTotalProfessores
AS
BEGIN
    SELECT COUNT(*) AS TotalProfessores
    FROM Professor;
END;

EXEC PegarTotalProfessores;


-- Recuperar a máquina e o usuário que está conectado
SELECT suser_name()

CREATE DATABASE Pizzaria

USE Pizzaria

CREATE TABLE Estoque
	(
		Tam_caixa VARCHAR(10) PRIMARY KEY NOT NULL,
		QTD_ESTOQUE INT NOT NULL
	)

CREATE TABLE Pedido
	(
		Id_pedido INT IDENTITY PRIMARY KEY NOT NULL,
		Sabor VARCHAR(255) NOT NULL,
		Tamanho VARCHAR(10) NOT NULL
		FOREIGN KEY(Tamanho) REFERENCES Estoque(Tam_caixa),
		QTD_Pedido INT NOT NULL
	)

-- Atividade Pizzaria
INSERT INTO Estoque
VALUES
	('Pequena', 1500),
	('Media', 750),
	('Grande', 1000)

CREATE OR ALTER TRIGGER Atualizacao
ON Pedido AFTER INSERT
AS 
BEGIN
	UPDATE Estoque 
	SET QTD_ESTOQUE = QTD_ESTOQUE - inserted.QTD_Pedido
	FROM inserted INNER JOIN Estoque
	ON Estoque.Tam_caixa = inserted.Tamanho
END

SELECT * FROM Estoque

INSERT INTO Pedido
VALUES
	('Marguerita', 'Pequena', 10),
	('Portugues', 'Media', 15),
	('Salaminho', 'Grande', 30),
	('Perdigão', 'Grande', 20),
	('Frango com Catupiry', 'Pequena', 10)