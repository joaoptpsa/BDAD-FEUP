.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 5 - Jogadores sub23*/

SELECT strftime('%Y', 'now')-strftime ('%Y', Pessoa.dataNascimento) as Idade, count (*) as Num_Jogadores
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
WHERE (Idade < 23)
GROUP BY strftime ('%Y', Pessoa.dataNascimento)
ORDER BY strftime ('%Y', Pessoa.dataNascimento) DESC;
