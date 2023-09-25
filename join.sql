DROP DATABASE IF EXISTS BANCO;

CREATE DATABASE IF NOT EXISTS BANCO;

USE BANCO;

CREATE TABLE IF NOT EXISTS EMPRESTIMO(
	NUM_EMPRESTIMO VARCHAR(15) PRIMARY KEY,
    NOME_AGENCIA VARCHAR(50),
    QUANTIA INT
);

CREATE TABLE IF NOT EXISTS CLIENTE(
	_id int auto_increment primary key,
	NOME_CLIENTE VARCHAR(50),
    NUM_EMPRESTIMO VARCHAR(15)
);

insert into EMPRESTIMO(NUM_EMPRESTIMO, NOME_AGENCIA, QUANTIA) values 
("L-170", "Downtown", 3000),
("L-230", "Redwood", 4000),
("L-260", "Perryridge", 17000);

insert into CLIENTE(NOME_CLIENTE, NUM_EMPRESTIMO) values 
("Jones", "L-170"),
("Smith", "L-230"),
("Hayes", "L-115");

SELECT *
FROM EMPRESTIMO INNER JOIN CLIENTE ON EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO;
/*
	Aqui ele mostra apenas os items que possuem valores iguais em ambas as tabelas
	no caso, pega os valores de Emprestimo que fazem parte de Cliente
*/

SELECT *
FROM EMPRESTIMO LEFT JOIN CLIENTE
ON EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO;
/*
	Aqui, além dele pegar os valores que estão presentes em ambas as tabelas, 
    ele também pega os demais valores da tabela A, pegando então toda a tabela A 
    + os valores que de A que fazem parte do conjunto B, com A sendo Emprestimo e 
    B sendo Cliente. Com os valores null sendo a parte da tabela B que não faz parte de A
*/

SELECT *
FROM EMPRESTIMO RIGHT JOIN CLIENTE
ON EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO;
/*
	Aqui a situação é a mesma do de cima, porém trocado, pegando tudo da tabela de Clientes
	junto com os valores de Clientes que fazem parte de Emprestimo
*/

SELECT *
FROM EMPRESTIMO NATURAL JOIN CLIENTE;
/*
	Aqui ele faz o mesmo que o INNER JOIN, porém com a diferença de que ele concatena as colunas
    com valores iguais em uma só ao invés de exibi-lá duas vezes, note que a coluna de
    NUM_EMPRESTIMO só aparece uma vez
*/

SELECT *
FROM EMPRESTIMO RIGHT OUTER JOIN CLIENTE
ON EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO WHERE EMPRESTIMO.NUM_EMPRESTIMO IS NULL;
/*
	Aqui ele faz similar ao RIGHT JOIN normal, com a diferença que aqui ele só mostra os valores 
    de CLIENTE.NUM_EMPRESTIMO que não existem em EMPRESTIMO.NUM_EMPRESTIMO
*/

SELECT *
FROM EMPRESTIMO LEFT OUTER JOIN CLIENTE
ON EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO WHERE CLIENTE.NUM_EMPRESTIMO IS NULL;
/*
	Vale o mesmo para esse, só que com a outra tabela
*/

SELECT *
FROM EMPRESTIMO
LEFT OUTER JOIN CLIENTE ON
EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO
UNION
SELECT *
FROM EMPRESTIMO
RIGHT OUTER JOIN CLIENTE ON
EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO;
/*
	Aqui, com o UNION, o que estamos fazendo é basicamente pegando os dados da tabela
    de EMPRESTIMO e unindo aos dados da tabela de CLIENTES, em que os dados em null
    aparecem pois esses dados não estão presentes na outra tabela, assim, obtemos todos 
    os dados possíveis.
    
    Note que ele não simplesmente juntou ambas, pois as linhas nao se repetem, as celulas em que
    NUM_EMPRESTIMO estão presentes em ambas as tabelas são concatenadas em uma nova linha, formando 
    uma tabela nova, se ele simplesmente juntasse ele exibiria 6 colunas ao inves de 4
*/

SELECT *
FROM EMPRESTIMO
LEFT OUTER JOIN CLIENTE ON
EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO
INTERSECT
SELECT *
FROM EMPRESTIMO
RIGHT OUTER JOIN CLIENTE ON
EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO;
/*
	O intersect tem o mesmo comportamento que o INNER JOIN, de pegar somente os items iguais.
    Por mais que ele acuse erro no código, ele funciona como se espera
*/

SELECT *
FROM EMPRESTIMO
LEFT OUTER JOIN CLIENTE ON
EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO
EXCEPT
SELECT *
FROM EMPRESTIMO
RIGHT OUTER JOIN CLIENTE ON
EMPRESTIMO.NUM_EMPRESTIMO = CLIENTE.NUM_EMPRESTIMO;
/*
	O mesmo vale para este, que pega tudo da tabela um que nao faz parte da tabela dois
*/