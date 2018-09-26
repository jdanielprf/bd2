-- drop function if exists primo;
DELIMITER $$
create FUNCTION positivo(numero int)
returns boolean
BEGIN
	return numero>0;
end

$$