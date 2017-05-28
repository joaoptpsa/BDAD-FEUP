.mode columns
.headers on
.nullvalue NULL

.width 20 10
/*INTERROGACAO 5 - Jogadores sub23*/

SELECT strftime('%Y', 'now')-strftime ('%Y', Pessoa.dataNascimento) as Idade, count (*) as Num_Jogadores
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
WHERE (Idade <= 23)
GROUP BY Idade
ORDER BY Idade ASC;
