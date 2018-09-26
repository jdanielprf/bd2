use sistemabancario;
create table cliente
	(cpf int primary key, nome varchar(200))
engine INNODB;

create table conta
	(numero int primary key, valor numeric(8,2), 
    fk_cliente int  references cliente(cpf) )
engine INNODB;


insert into cliente values(1,'Daniel');
insert into cliente values(2,'Jose');

insert into conta values(01,100,1);
insert into conta values(02,200,2);
------------------------
	set @val = 100;

    select @saldoC1:=valor from conta where numero =1;
	select @saldoC2:=valor from conta where numero =2;

	update conta set valor= @saldoC1-@val where numero =1;
	update conta set valor= @saldoC2+@val where numero =2;


	commit;
---------------------------
