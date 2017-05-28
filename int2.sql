.mode columns
.headers on
.nullvalue NULL

.width 30 6
/*INTERROGACAO 2 - Melhores marcardores Época 2016/17*/

Select Pessoa.nome, count(Pessoa.idPessoa) as Golos_Marcados
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Evento
ON (Evento.idJogo=Jogo.idJogo)
INNER JOIN Golo
ON (Golo.idEvento=Evento.idEvento)
INNER JOIN Jogador
ON Jogador.idPessoa=Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
GROUP BY Pessoa.idPessoa
ORDER BY Golos_Marcados DESC;
