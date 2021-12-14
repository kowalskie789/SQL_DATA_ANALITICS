-- wartość z przedziału (a, b)
-- rand() * (b-a) + a

DROP TABLE IF EXISTS randomizer;
CREATE TABLE randomizer (
    id INT,
    value FLOAT
);

drop procedure if exists fill_randomizer;

delimiter $$
create procedure fill_randomizer(in p_count int)
begin
    declare x float;
    declare i int default 0;

    while i < p_count do
        set x = rand();
        insert into randomizer(id, value)
        values (i, x);
        set i = i + 1;
    end while;
end; $$
delimiter ;

truncate table randomizer;

call fill_randomizer(1000);

select * from randomizer;