.mode columns
.headers on
.nullvalue NULL

.width 10 20
/*INTERROGACAO 9 - Média de Idades por Equipa*/


SELECT Equipa.nome, printf("%.2f",AVG(strftime('%Y', 'now')-strftime ('%Y', Pessoa.dataNascimento))) as Idade
FROM ContratoJogador, Pessoa INNER JOIN Equipa
WHERE ContratoJogador.idJogador = Pessoa.idPessoa AND ContratoJogador.idEquipa = Equipa.idEquipa
GROUP BY Equipa.idEquipa
ORDER BY Idade ASC;
