/* Dentro da relacao Pessoa nao se pode acrescentar pessoas com data de nascimento para alem da data atual*/

CREATE TRIGGER IF NOT EXISTS Pessoa_Trigger
BEFORE INSERT ON Pessoa
FOR EACH ROW --Already default
WHEN (
  julianday(new.dataNascimento)>julianday('now')
)
BEGIN
  SELECT RAISE(ABORT, 'Não se pode acrescentar pessoas que ainda não nasceram');
END;
