/* Dentro da relacao Jornada Para o mesmo idEpoca so podem haver 34 tuplos*/

CREATE TRIGGER IF NOT EXISTS NUM_ROUNDS
BEFORE INSERT ON Jornada
FOR EACH ROW --Already default
WHEN (
  (SELECT count (Jornada.idEpoca)
  FROM Jornada
  WHERE Jornada.idEpoca = new.idEpoca)>=34)
BEGIN
  SELECT RAISE(ABORT, 'So podem haver 34 jornadas numa Epoca');
END;
