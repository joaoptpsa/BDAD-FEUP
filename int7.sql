.mode columns
.headers on
.nullvalue NULL

.width 20 10
/*INTERROGACAO 7 - Jogadores Avancados Esquerdinos / Destros*/

SELECT Pessoa.nome, Jogador.pePref
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
WHERE (Jogador.posicaoPref = 'Avancado')
ORDER BY Jogador.pePref DESC;
