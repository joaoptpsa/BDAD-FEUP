.mode columns
.headers on
.nullvalue NULL

.width 20 10
/*INTERROGACAO 8 - Quantidade de jogadores para cada posicao */

SELECT posicaoPref, count(posicaoPref) AS num
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
GROUP BY posicaoPref;
