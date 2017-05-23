.mode columns
.headers on
.nullvalue NULL

.width 20 6
/*INTERROGACAO 2 - Melhores marcardores*/

SELECT Pessoa.nome, count(Pessoa.nome) as num
FROM Golo INNER JOIN Evento
ON Golo.idEvento = Evento.idEvento
INNER JOIN Jogador
ON Jogador.idPessoa = Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
GROUP BY Pessoa.nome
ORDER BY num DESC;
