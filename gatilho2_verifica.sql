--Amarelo_Event_Refences_Limit
SELECT * FROM Amarelo;

INSERT INTO Amarelo values (5); --Rejeitado por ja haver algum evento com esse idEvento

--Verifica Amarelo_Already_Expelled

insert into Evento (idEvento, minuto, idEquipa, idJogador, idJogo) values (64, 81, 11, 313, 6); --Amarelo depois de ser expulso
INSERT INTO Amarelo values (64);

SELECT * FROM Amarelo;
