/* Dentro da relacao Convocado, para o mesmo idJogo so podem haver 36 tuplos, 18 para cada idEquipa - para implementar falta povoar os contratos*/
CREATE TRIGGER IF NOT EXISTS Amarelo_Event_Refences_Limit
BEFORE INSERT ON Amarelo
FOR EACH ROW
WHEN (((SELECT COUNT(*) as num
FROM Evento INNER JOIN Amarelo
ON (Evento.idEvento=Amarelo.idEvento AND Evento.idEvento=3)
GROUP BY Evento.idEvento)!=0)
OR
((SELECT COUNT(*) as num
FROM Evento INNER JOIN Vermelho
ON (Evento.idEvento=Vermelho.idEvento AND Evento.idEvento=3)
GROUP BY Evento.idEvento)!=0)
OR
((SELECT COUNT(*) as num
FROM Evento INNER JOIN Golo
ON (Evento.idEvento=Golo.idEvento AND Evento.idEvento=3)
GROUP BY Evento.idEvento)!=0)
)
BEGIN
SELECT RAISE(ABORT, 'Um evento só pode ser referenciado uma vez');
END;

/*
SELECT Evento.idEvento
FROM Evento INNER JOIN Amarelo
ON (Evento.idEvento=Amarelo.idEvento AND Evento.idEvento=new.idEvento)
GROUP BY Evento.idEvento

SELECT Evento.idEvento
FROM Evento INNER JOIN Vermelho
ON (Evento.idEvento=Vermelho.idEvento AND Evento.idEvento=new.idEvento)
GROUP BY Evento.idEvento

SELECT Evento.idEvento
FROM Evento INNER JOIN Golo
ON (Evento.idEvento=Golo.idEvento AND Evento.idEvento=new.idEvento)
GROUP BY Evento.idEvento
*/

CREATE TRIGGER IF NOT EXISTS Amarelo_Already_Expelled
BEFORE INSERT ON Amarelo
FOR EACH ROW
WHEN ((SELECT count (Evento.idJogador)
  FROM Evento INNER JOIN Vermelho
  ON ((SELECT MAX(Jogo.idJogo)
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
  GROUP BY Jogo.idJogo)=Evento.idJogo
  AND
  (SELECT MAX(Jogador.idPessoa)
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
  GROUP BY Jogador.idPessoa)=Evento.idJogador
  AND
  Evento.idEvento=Vermelho.idEvento))>=1)
BEGIN
  SELECT RAISE(ABORT, 'O jogador já foi expulso deste jogo');
END;


            --Obter o numero de Vermelhos no jogo para o jogador qual estamos a acrescentar um Amarelo
            /*
            SELECT count (Evento.idJogador)
              FROM Evento INNER JOIN Vermelho
              ON ((SELECT MAX(Jogo.idJogo)
              FROM Evento INNER JOIN Jogo
              ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
              GROUP BY Jogo.idJogo)=Evento.idJogo
              AND
              (SELECT MAX(Jogador.idPessoa)
              FROM Evento INNER JOIN Jogador
              ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
              GROUP BY Jogador.idPessoa)=Evento.idJogador
              AND
              Evento.idEvento=Vermelho.idEvento)
            */

            --Obter o numero de Amarelos no jogo para o jogador qual estamos a acrescentar um Amarelo
            /*
            SELECT count (Evento.idJogador)
              FROM Evento INNER JOIN Amarelo
              ON ((SELECT MAX(Jogo.idJogo)
              FROM Evento INNER JOIN Jogo
              ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
              GROUP BY Jogo.idJogo)=Evento.idJogo
              AND
              (SELECT MAX(Jogador.idPessoa)
              FROM Evento INNER JOIN Jogador
              ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
              GROUP BY Jogador.idPessoa)=Evento.idJogador
              AND
              Evento.idEvento=Vermelho.idEvento)
              */
