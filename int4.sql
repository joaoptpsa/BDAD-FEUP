.mode columns
.headers on
.nullvalue NULL

.width 15 15
/*INTERROGACAO 4 - Equipa menos golos sofridos na Epoca 2016/2017 da liga*/

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

SELECT Equipa.nome, Casa.Golos_sofridos_em_casa + Fora.Golos_sofridos_fora AS Golos_Sofridos
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
WHERE (Equipa.idEquipa = Fora.EquipaFora AND Equipa.idEquipa = Casa.EquipaCasa);
