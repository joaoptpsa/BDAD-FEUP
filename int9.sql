.mode columns
.headers on
.nullvalue NULL

.width 10 20
/*INTERROGACAO 9 - Média de Idades por Equipa*/

/*
SELECT  ContratoJogador.*, AVG(strftime('%Y', 'now')-strftime ('%Y', Pessoa.dataNascimento)) as Idade
FROM ContratoJogador, Pessoa
WHERE idEquipa=4 AND idJogador = idPessoa;
 */


-- SELECT idEquipa as ID,nome as Nome FROM Equipa
SELECT Equipa.idEquipa,Equipa.nome, AVG(strftime('%Y', 'now')-strftime ('%Y', Pessoa.dataNascimento)) as Média_Idades
FROM Equipa,ContratoJogador, Pessoa
WHERE idEquipa=4 AND idJogador = idPessoa;
