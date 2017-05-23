.mode columns
.headers on
.nullvalue NULL

.width 20 6

/*INTERROGACAO 3 - Paises mais representados na liga*/

SELECT Pais.nome, count(Pais.nome) as num
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
INNER JOIN Cidade
ON Pessoa.idCidadeNasc = Cidade.idCidade
INNER JOIN Pais
ON Cidade.idPais=Pais.idPais
GROUP BY Pais.nome
ORDER BY num DESC;
