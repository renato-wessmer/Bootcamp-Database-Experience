
-- simples SELECT
select * from pessoa;
select * from cliente;
select * from tecnico;
select * from pagamento;

-- where e select
UPDATE pessoa 
SET bairro = "Belize", rua = 'Bento'
WHERE idpessoa = 2;

select concat(nome,' ',sobrenome) as cliente, concat(rua,' ',bairro,' ',estado) as endereço
from pessoa where idpessoa; 

-- order by + expressoes

SELECT * FROM pessoa
ORDER BY nome,estado;

select concat(p.nome,' ',p.sobrenome) as Cliente,
	   concat(t.especialidade,' ',t.idtecnico) as função
       from pessoa as p, tecnico t
       where(p.idpessoa=t.pessoa_idpessoa)
       order by p.nome, t.especialidade;
       
-- having + group

select idpessoa, nome, sobrenome,count(*)
from pessoa,pagamento
where idpessoa = cliente_idcliente
group by idpessoa,nome,sobrenome
having count(*)=1;

-- join
SELECT concat(p.nome,' ', p.sobrenome) as Nome,
	   concat(p.rua,' ',p.bairro,' ',p.estado) as endereço,
       pg.formadepagamento,pg.valor,pg.data
FROM pessoa p
INNER JOIN pagamento pg ON p.idpessoa = pg.cliente_idcliente;