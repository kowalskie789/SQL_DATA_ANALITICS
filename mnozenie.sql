drop procedure if exists multiples;

delimiter $$
create procedure multiples(in podstawa int, in liczba_elementow int)
begin
    declare result varchar(500) default '';
    declare cnt int;

    set cnt = 0;
    repeat
        set cnt = cnt + 1;
        set result = concat(result, podstawa * cnt, ',');
    until cnt = liczba_elementow end repeat;

    select substring(result from 1 for char_length(result) - 1);
end; $$
delimiter ;

call multiples(10, 12);