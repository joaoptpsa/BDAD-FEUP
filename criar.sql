/*FALTA AS KEYS*/

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


CREATE TABLE Epoca (
	id INTEGER,
	dataInicio REAL, -- para guardar o numero de dias 
	dataFim REAL -- para guardar o numero de dias 
);

CREATE TABLE Jornada (
	id INTEGER,
	dataInicio REAL, 
	dataFim REAL
);

CREATE TABLE Jogo (
	id INTEGER,
	data REAL,
	golosCasa INTEGER,
	golosFora INTEGER 
);

CREATE TABLE Pessoa (
	id INTEGER,
	nome TEXT,
	dataNascimento REAL, 
	altura INTEGER, -- cm
	peso INTEGER --kg
);

CREATE TABLE Jogador (
	posicaoPref TEXT,
	pePref TEXT
);

CREATE TABLE Staff (
);

CREATE TABLE Arbitro (
);

CREATE TABLE Contrato (
	id INTEGER,
	dataInicio REAL, 
	dataFim REAL
);

CREATE TABLE Funcao (
	id INTEGER,
	nome TEXT
);

CREATE TABLE Equipamento (
	id INTEGER,
	corCamisola TEXT,
	corCalcoes TEXT
);

CREATE TABLE Equipa (
	id INTEGER,
	nome TEXT,
	dataFundacao REAL 
);

CREATE TABLE Estadio (
	id INTEGER,
	nome TEXT,
	dataAbertura REAL, 
	morada TEXT,
	lotacao INTEGER
);

CREATE TABLE Pais (
	id INTEGER,
	nome TEXT
);

CREATE TABLE Cidade (
	id INTEGER,
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