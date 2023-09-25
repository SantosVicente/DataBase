DROP DATABASE IF EXISTS compras;

CREATE DATABASE IF NOT EXISTS compras;

USE compras;

CREATE TABLE IF NOT EXISTS fornecedor(
	idFornecedor int(11) primary key,
    nome varchar(45) NOT NULL,
    CNPJ char(18) NOT NULL,
    endereco varchar(50) not null
);

CREATE TABLE IF NOT EXISTS produto(
	idProduto int(11) auto_increment primary key,
    nome varchar(45) NOT NULL,
    preco decimal(8,2) NOT NULL,
    idFornecedor int(11) NOT NULL,
    
    FOREIGN KEY(idFornecedor) REFERENCES fornecedor(idFornecedor)
);

CREATE TABLE IF NOT EXISTS cliente(
	idCliente int(11) primary key,
    nome varchar(45) NOT NULL,
    CPF char(14) NOT NULL,
	endereco VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS compra(
	idCompra int(11) primary key,
    dataCompra DATE NOT NULL,
    dataVencimento DATE NOT NULL,
	formaPagto VARCHAR(45) NOT NULL,
    idCliente int(11) NOT NULL,

    FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE IF NOT EXISTS itensCompra(
	idCompra int(11) NOT NULL,
    idProduto int(11) NOT NULL,
    qtd int(11) NOT NULL,
    
    FOREIGN KEY(idCompra) REFERENCES compra(idCompra),
    FOREIGN KEY(idProduto) REFERENCES produto(idProduto)
);

INSERT INTO fornecedor(idFornecedor, nome, CNPJ, endereco)
VALUES
('1', 'CHAMEX', '123123123', 'Rua Mogi das Cruzes, 101 Sao Paulo'),
('2', 'HP', '321123444', 'Rua da Fecilidade, 121 Sao Paulo'),
('3', 'Elgin', '667162432', 'Rua Fuxuco, 232 Rio de janeiro');

INSERT INTO produto(idProduto, nome, preco, idFornecedor)
VALUES
('1', 'Papel A4', '14.00', '1'),
('2', 'Cartucho HP', '45.00', '2'),
('3', 'Etiqueta CD', '17.00', '1'),
('4', 'Cd RW', '5.00', '2'),
('5', 'Cd R', '2.00', '2');

INSERT INTO cliente(idCliente, nome, CPF, endereco)
VALUES
('201', 'Pedro Oliveira', '231213', 'Rua das Hortências,100 - Bragança Pta'),
('222', 'João Souza', '243456', 'Rua das Orquideas, 300 - Bragança Pta'),
('321', 'Maria Souza', '121234', 'Rua das Pedras, 20 - Bragança Pta'),
('421', 'Ana Freire', '198716', 'Rua das Hortências, 200 - Campinas'),
('545', 'Silvia Oliveira', '878765', 'Rua das Hortências, 300 - Bragança Pta');

INSERT INTO compra(idCompra, dataCompra, dataVencimento, formaPagto, idCliente)
VALUES
('10', '2016-04-01', '2016-05-02', 'CC', '201'),
('20', '2016-04-01', '2016-05-02', 'CC', '321'),
('30', '2016-04-05', '2016-05-02', 'CC', '421'),
('100', '2016-04-10', '2016-05-02', 'CC', '421'),
('112', '2016-04-10', '2016-05-02', 'CC', '201');

INSERT INTO itensCompra(idCompra, idProduto, qtd)
VALUES
('10','1',1),
('10','2',1),
('10','3',1),
('20','1',20),
('20','4',1),
('30','1',10),
('30','2',1),
('100','1',10),
('112','5',1);

select * from produto ORDER BY preco;

SELECT MAX(preco) 'maior preço', MIN(preco) 'menor preço', AVG(preco) 'preço medio' FROM produto;

SELECT idFornecedor fornecedor, count(idproduto) produtos FROM produto GROUP BY fornecedor;

SELECT idProduto, sum(qtd) Unidades FROM itensCompra GROUP BY idProduto ORDER BY 1;

show tables;