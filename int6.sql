.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 6 - Classificacao Epoca 2016/2017*/
--Sabemos que o idEpoca = 1

SELECT Equipa.nome, sum (
CASE 
WHEN ((Jogo.idEquipaCasa=Equipa.idEquipa) AND (Jogo.golosCasa-Jogo.golosFora)>0)
THEN 3
WHEN ((Jogo.idEquipaCasa=Equipa.idEquipa) AND (Jogo.golosCasa-Jogo.golosFora)=0)
THEN 1
WHEN ((Jogo.idEquipaCasa=Equipa.idEquipa) AND (Jogo.golosCasa-Jogo.golosFora)<0)
THEN 0
WHEN ((Jogo.idEquipaFora=Equipa.idEquipa) AND (Jogo.golosFora-Jogo.golosCasa)>0)
THEN 3
WHEN ((Jogo.idEquipaFora=Equipa.idEquipa) AND (Jogo.golosFora-Jogo.golosCasa)=0)
THEN 1
WHEN ((Jogo.idEquipaFora=Equipa.idEquipa) AND (Jogo.golosFora-Jogo.golosCasa)<0)
THEN 0
END )Pontos
FROM Jogo INNER JOIN Jornada
ON ((Jornada.idEpoca=1) AND (Jogo.idJornada=Jornada.idJornada))
INNER JOIN Equipa
ON (Jogo.idEquipaCasa=Equipa.idEquipa OR Jogo.idEquipaFora=Equipa.idEquipa)
GROUP BY Equipa.idEquipa
ORDER BY Pontos DESC;
