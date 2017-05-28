.mode columns
.headers on
.nullvalue NULL

.width 30 6
/*INTERROGACAO 1 - Top jogadores mais altos*/

SELECT Pessoa.nome as Nome_Jogador, Pessoa.altura
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
ORDER BY altura DESC LIMIT 10;
