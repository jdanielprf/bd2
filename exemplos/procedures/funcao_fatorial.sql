delimiter $$
create function fatorial(n int)
returns int
begin
	declare c int default 1;
	declare fat int default 1;
	while c<=n do
		set fat= fat*c;
		set c = c + 1;
	end while;
	return fat;
end 
$$;





