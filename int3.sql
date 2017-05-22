.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 3 - Paises mais representados na liga*/

SELECT Pais.nome, count(Pais.nome)
FROM Jogador INNER JOIN Pessoa
ON Jogador.idPessoa=Pessoa.idPessoa
INNER JOIN Cidade
ON Pessoa.idCidadeNasc = Cidade.idCidade
INNER JOIN Pais
ON Cidade.idPais=Pais.idPais
GROUP BY Pais.nome;
