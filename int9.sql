.mode columns
.headers on
.nullvalue NULL

/*INTERROGACAO 9 - Top 5 clubes mais velhos*/

SELECT nome, dataFundacao
FROM Equipa
ORDER BY dataFundacao ASC LIMIT 5;
