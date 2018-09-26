delimiter $$
create FUNCTION quanDiv(numero int)
returns integer
BEGIN
	DECLARE count int default 1;
    DECLARE quant int DEFAULT 0;
    WHILE count<=numero DO
   		if mod(numero,count) = 0 then
    		set quant = quant +1; -- 2
        end if;
    	set count = count +1; -- 3
    END WHILE;
    
    return quant;
end
$$