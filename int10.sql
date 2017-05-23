.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 10 - Jogadores com mais cartoes*/

/*
--Amarelos
SELECT Pessoa.nome, count(Pessoa.nome)
FROM Amarelo INNER JOIN Evento
ON Amarelo.idEvento = Evento.idEvento
INNER JOIN Jogador
ON Jogador.idPessoa = Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
GROUP BY Pessoa.nome;
*/

/*
--Vermelhos
SELECT Pessoa.nome, count(Pessoa.nome)
FROM Vermelho INNER JOIN Evento
ON Vermelho.idEvento = Evento.idEvento
INNER JOIN Jogador
ON Jogador.idPessoa = Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
GROUP BY Pessoa.nome;
*/

SELECT Pessoa.nome, Amarelos.num as Amarelos, Vermelhos.num as Vermelhos
FROM Jogador, Pessoa,
(SELECT Pessoa.idPessoa as id, count (Pessoa.idPessoa) as num
  FROM Amarelo, Evento, Jogador, Pessoa
  WHERE (Amarelo.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa AND Jogador.idPessoa = Pessoa.idPessoa)
  GROUP BY Pessoa.idPessoa) Amarelos,
(SELECT Pessoa.idPessoa as id, count (Pessoa.idPessoa) as num
  FROM Vermelho, Evento, Jogador, Pessoa
  WHERE (Vermelho.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa AND Jogador.idPessoa = Pessoa.idPessoa)
  GROUP BY Pessoa.idPessoa) Vermelhos
WHERE (Jogador.idPessoa=Pessoa.idPessoa AND (Jogador.idPessoa = Amarelos.id OR Jogador.idPessoa = Vermelhos.id))
GROUP BY Pessoa.nome;
