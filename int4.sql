.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 4 - Equipa menos golos sofridos na historia da liga*/

/*
--Numero de golos sofridos em casa
SELECT Equipa.nome, sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Equipa LEFT OUTER JOIN Jogo
ON (Jogo.idEquipaCasa = Equipa.idEquipa)
GROUP BY Equipa.nome;
*/

/* Porque e' que isto n funca mas o de baixo funca ?
SELECT Equipa.idEquipa, Equipa.nome,
(SELECT sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Equipa LEFT OUTER JOIN Jogo
ON (Jogo.idEquipaCasa = Equipa.idEquipa)) Casa,
(SELECT sum(Jogo.golosFora) as Golos_sofridos_fora
FROM Equipa LEFT OUTER JOIN Jogo
ON (Jogo.idEquipaCasa = Equipa.idEquipa)) Fora
FROM Equipa;
*/

/*
SELECT Equipa.nome,
(SELECT sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Jogo
WHERE (Equipa.idEquipa = Jogo.idEquipaCasa)) Casa,
(SELECT sum(Jogo.golosFora) as Golos_sofridos_fora
FROM Jogo
WHERE (Equipa.idEquipa = Jogo.idEquipaCasa)) Fora,
FROM Equipa;
*/

SELECT Equipa.nome, Casa.Golos_sofridos_em_casa + Fora.Golos_sofridos_fora
FROM Equipa,
(SELECT Equipa.idEquipa as EquipaCasa, sum(Jogo.golosFora) as Golos_sofridos_em_casa
FROM Equipa, Jogo
WHERE (Equipa.idEquipa = Jogo.idEquipaCasa)
GROUP BY Equipa.idEquipa) Casa,
(SELECT Equipa.idEquipa as EquipaFora, sum(Jogo.golosFora) as Golos_sofridos_fora
FROM Equipa, Jogo
WHERE (Equipa.idEquipa = Jogo.idEquipaCasa)
GROUP BY Equipa.idEquipa) Fora
WHERE (Equipa.idEquipa = Fora.EquipaFora AND Equipa.idEquipa = Casa.EquipaCasa);
