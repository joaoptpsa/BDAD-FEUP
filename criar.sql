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
DROP TABLE IF EXISTS Convocado;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Jogador;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Arbitro;
DROP TABLE IF EXISTS Contrato;
DROP TABLE IF EXISTS ContratoStaff;
DROP TABLE IF EXISTS ContratoJogador;
DROP TABLE IF EXISTS Funcao;
DROP TABLE IF EXISTS Equipamento;
DROP TABLE IF EXISTS Equipa;
DROP TABLE IF EXISTS Participou;
DROP TABLE IF EXISTS Estadio;
DROP TABLE IF EXISTS Pais;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS Golo;
DROP TABLE IF EXISTS Amarelo;
DROP TABLE IF EXISTS Vermelho;


CREATE TABLE Epoca (
	id 				INTEGER 	PRIMARY KEY,
	dataInicio 		REAL		NOT NULL, -- para guardar o numero de dias 
	dataFim 		REAL		NOT NULL -- para guardar o numero de dias 
);

CREATE TABLE Jornada (
	id 				INTEGER 	PRIMARY KEY,
	dataInicio 		REAL		NOT NULL, 
	dataFim 		REAL		NOT NULL,
	idEpoca			INTEGER		NOT NULL,
		FOREIGN KEY (idEpoca) REFERENCES Epoca
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

CREATE TABLE Convocado (
	idJogador 			INTEGER		NOT NULL,
	idJogo  			INTEGER		NOT NULL,
	minutoEntrada		INTEGER		CHECK (minutoEntrada IS NULL | minutoEntrada >= 0),
	minutoSaida			INTEGER		CHECK ((minutoEntrada IS NULL & minutoSaida IS NULL) | minutoSaida >= minutoEntrada),
	PRIMARY KEY (idJogador, idJogo),
		FOREIGN KEY (idJogador) REFERENCES Jogador,
		FOREIGN KEY (idJogo) REFERENCES Jogo
);

CREATE TABLE Pessoa (
	id 				INTEGER 	PRIMARY KEY,
	nome 			TEXT 		NOT NULL,
	dataNascimento 	REAL		NOT NULL, 
	altura 			INTEGER		CHECK(altura>0 | altura IS NULL), -- cm
	peso 			INTEGER		CHECK(peso>0 | peso IS NULL),--kg
	idCidadeNasc	INTEGER		NOT NULL,
		FOREIGN KEY (idCidadeNasc) REFERENCES Cidade
);


--Contrato
CREATE TABLE Jogador (
	idPessoa		INTEGER		NOT NULL,
	posicaoPref 	TEXT		,
	pePref			TEXT		,
		FOREIGN KEY (idPessoa) REFERENCES Pessoa

);

CREATE TABLE Staff (
	idPessoa		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idPessoa) REFERENCES Pessoa
);

CREATE TABLE Arbitro (
	idPessoa		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idPessoa) REFERENCES Pessoa
);

CREATE TABLE Contrato (
	id 				INTEGER 	PRIMARY KEY,
	dataInicio 		REAL		NOT NULL, 
	dataFim 		REAL		NOT NULL
);

CREATE TABLE ContratoStaff (
	idContrato		INTEGER		PRIMARY KEY,
	idStaff			INTEGER		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
	idFuncao		INTEGER		NOT NULL,
		FOREIGN KEY (idContrato) REFERENCES Contrato,
		FOREIGN KEY (idStaff) REFERENCES Staff,
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idFuncao) REFERENCES Funcao
);

CREATE TABLE ContratoJogador (
	idContrato		INTEGER		PRIMARY KEY,
	idJogador		INTEGER		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
		FOREIGN KEY (idContrato) REFERENCES Contrato,
		FOREIGN KEY (idJogador) REFERENCES Jogador,
		FOREIGN KEY (idEquipa) REFERENCES Equipa
);

CREATE TABLE Funcao (
	id 				INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL UNIQUE
);

CREATE TABLE Equipamento (
	id 				INTEGER 	PRIMARY KEY,
	corCamisola 	TEXT		NOT NULL,
	corCalcoes 		TEXT		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
	idEpoca			INTEGER		NOT NULL,
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idEpoca) REFERENCES Epoca
);

CREATE TABLE Equipa (
	id 				INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL,
	dataFundacao 	REAL		NOT NULL,
	idEstadio		INTEGER		NOT NULL,
		FOREIGN KEY (idEstadio) REFERENCES Estadio 
);

CREATE TABLE Participou (
	idEquipa 			INTEGER		NOT NULL,
	idEpoca  			INTEGER		NOT NULL,
	classificacao		INTEGER		CHECK (classificacao>0 & classificacao<=18),
		PRIMARY KEY (idEquipa, idEpoca),
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idEpoca) REFERENCES Epoca
);

CREATE TABLE Estadio (
	id 				INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL UNIQUE,
	dataAbertura 	REAL		NOT NULL, 
	morada 			TEXT		NOT NULL,
	lotacao 		INTEGER		NOT NULL,
	idCidade 		INTEGER		NOT NULL,
		FOREIGN KEY (idCidade) REFERENCES Cidade
);

CREATE TABLE Pais (
	id 				INTEGER		PRIMARY KEY,
	nome 			TEXT		NOT NULL UNIQUE
);

CREATE TABLE Cidade (
	id 				INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL,
	idPais			INTEGER		NOT NULL,
		FOREIGN KEY (idPais) REFERENCES Pais
);

CREATE TABLE Evento (
	id 				INTEGER		PRIMARY KEY,
	minuto			INTEGER		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
	idJogador		INTEGER		NOT NULL,
	idJogo 			INTEGER		NOT NULL,
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idJogador) REFERENCES Jogador,
		FOREIGN KEY (idJogo) REFERENCES Jogo
)

CREATE TABLE Golo (
	idEvento		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idEvento) REFERENCES Evento
)

CREATE TABLE Amarelo (
	idEvento		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idEvento) REFERENCES Evento
);


CREATE TABLE Vermelho (
	idEvento		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idEvento) REFERENCES Evento
);
