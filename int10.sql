.mode columns
.headers on
.nullvalue NULL

.width 20 10
/*INTERROGACAO 10 - Jogadores com mais cartoes Epoca 2016/2017*/

/*
--Amarelos
SELECT Pessoa.idPessoa as id, count(Pessoa.nome) as num
FROM Amarelo INNER JOIN Evento
ON Amarelo.idEvento = Evento.idEvento
INNER JOIN Jogador
ON Jogador.idPessoa = Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
INNER JOIN Jogo
ON Evento.idJogo = Jogo.idJogo
INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
GROUP BY Pessoa.nome;
*/

/*
--Vermelhos
SELECT Pessoa.idPessoa as id, count(Pessoa.nome) as num
FROM Vermelho INNER JOIN Evento
ON Vermelho.idEvento = Evento.idEvento
INNER JOIN Jogador
ON Jogador.idPessoa = Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
INNER JOIN Jogo
ON Evento.idJogo = Jogo.idJogo
INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
GROUP BY Pessoa.nome;
*/

SELECT Pessoa.nome,
CASE Amarelos.num
WHEN Jogador.idPessoa = Amarelos.id THEN
Amarelos.num
ELSE
0
END Amarelos,
CASE Vermelhos.num
WHEN Jogador.idPessoa = Vermelhos.id THEN
Vermelhos.num
ELSE
0
END Vermelhos
FROM Jogador, Pessoa,
(SELECT Pessoa.idPessoa as id, count(Pessoa.nome) as num
  FROM Amarelo INNER JOIN Evento
  ON Amarelo.idEvento = Evento.idEvento
  INNER JOIN Jogador
  ON Jogador.idPessoa = Evento.idJogador
  INNER JOIN Pessoa
  ON Pessoa.idPessoa=Jogador.idPessoa
  INNER JOIN Jogo
  ON Evento.idJogo = Jogo.idJogo
  INNER JOIN Jornada
  ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
  GROUP BY Pessoa.nome) Amarelos,
(SELECT Pessoa.idPessoa as id, count(Pessoa.nome) as num
  FROM Vermelho INNER JOIN Evento
  ON Vermelho.idEvento = Evento.idEvento
  INNER JOIN Jogador
  ON Jogador.idPessoa = Evento.idJogador
  INNER JOIN Pessoa
  ON Pessoa.idPessoa=Jogador.idPessoa
  INNER JOIN Jogo
  ON Evento.idJogo = Jogo.idJogo
  INNER JOIN Jornada
  ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
  GROUP BY Pessoa.nome) Vermelhos
WHERE (Jogador.idPessoa=Pessoa.idPessoa AND (Jogador.idPessoa = Amarelos.id OR Jogador.idPessoa = Vermelhos.id))
GROUP BY Pessoa.idPessoa
ORDER BY Vermelhos.num DESC;
