/* Dentro da relacao Convocado, para o mesmo idJogo so podem haver 36 tuplos, 18 para cada idEquipa - para implementar falta povoar os contratos*/
CREATE TRIGGER IF NOT EXISTS Amarelo_Event_Refences_Limit
BEFORE INSERT ON Amarelo
FOR EACH ROW
WHEN (

)
BEGIN
SELECT RAISE(ABORT, 'Um evento só pode ser referenciado uma vez');
END;

SELECT Golos.num, Amarelos.num, Vermelhos.num
FROM (SELECT COUNT(*) as num
FROM Evento INNER JOIN Amarelo
ON (Evento.idEvento=Amarelo.idEvento AND Evento.idEvento=3)
GROUP BY Evento.idEvento) Amarelos,
(SELECT COUNT(*) as num
FROM Evento INNER JOIN Vermelho
ON (Evento.idEvento=Vermelho.idEvento AND Evento.idEvento=3)
GROUP BY Evento.idEvento) Vermelhos,
(SELECT COUNT(*) as num
FROM Evento INNER JOIN Golo
ON (Evento.idEvento=Golo.idEvento AND Evento.idEvento=3)
GROUP BY Evento.idEvento) Golos

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
WHEN ((SELECT count (Jogador.idPessoa)
  FROM Jogo INNER JOIN Evento
  ON ((SELECT MAX(Jogo.idJogo)
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
  GROUP BY Jogo.idJogo)=Jogo.idJogo)
  INNER JOIN Jogador
  ON ((SELECT MAX(Jogador.idPessoa)
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
  GROUP BY Jogador.idPessoa)=Jogador.idPessoa)
  INNER JOIN Vermelho
  ON (Evento.idEvento = Vermelho.idEvento)
  GROUP BY (Jogador.idPessoa))>=1)
BEGIN
  SELECT RAISE(ABORT, 'O jogador já foi expulso deste jogo');
END;

CREATE TRIGGER IF NOT EXISTS Amarelo_To_Vermelho
BEFORE INSERT ON Amarelo
FOR EACH ROW --Already default
WHEN (((SELECT count (Jogador.idPessoa)
  FROM Jogo INNER JOIN Evento
  ON ((SELECT MAX(Jogo.idJogo)
  FROM Evento INNER JOIN Jogo
  ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
  GROUP BY Jogo.idJogo)=Jogo.idJogo)
  INNER JOIN Jogador
  ON ((SELECT MAX(Jogador.idPessoa)
  FROM Evento INNER JOIN Jogador
  ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
  GROUP BY Jogador.idPessoa)=Jogador.idPessoa)
  INNER JOIN Vermelho
  ON (Evento.idEvento = Vermelho.idEvento)
  GROUP BY (Jogador.idPessoa))>=1)
  AND
  ((SELECT count (Jogador.idPessoa)
    FROM Jogo INNER JOIN Evento
    ON ((SELECT MAX(Jogo.idJogo)
    FROM Evento INNER JOIN Jogo
    ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
    GROUP BY Jogo.idJogo)=Jogo.idJogo)
    INNER JOIN Jogador
    ON ((SELECT MAX(Jogador.idPessoa)
    FROM Evento INNER JOIN Jogador
    ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
    GROUP BY Jogador.idPessoa)=Jogador.idPessoa)
    INNER JOIN Amarelo
    ON (Evento.idEvento = Amarelo.idEvento)
    GROUP BY (Jogador.idPessoa)) IS NULL))
BEGIN
  INSERT INTO Vermelho values (new.idEvento);
END;


            --Obter o numero de Amarelos no jogo para o jogador qual estamos a acrescentar um Amarelo
            /*
            SELECT count (Jogador.idPessoa)
              FROM Jogo INNER JOIN Evento
              ON ((SELECT MAX(Jogo.idJogo)
              FROM Evento INNER JOIN Jogo
              ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
              GROUP BY Jogo.idJogo)=Jogo.idJogo)
              INNER JOIN Jogador
              ON ((SELECT MAX(Jogador.idPessoa)
              FROM Evento INNER JOIN Jogador
              ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
              GROUP BY Jogador.idPessoa)=Jogador.idPessoa)
              INNER JOIN Amarelo
              ON (Evento.idEvento = Amarelo.idEvento)
              GROUP BY (Jogador.idPessoa)
            */

            --Obter o numero de Vermelhos no jogo para o jogador qual estamos a acrescentar um Amarelo
            /*
            SELECT count (Jogador.idPessoa)
              FROM Jogo INNER JOIN Evento
              ON ((SELECT MAX(Jogo.idJogo)
              FROM Evento INNER JOIN Jogo
              ON (new.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo)
              GROUP BY Jogo.idJogo)=Jogo.idJogo)
              INNER JOIN Jogador
              ON ((SELECT MAX(Jogador.idPessoa)
              FROM Evento INNER JOIN Jogador
              ON (new.idEvento = Evento.idEvento AND Evento.idJogador = Jogador.idPessoa)
              GROUP BY Jogador.idPessoa)=Jogador.idPessoa)
              INNER JOIN Vermelho
              ON (Evento.idEvento = Vermelho.idEvento)
              GROUP BY (Jogador.idPessoa)
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
