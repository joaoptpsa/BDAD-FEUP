/* Dentro da relacao Convocado, para o mesmo idJogo so podem haver 36 tuplos, 18 para cada idEquipa - para implementar falta povoar os contratos*/

CREATE TRIGGER IF NOT EXISTS Convocado_Trigger
BEFORE INSERT ON Convocado
FOR EACH ROW --Already default
WHEN (
  (SELECT count (Convocado.idJogo)
  FROM Convocado
  WHERE Convocado.idJogo = new.idJogo)>=36
  OR
  (SELECT *
  FROM ContratoJogador INNER JOIN Contrato
  ON (ContratoJogador.idContrato = Contrato.idContrato)
  INNER JOIN Jogo
  ON (julianday(Contrato.dataInicio)<= julianday(Jogo.Data) AND julianday(Jogo.Data)>=julianday(Contrato.dataFim))
  )
)
BEGIN
  SELECT RAISE(ABORT, 'So podem haver 34 jornadas numa Epoca');
END;

/*
SELECT Contrato.idJogo
FROM Contrato INNER JOIN Jogo
ON (julianday(Contrato.dataInicio)<= julianday(Jogo.Data) AND julianday(Jogo.Data)>=julianday(Contrato.dataFim))
*/
