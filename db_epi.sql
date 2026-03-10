CREATE DATABASE IF NOT EXISTS db_epis;
USE db_epis;
CREATE TABLE setor (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    nome_setor VARCHAR(80) NOT NULL,
    responsavel VARCHAR(100),
    turno VARCHAR(100)
);
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    valor REAL NOT NULL
);
CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11),
    cargo VARCHAR(80),
    id_setor INT,
    id_inspecao INT,
    turno VARCHAR(20) DEFAULT 'Primeiro',
    status VARCHAR(20) DEFAULT 'Ativo',
    FOREIGN KEY (id_setor)
        REFERENCES setor (id_setor),
	FOREIGN KEY (id_inspecao)
        REFERENCES inspecao_epi (id_inspecao) ON DELETE RESTRICT
);
CREATE TABLE epi (
    id_epi INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(60),
    numero_ca VARCHAR(20) ,
    fabricante VARCHAR(80),
    dt_validade DATE ,
    id_inspecao INT , 
	FOREIGN KEY (id_inspecao)
        REFERENCES inspecao_epi (id_inspecao) ON DELETE RESTRICT
);
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_epi INT NOT NULL,
    id_fornecedor INT,
    qtd_disponivel INT NOT NULL DEFAULT 0,
    lote VARCHAR(40),
        FOREIGN KEY (id_epi)
        REFERENCES epi (id_epi) ON DELETE RESTRICT,
    FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor (id_fornecedor)ON DELETE RESTRICT

);
CREATE TABLE inspecao_epi (
    id_inspecao INT AUTO_INCREMENT PRIMARY KEY,
    data_inspecao date,
    resultado varchar(20)
);
CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_epi INT NOT NULL,
    id_estoque INT,
    dt_entrega DATE NOT NULL,
    dt_devolucao DATE,
    observacao TEXT,
    assinatura BOOLEAN DEFAULT FALSE not null, 
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario),
    FOREIGN KEY (id_epi)
        REFERENCES epi (id_epi),
    FOREIGN KEY (id_estoque) 
        REFERENCES estoque (id_estoque) ON DELETE RESTRICT
);

CREATE INDEX idx_epi_entrega ON entrega(dt_entrega);

UPDATE estoque 
set qtd_disponivel = qtd_disponivel - qtd_entrega
where assinatura = true;


