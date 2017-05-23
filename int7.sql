.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 7 - Jogadores Avancados Esquerdinos / Destros*/

SELECT Pessoa.nome, Jogador.pePref
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
WHERE (Jogador.posicaoPref = 'Avançado')
ORDER BY Jogador.pePref DESC;
