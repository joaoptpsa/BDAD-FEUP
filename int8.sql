.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 8 - */

SELECT posicaoPref, count(posicaoPref)
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
GROUP BY posicaoPref;
