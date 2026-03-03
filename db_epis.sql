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
    cpf CHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(80),
    id_setor INT NOT NULL,
    id_inspecao INT NOT NULL,
    turno VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Ativo',
    FOREIGN KEY (id_setor)
        REFERENCES setor (id_setor),
	FOREIGN KEY (id_inspecao)
        REFERENCES inspecao_epi (id_inspecao)
);
CREATE TABLE epi (
    id_epi INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(60),
    numero_ca VARCHAR(20) NOT NULL,
    fabricante VARCHAR(80),
    dt_validade DATE NOT NULL,
    id_inspecao INT NOT NULL, 
	FOREIGN KEY (id_inspecao)
        REFERENCES inspecao_epi (id_inspecao)
);
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_epi INT NOT NULL,
    id_fornecedor INT,
    qtd_disponivel INT NOT NULL DEFAULT 0,
    lote VARCHAR(40),
    FOREIGN KEY (id_epi)
        REFERENCES epi (id_epi),
    FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor (id_fornecedor)
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
    FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario),
    FOREIGN KEY (id_epi)
        REFERENCES epi (id_epi),
    FOREIGN KEY (id_estoque)
        REFERENCES estoque (id_estoque)
);

CREATE INDEX idx_epi_entrega ON entrega(dt_entrega);



