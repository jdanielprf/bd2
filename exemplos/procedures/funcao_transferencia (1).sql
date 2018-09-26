drop procedure if exists  sistemabancario.transferencia;
DELIMITER $$

create procedure sistemabancario.transferencia (IN val numeric(8,2)) 
begin
	declare saldoC1 numeric;
	declare saldoC2 numeric;
	
    select valor into saldoC1 from conta where numero =1;
	select valor into saldoC2 from conta where numero =2;
    if saldoC1 >= val then
		update conta set valor=saldoC1-val  where numero  =1;
		update conta set valor=saldoC2-val  where numero  =2;
        commit;
	else 
		rai
    end if;
    
end $$;

DELIMITER ;

call sistemabancario.transferencia(10);

select * from sistemabancario.conta;