.mode columns
.headers on
.nullvalue NULL

.width 25 10
/*INTERROGACAO 9 - Média de Idades por Equipa nos jogadores das equipas vinculados no dia 02/04/2017*/


SELECT Equipa.nome, printf("%.2f",AVG(strftime('%Y', 'now')-strftime ('%Y', Pessoa.dataNascimento))) as Idade
FROM ContratoJogador INNER JOIN Contrato
ON (ContratoJogador.idContrato = Contrato.idContrato AND julianday('2017-04-02')<= julianday(Contrato.dataFim) AND julianday ('2017-04-02') >= julianday(Contrato.dataInicio)),
Pessoa INNER JOIN Equipa
ON (ContratoJogador.idJogador = Pessoa.idPessoa AND ContratoJogador.idEquipa = Equipa.idEquipa)
GROUP BY Equipa.idEquipa
ORDER BY Idade ASC;
