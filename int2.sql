.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 2 - Melhores marcardores*/

SELECT idJogador FROM Evento
INTERSECT
SELECT idPessoa FROM Jogador;
