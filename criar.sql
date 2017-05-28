/*Formatting Output*/
.header on
.mode column
--.timer on

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
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS Golo;
DROP TABLE IF EXISTS Amarelo;
DROP TABLE IF EXISTS Vermelho;


CREATE TABLE Epoca (
	idEpoca			INTEGER 	PRIMARY KEY,
	dataInicio 		TEXT		NOT NULL, -- para guardar o numero de dias
	dataFim 		TEXT		NOT NULL -- para guardar o numero de dias
);

CREATE TABLE Jornada (
	idJornada		INTEGER 	PRIMARY KEY,
	dataInicio 		TEXT		NOT NULL,
	dataFim 		TEXT		NOT NULL,
	idEpoca			INTEGER		NOT NULL,
		FOREIGN KEY (idEpoca) REFERENCES Epoca
);

CREATE TABLE Jogo (
	idJogo			INTEGER 	PRIMARY KEY,
	data 			DATE		NOT NULL,
	golosCasa 		INTEGER		CHECK(golosCasa>=0 AND golosCasa IS NOT NULL),
	golosFora 		INTEGER		CHECK(golosFora>=0 AND golosFora IS NOT NULL),
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
	minutoEntrada		INTEGER		CHECK (minutoEntrada >= 0),
	minutoSaida			INTEGER		CHECK ((minutoEntrada IS NULL AND minutoSaida IS NULL) OR minutoSaida >= minutoEntrada),
	PRIMARY KEY (idJogador, idJogo),
		FOREIGN KEY (idJogador) REFERENCES Jogador,
		FOREIGN KEY (idJogo) REFERENCES Jogo
);

CREATE TABLE Pessoa (
	idPessoa		INTEGER 	PRIMARY KEY,
	nome 			TEXT 		NOT NULL,
	dataNascimento 	TEXT		NOT NULL,
	altura 			INTEGER		CHECK(altura>0), -- cm
	peso 			INTEGER		CHECK(peso>0),--kg
	idCidadeNasc	INTEGER		NOT NULL,
		FOREIGN KEY (idCidadeNasc) REFERENCES Cidade
);

CREATE TABLE Jogador (
	idPessoa		INTEGER		PRIMARY KEY,
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
	idContrato		INTEGER 	PRIMARY KEY,
	dataInicio 		TEXT		NOT NULL,
	dataFim 		TEXT		NOT NULL
);

CREATE TABLE ContratoStaff (
	idContrato		INTEGER,
	idStaff			INTEGER		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
	idFuncao		INTEGER		NOT NULL,
		FOREIGN KEY (idContrato) REFERENCES Contrato,
		FOREIGN KEY (idStaff) REFERENCES Staff,
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idFuncao) REFERENCES Funcao
);

CREATE TABLE ContratoJogador (
	idContrato		INTEGER		,
	idJogador		INTEGER		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
		FOREIGN KEY (idContrato) REFERENCES Contrato,
		FOREIGN KEY (idJogador) REFERENCES Jogador,
		FOREIGN KEY (idEquipa) REFERENCES Equipa
);

CREATE TABLE Funcao (
	idFuncao		INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL UNIQUE
);

CREATE TABLE Equipamento (
	idEquipamento	INTEGER 	PRIMARY KEY,
	corCamisola 	TEXT		NOT NULL,
	corCalcoes 		TEXT		NOT NULL,
	idEquipa 		INTEGER		NOT NULL,
	idEpoca			INTEGER		NOT NULL,
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idEpoca) REFERENCES Epoca
);

CREATE TABLE Equipa (
	idEquipa		INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL,
	dataFundacao 	TEXT		NOT NULL,
	idEstadio		INTEGER		NOT NULL,
		FOREIGN KEY (idEstadio) REFERENCES Estadio
);

CREATE TABLE Participou (
	idEquipa 			INTEGER		NOT NULL,
	idEpoca  			INTEGER		NOT NULL,
	classificacao		INTEGER		CHECK ((classificacao>0 AND classificacao<=18) OR classificacao IS NOT NULL),
		PRIMARY KEY (idEquipa, idEpoca),
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idEpoca) REFERENCES Epoca
);

CREATE TABLE Estadio (
	idEstadio		INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL UNIQUE,
	dataAbertura 	TEXT		NOT NULL,
	morada 			TEXT		NOT NULL,
	lotacao 		INTEGER		NOT NULL,
	idCidade 		INTEGER		NOT NULL,
		FOREIGN KEY (idCidade) REFERENCES Cidade
);

CREATE TABLE Pais (
	idPais			INTEGER		PRIMARY KEY,
	nome 			TEXT		NOT NULL UNIQUE
);

CREATE TABLE Cidade (
	idCidade		INTEGER 	PRIMARY KEY,
	nome 			TEXT		NOT NULL,
	idPais			INTEGER		NOT NULL,
		FOREIGN KEY (idPais) REFERENCES Pais
);

CREATE TABLE Evento (
	idEvento		INTEGER		PRIMARY KEY,
	minuto			INTEGER		CHECK(minuto>=0 AND minuto IS NOT NULL),
	idEquipa 		INTEGER		NOT NULL,
	idJogador		INTEGER		NOT NULL,
	idJogo 			INTEGER		NOT NULL,
		FOREIGN KEY (idEquipa) REFERENCES Equipa,
		FOREIGN KEY (idJogador) REFERENCES Jogador,
		FOREIGN KEY (idJogo) REFERENCES Jogo
);

CREATE TABLE Golo (
	idEvento		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idEvento) REFERENCES Evento
);

CREATE TABLE Amarelo (
	idEvento		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idEvento) REFERENCES Evento
);


CREATE TABLE Vermelho (
	idEvento		INTEGER		PRIMARY KEY,
		FOREIGN KEY (idEvento) REFERENCES Evento
);
