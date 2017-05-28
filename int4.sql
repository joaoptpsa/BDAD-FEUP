.mode columns
.headers on
.nullvalue NULL

.width 15 15
/*INTERROGACAO 4 - Equipa menos golos sofridos na Epoca 2016/2017 da liga*/
--Sabemos que o idEpoca = 1

/*
--Numero de golos sofridos em casa
SELECT Equipa.idEquipa as EquipaCasa, sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Equipa
ON (Jogo.idEquipaCasa = Equipa.idEquipa)
GROUP BY Equipa.idEquipa;

--Fora
SELECT Equipa.idEquipa as EquipaFora, sum(Jogo.golosCasa) as Golos_sofridos_fora
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Equipa
ON (Jogo.idEquipaFora = Equipa.idEquipa)
GROUP BY Equipa.idEquipa;
*/

SELECT Equipa.nome,
CASE
WHEN Equipa.idEquipa = Casa.EquipaCasa AND Equipa.idEquipa = Fora.EquipaFora
THEN Casa.Golos_sofridos_em_casa + Fora.Golos_sofridos_fora
WHEN Equipa.idEquipa = Casa.EquipaCasa
THEN Casa.Golos_sofridos_em_casa
WHEN Equipa.idEquipa = Fora.EquipaFora
THEN Fora.Golos_sofridos_fora
ELSE 0
END Golos_Sofridos
FROM Equipa,
(SELECT Equipa.idEquipa as EquipaCasa, sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Equipa
ON (Jogo.idEquipaCasa = Equipa.idEquipa)
GROUP BY Equipa.idEquipa) Casa,
(SELECT Equipa.idEquipa as EquipaFora, sum(Jogo.golosCasa) as Golos_sofridos_fora
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Equipa
ON (Jogo.idEquipaFora = Equipa.idEquipa)
GROUP BY Equipa.idEquipa) Fora
WHERE (Equipa.idEquipa = Fora.EquipaFora OR Equipa.idEquipa = Casa.EquipaCasa)
GROUP BY Equipa.idEquipa
ORDER BY Golos_Sofridos DESC;
