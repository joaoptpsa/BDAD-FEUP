/* Dentro da relacao Convocado, para o mesmo idJogo so podem haver 36 tuplos, 18 para cada idEquipa - para implementar falta povoar os contratos*/

CREATE TRIGGER IF NOT EXISTS Amarelo_Triggers
BEFORE INSERT ON Amarelo
FOR EACH ROW --Already default
BEGIN
  CASE
  WHEN ((SELECT count (Evento.idEvento)
  FROM Evento LEFT OUTER JOIN Amarelo
  ON (Evento.idEvento = Amarelo.idEvento)
  LEFT OUTER JOIN Vermelho
  ON (Evento.idEvento = Vermelho.idEvento)
  LEFT OUTER JOIN Golo
  ON (Evento.idEvento = Golo.idEvento)
  WHERE (Evento.idEvento = new.idEvento))>=1)
  THEN SELECT RAISE(ABORT, 'Um evento só pode ser referenciado uma vez');

  WHEN ((SELECT count (Jogador.idPessoa)
  FROM Amarelo INNER JOIN Evento
  ON (Amarelo.idEvento = Evento.idEvento)
  INNER JOIN Jogo
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo))=Jogo.idJogo)
  INNER JOIN Jogador
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa))=Jogador.idPessoa)
  GROUP BY (Jogador.idPessoa))>=1
  AND
  (SELECT count (Jogador.idPessoa)
  FROM Vermelho INNER JOIN Evento
  ON (Vermelho.idEvento = Evento.idEvento)
  INNER JOIN Jogo
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo))=Jogo.idJogo)
  INNER JOIN Jogador
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa))=Jogador.idPessoa)
  GROUP BY (Jogador.idPessoa))=0)
  THEN INSERT INTO Vermelho (idEvento) values (new.idEvento);

  WHEN ((SELECT count (Jogador.idPessoa)
  FROM Amarelo INNER JOIN Evento
  ON (Amarelo.idEvento = Evento.idEvento)
  INNER JOIN Jogo
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo))=Jogo.idJogo)
  INNER JOIN Jogador
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa))=Jogador.idPessoa)
  GROUP BY (Jogador.idPessoa))>=1
  AND
  (SELECT count (Jogador.idPessoa)
  FROM Vermelho INNER JOIN Evento
  ON (Vermelho.idEvento = Evento.idEvento)
  INNER JOIN Jogo
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo))=Jogo.idJogo)
  INNER JOIN Jogador
  ON ((SELECT Jogo.idJogo
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa))=Jogador.idPessoa)
  GROUP BY (Jogador.idPessoa))>=1)
  THEN SELECT RAISE(ABORT, 'O jogador já foi expulso deste jogo');
  END
END;

--Obter o numero de Amarelos no jogo para o jogador qual estamos a acrescentar um Amarelo
/*
SELECT count (Jogador.idPessoa)
FROM Amarelo INNER JOIN Evento
ON (Amarelo.idEvento = Evento.idEvento)
INNER JOIN Jogo
ON ((SELECT Jogo.idJogo
FROM Evento INNER JOIN Jogo
ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo))=Jogo.idJogo)
INNER JOIN Jogador
ON ((SELECT Jogo.idJogo
FROM Evento INNER JOIN Jogador
ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa))=Jogador.idPessoa)
GROUP BY (Jogador.idPessoa);
*/

--Obter o numero de vezes que um evento e referenciado por qualquer
/*
SELECT count (Evento.idEvento)
FROM Evento LEFT OUTER JOIN Amarelo
ON (Evento.idEvento = Amarelo.idEvento)
LEFT OUTER JOIN Vermelho
ON (Evento.idEvento = Vermelho.idEvento)
LEFT OUTER JOIN Golo
ON (Evento.idEvento = Golo.idEvento)
WHERE (Evento.idEvento = new.idEvento)
*/
