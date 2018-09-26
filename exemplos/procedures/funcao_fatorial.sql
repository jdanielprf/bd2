delimiter $$
create function fatorial(n1 int)
returns int
begin

	if n1 = 0 or n1 = 1 then
		return 1;
    else 
		return n1 * fatorial(n1-1);
    end if;
end $$;





