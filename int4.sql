.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 4 - Equipa menos golos sofridos na historia da liga*/

/*
--Numero de golos sofridos em casa
SELECT Equipa.nome, sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Equipa INNER JOIN Jogo
ON (Jogo.idEquipaCasa = Equipa.idEquipa)
GROUP BY Equipa.nome;
*/

SELECT Equipa.nome, Casa.Golos_sofridos_em_casa + Fora.Golos_sofridos_fora AS Golos_Sofridos
FROM Equipa,
(SELECT Equipa.idEquipa as EquipaCasa, sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Equipa INNER JOIN Jogo
ON (Equipa.idEquipa = Jogo.idEquipaCasa)
GROUP BY Equipa.idEquipa) Casa,
(SELECT Equipa.idEquipa as EquipaFora, sum(Jogo.golosFora) as Golos_sofridos_fora
FROM Equipa INNER JOIN Jogo
ON (Equipa.idEquipa = Jogo.idEquipaCasa)
GROUP BY Equipa.idEquipa) Fora
WHERE (Equipa.idEquipa = Fora.EquipaFora AND Equipa.idEquipa = Casa.EquipaCasa);
