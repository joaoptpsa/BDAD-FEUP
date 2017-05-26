INSERT INTO Amarelo values (5); --Rejeitado por ja haver algum evento com esse idEvento

--Verifica Amarelo_Already_Expelled
insert into Evento (idEvento, minuto, idEquipa, idJogador, idJogo) values (12, 91, 4, 4, 1); --Amarelo depois de ser expulso
INSERT INTO Amarelo values (12);

--Amarelo_To_Vermelho

insert into Evento (idEvento, minuto, idEquipa, idJogador, idJogo) values (13, 73, 12, 264, 1);
INSERT INTO Amarelo values (13);
