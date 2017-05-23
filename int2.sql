.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 2 - Melhores marcardores*/

SELECT Pessoa.nome, count(Pessoa.nome)
FROM Golo INNER JOIN Evento
ON Golo.idEvento = Evento.idEvento
INNER JOIN Jogador
ON Jogador.idPessoa = Evento.idJogador
INNER JOIN Pessoa
ON Pessoa.idPessoa=Jogador.idPessoa
GROUP BY Pessoa.nome;
