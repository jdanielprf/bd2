drop database if exists  banco;
create database if not exists banco;
use banco;
create table conta(
	numero int primary key auto_increment,
	saldo numeric(11,2) not null default 0,
    nome varchar(200),
    cpf numeric(11) not null,
    dataNascimento date not null,
    lastUpdate TIMESTAMP default CURRENT_TIMESTAMP
) engine = INNODB;

create table historico(
	numero int references conta(numero),
    saldoAnterior numeric(11,2) not null,
    saldoAtual numeric(11,2) not null,
	operacao enum('transferencia','saque','deposito'),
	dataOperacao timestamp default CURRENT_TIMESTAMP
) engine = INNODB;

DELIMITER //

create procedure criar_conta(nome varchar(200), cpf numeric(11), dataNascimento date)
begin
	insert into conta(nome,cpf,dataNascimento) values(nome,cpf,dataNascimento);
end
//

drop procedure if exists transferencia;
DELIMITER //
create procedure transferencia(conta1 int, conta2 int, valor numeric(8,2))
begin
	declare saldoC1 numeric(8,2);
    declare quantidade integer default null;
    start transaction;
    select count(0) into quantidade from conta where  numero=conta1;
    if quantidade != 1 then
		SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Conta nao existe', MYSQL_ERRNO = 69;
	else
    
			select saldo into saldoC1 from conta where numero=conta1;
			
			if saldoC1>=valor then
				update conta set saldo=saldo-valor  where numero=conta1;
				update conta set saldo=saldo+valor  where numero=conta2;
		        insert into historico (numero,saldoAnterior,saldoAtual,operacao) values(conta1,saldoC1,saldoC1+valor,'transferencia');
				commit;
			else 
				rollback;
				SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Saldo Insuficiente', MYSQL_ERRNO = 666;
			end if;
			
    end if;
    
    
	
end
//

DELIMITER //
create procedure saque(conta1 int, valor numeric(8,2))
begin
end;
//

DELIMITER //
create procedure deposito(conta1 int, valor numeric(8,2))
begin
	declare quantidade int;
    declare saldoc1 numeric(8,2);
    start transaction;
	select count(0) into quantidade from conta where numero=conta1;
    if quantidade != 1 then
		SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Conta nao existe', MYSQL_ERRNO = 69;
    else
		select saldo into saldoc1 from conta where numero=conta1;
		update conta set saldo=saldo+valor where numero=conta1;
        insert into historico (numero,saldoAtual,saldoAnterior,operacao)
			values(conta1,saldoc1+valor,saldoc1,'deposito');
		commit;
	end if;
end;
//


