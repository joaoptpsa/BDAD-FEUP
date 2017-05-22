.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 1 - Top jogadores mais altos*/

SELECT nome, altura
FROM Pessoa
ORDER BY altura DESC LIMIT 10;
