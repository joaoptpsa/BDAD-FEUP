/*Formatting Output*/
.header on
.mode column
.timer on

/*Allow Foreign Keys*/
PRAGMA foreign_keys = ON;

/*MUDAR AS DATAS PARA STRING ?*/

DROP TABLE IF EXISTS Epoca;
DROP TABLE IF EXISTS Jornada;
DROP TABLE IF EXISTS Jogo;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Jogador;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Arbitro;
DROP TABLE IF EXISTS Contrato;
DROP TABLE IF EXISTS Funcao;
DROP TABLE IF EXISTS Equipamento;
DROP TABLE IF EXISTS Equipa;
DROP TABLE IF EXISTS Estadio;
DROP TABLE IF EXISTS Pais;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS Golo;
DROP TABLE IF EXISTS Amarelo;
DROP TABLE IF EXISTS Vermelho;


CREATE TABLE Epoca (
	id 				INTEGER 	PRIMARY KEY,
	dataInicio REAL, -- para guardar o numero de dias 
	dataFim REAL -- para guardar o numero de dias 
);

CREATE TABLE Jornada (
	id 				INTEGER 	PRIMARY KEY,
	dataInicio REAL, 
	dataFim REAL
);

CREATE TABLE Jogo (
	id 				INTEGER 	PRIMARY KEY,
	data 			REAL		NOT NULL,
	golosCasa 		INTEGER		CHECK(golosCasa>=0),
	golosFora 		INTEGER		CHECK(golosFora>=0),
	idEquipaCasa	INTEGER		NOT NULL,
	idEquipaFora	INTEGER		NOT NULL,
	idEstadio		INTEGER		NOT NULL,
	idArbitro		INTEGER		NOT NULL,
	idJornada		INTEGER		NOT NULL,
		FOREIGN KEY (idEquipaCasa) REFERENCES Equipa,
		FOREIGN KEY (idEquipaFora) REFERENCES Equipa,
		FOREIGN KEY (idEstadio) REFERENCES Estadio,
		FOREIGN KEY (idArbitro) REFERENCES Arbitro,
		FOREIGN KEY (idJornada) REFERENCES Jornada
);

CREATE TABLE Pessoa (
	id 				INTEGER 	PRIMARY KEY,
	nome 			TEXT 		NOT NULL,
	dataNascimento 	REAL		NOT NULL, 
	altura 			INTEGER		CHECK(altura>0), -- cm
	peso 			INTEGER		CHECK(peso>0)--kg
);

CREATE TABLE Jogador (
	idPessoa		INTEGER		NOT NULL,
	posicaoPref TEXT,
	pePref TEXT,
		FOREIGN KEY (idPessoa) REFERENCES Pessoa
);

CREATE TABLE Staff (
	idPessoa		INTEGER		NOT NULL,
		FOREIGN KEY (idPessoa) REFERENCES Pessoa
);

CREATE TABLE Arbitro (
	idPessoa		INTEGER		NOT NULL,
		FOREIGN KEY (idPessoa) REFERENCES Pessoa
);

CREATE TABLE Contrato (
	id 				INTEGER 	PRIMARY KEY,
	dataInicio REAL, 
	dataFim REAL
);

CREATE TABLE Funcao (
	id 				INTEGER 	PRIMARY KEY,
	nome TEXT
);

CREATE TABLE Equipamento (
	id 				INTEGER 	PRIMARY KEY,
	corCamisola TEXT,
	corCalcoes TEXT
);

CREATE TABLE Equipa (
	id 				INTEGER 	PRIMARY KEY,
	nome TEXT,
	dataFundacao REAL 
);

CREATE TABLE Estadio (
	id 				INTEGER 	PRIMARY KEY,
	nome TEXT,
	dataAbertura REAL, 
	morada TEXT,
	lotacao INTEGER
);

CREATE TABLE Pais (
	id 				INTEGER 	PRIMARY KEY,
	nome TEXT
);

CREATE TABLE Cidade (
	id 				INTEGER 	PRIMARY KEY,
	nome TEXT
);

CREATE TABLE Golo (
	minuto INTEGER
);

CREATE TABLE Amarelo (
	minuto INTEGER
);

CREATE TABLE Vermelho (
	minuto INTEGER
);