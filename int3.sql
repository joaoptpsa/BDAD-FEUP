.mode columns
.headers on
.nullvalue NULL

.width 20 6

/*INTERROGACAO 3 - Arbitros que deram mais cartoes 2016/2017*/

SELECT Pessoa.nome, Amarelos.num_Cartoes as Amarelos, Vermelhos.num_Cartoes as Vermelhos,Amarelos.num_Cartoes+Vermelhos.num_Cartoes as num_Cartoes
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Arbitro
ON (Jogo.idArbitro=Arbitro.idPessoa)
INNER JOIN Pessoa
ON (Arbitro.idPessoa=Pessoa.idPessoa),
(SELECT Jogo.idJogo as idJogo, count (*) as num_Cartoes
FROM Jogo INNER JOIN Evento
ON (Jogo.idJogo=Evento.idJogo)
INNER JOIN Amarelo
ON (Evento.idEvento=Amarelo.idEvento)
GROUP BY Jogo.idJogo) Amarelos,
(SELECT Jogo.idJogo as idJogo, count (*) as num_Cartoes
FROM Jogo INNER JOIN Evento
ON (Jogo.idJogo=Evento.idJogo)
INNER JOIN Vermelho
ON (Evento.idEvento=Vermelho.idEvento)
GROUP BY Jogo.idJogo) Vermelhos
WHERE (Jogo.idJogo = Amarelos.idJogo OR Jogo.idJogo = Vermelhos.idJogo)
GROUP BY Pessoa.idPessoa
ORDER BY num_Cartoes DESC;
/*
--Cartoes Amarelos por idJogo
SELECT Jogo.idJogo, count (*) as num_Cartoes
FROM Jogo INNER JOIN Evento
ON (Jogo.idJogo=Evento.idJogo)
INNER JOIN Amarelo
ON (Evento.idEvento=Amarelo.idEvento)
GROUP BY Jogo.idJogo;

--Cartoes Vermelhos pos idJogo
SELECT Jogo.idJogo, count (*) as num_Cartoes
FROM Jogo INNER JOIN Evento
ON (Jogo.idJogo=Evento.idJogo)
INNER JOIN Vermelho
ON (Evento.idEvento=Vermelho.idEvento)
GROUP BY Jogo.idJogo;
*/
