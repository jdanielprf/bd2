-- drop function if exists primo;
DELIMITER $$
create function primo(n integer) returns varchar(100)
begin 
	declare cont int;
    set cont =2;
	if n = 1 then 
		return "nao e primo";
	end if;
    while cont<n do
		if mod(n,cont) = 0 then
			return "nao e primo";
        end if;
    end while;
	return "primo";


end $$;

DELIMITER;