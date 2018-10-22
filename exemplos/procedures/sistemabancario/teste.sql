call criar_conta("Daniel Filho",123,"1988-03-10");
call criar_conta("José Filho",321,"1980-03-10");

select * from conta;

call deposito(1,150);
call transferencia(1,2,100);