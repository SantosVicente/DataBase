DROP DATABASE IF EXISTS EMPRESADETAXI;

CREATE DATABASE IF NOT EXISTS EMPRESADETAXI;

USE EMPRESADETAXI;

CREATE TABLE IF NOT EXISTS clientes(
	cliId int(11) primary key,
    nome varchar(45) NOT NULL,
    CPF char(14) NOT NULL
);

CREATE TABLE IF NOT EXISTS taxi(
	placa char(7) NOT NULL primary key,
    marca varchar(45) NOT NULL,
    modelo varchar(45) NOT NULL,
	anoFab int(4) NOT NULL,
    licenca varchar(9) NOT NULL
);

CREATE TABLE IF NOT EXISTS corrida(
	cliId int(11),
    placa char(7),
    dataPedido date NOT NULL
);


CREATE TABLE IF NOT EXISTS motorista(
	CNH char(6) primary key,
    nome varchar(45) NOT NULL,
    CNHValid char(1) NOT NULL,
	placa char(7) NOT NULL
);

CREATE TABLE IF NOT EXISTS zona(
	Zona varchar(45) NOT NULL primary key
);

CREATE TABLE IF NOT EXISTS fila(
	zona varchar(45),
    CNH char(6),
    dataHoraIn datetime NOT NULL,
	dataHoraOut datetime NOT NULL,
	kmIn int(4) NOT NULL
);

show tables;

INSERT INTO clientes(cliId, nome, CPF) values
(1532, "Asdrúba", "448.754.253-65"),
(1755, "Doriana", "567.387.387-44"),
(1780, "Quincas", "546.373.762-02");

INSERT INTO taxi(placa, marca, modelo, anoFab, licenca) values
('DXF5263', 'Ford', 'Escort', 2001, 'GG5263526'),
('MJN6578', 'Wolks', 'Santana', 1998, 'KL856326'),
('MLA4545', 'Wolks', 'Gol', 2000, 'YK6574837'),
('DXA7878', 'Ford', 'Escort', 2000, 'GG5263526'),
('DXF6767', 'Wolks', 'Santana', 1998, 'YK7890081');

INSERT INTO corrida(cliId, placa, dataPedido) values
(1532, "DXA7878", "2003-02-18"),
(1755, "DKL7878", "2003-02-16"),
(1755, "DXF5263", "2003-02-15"),
(1780, "DXF6767", "2003-02-17"),
(1780, "MJN6578", "2003-02-18"),
(1780, "MLA4545", "2003-02-16");

INSERT INTO motorista(CNH, nome, CNHValid, placa) values
(657483, 'Asdruba', 1, 'DXF5263'),
(567892, 'Quincas', 1, 'MLA4545'),
(452635, 'Zandor', 1, 'DXA7878'),
(452452, 'Alcebia', 1, 'DXF6767'),
(555555, 'Bonerge', 1, 'DXF5263'),
(987654, 'Doriana', 1, 'JDM8776');

INSERT INTO zona(Zona) values
("Barão Geraldo"),
("Cambuí"),
("Taquaral"),
("Unicamp");

INSERT INTO fila(zona, CNH, DataHoraIn, DataHoraOut, kmIn) values
('Barão Geraldo', 567892, '2002-06-05 09:00:00', '2002-06-05 09:30:00', 4630),
('Barão Geraldo', 657483, '2002-06-05 07:30:00', '2002-06-05 07:45:00', 1567),
('Taquaral', 452452, '2002-06-05 09:00:00', '2002-06-05 09:50:00', 5000),
('Taquaral', 657483, '2002-06-06 08:00:00', '2002-06-06 08:07:00', 7900),
('Unicamp', 452635, '2002-06-02 08:00:00', '2002-06-02 08:00:00', 4800),
('Unicamp', 567892, '2002-06-06 06:00:00', '2002-06-06 06:00:00', 5263),
('Unicamp', 657483, '2002-06-06 23:00:00', '2002-06-06 23:00:00', 4541),
('Unicamp', 452452, '2002-06-05 10:30:00', '2002-06-05 10:30:00', 7800),
('Taquaral', 555555, '2002-06-06 08:10:00', '2002-06-06 08:10:00', 7910),
('Unicamp', 987654, '2002-06-05 10:30:00', '2002-06-05 10:35:00', 7850);

SELECT Zona
FROM zona
WHERE zona IN (SELECT distinct fila.zona from fila);

SELECT Zona
FROM zona
WHERE zona NOT IN (SELECT distinct fila.zona from fila);

select distinct clientes.nome
from clientes, corrida, taxi
where clientes.cliId = corrida.cliId and corrida.placa = taxi.placa and taxi.modelo = 'Escort';

SELECT zona.Zona
FROM zona
WHERE zona.Zona NOT IN
(SELECT DISTINCT fila.zona
FROM fila);

SELECT zona.Zona FROM zona
WHERE EXISTS (
SELECT * FROM fila
WHERE fila.zona = zona.Zona);

SELECT zona.Zona FROM zona 
WHERE NOT EXISTS
(SELECT * FROM fila
WHERE fila.zona = zona.Zona);