.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 6 - TOP 10 Jogadores com mais minutos*/

--Nao sabemos a duracao dos jogos e qualquer operacao de soma com null da null '''''''''''''''''WHAT DO?!?
--Solucoes:
--Considerar x tempo caso minutoSaida == null
--Adicionar campo duracao em cada Jogo
SELECT Pessoa.nome, sum (Convocado.minutoSaida - Convocado.minutoEntrada) as tempoJogado
FROM Convocado INNER JOIN Jogador
ON Convocado.idJogador=Jogador.idPessoa
INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
ORDER BY tempoJogado DESC LIMIT 10;
