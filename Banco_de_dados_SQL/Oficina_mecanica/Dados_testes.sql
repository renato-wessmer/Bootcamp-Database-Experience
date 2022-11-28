use mydb;


insert into pessoa(nome,nmeio,sobrenome,cpf,rua,bairro,estado)
values("Alberto","Anjos","Anderson","111.111.111-11","Anis","Acácias","Abecásia"),
	  ("Bernardo","Bia","Boreaul","222.222.222-22","Budapeste","Babilônia","Brunei"),
      ("Caio","Carla","Castro","333.333.333-33","Coroa","Cabuçu","Chade"),
      ("Denis","Danny","Dorne","444.444.444-44","Diacomo","Dânfer","Djibouti"),
      ("Eva","Everdeen","ewerton","555.555.555-55","Eclair","Ede","Eswatini")
;

insert into cliente(pessoa_idpessoa) values(1),(2),(3);

insert into tecnico(especialidade,pessoa_idpessoa) values("mecanica",4);

insert into pagamento(formadepagamento,valor,data,cliente_idcliente)
values("pix",58.75,"2022-03-01",1),
	  ("credito",18560.43,"2021-05-04",2),
      ("debito",4550.99,"2028-07-04",3)
;
      
      



