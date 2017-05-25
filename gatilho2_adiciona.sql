/* Dentro da relacao Convocado, para o mesmo idJogo so podem haver 36 tuplos, 18 para cada idEquipa - para implementar falta povoar os contratos*/
CREATE TRIGGER IF NOT EXISTS Amarelo_Event_Refences_Limit
BEFORE INSERT ON Amarelo
FOR EACH ROW
WHEN (

)
BEGIN
SELECT RAISE(ABORT, 'Um evento só pode ser referenciado uma vez');
END;

SELECT sum (
CASE
WHEN (Golos.num IS NULL)
THEN 0
WHEN (Golos.num IS NOT NULL)
THEN Golos.num
WHEN (Amarelos.num IS NULL)
THEN 0
WHEN (Amarelos.num IS NOT NULL)
THEN Amarelos.num
WHEN (Vermelhos.num IS NULL)
THEN 0
WHEN (Vermelhos.num IS NOT NULL)
THEN Vermelhos.num
END ) AS NUM_EVENTOS
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
WHEN (SELECT count (Jogador.idPessoa)
  FROM Amarelo INNER JOIN Evento
  ON (Amarelo.idEvento = Evento.idEvento)
  INNER JOIN Jogo
  ON ((SELECT count (Jogador.idPessoa)
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
    GROUP BY (Jogador.idPessoa))>=1))
BEGIN
  SELECT RAISE(ABORT, 'O jogador já foi expulso deste jogo');
END;

CREATE TRIGGER IF NOT EXISTS Amarelo_To_Vermelho
BEFORE INSERT ON Amarelo
FOR EACH ROW --Already default
WHEN (((SELECT count (Jogador.idPessoa)
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
    GROUP BY (Jogador.idPessoa))>=1)
    AND
    (((SELECT count (Jogador.idPessoa)
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
    GROUP BY (Jogador.idPessoa))=0)>=1))
BEGIN
  INSERT INTO Vermelho values (new.idEvento);
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
