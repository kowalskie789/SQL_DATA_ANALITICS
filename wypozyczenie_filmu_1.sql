drop procedure if exists film_rental;

delimiter $$
create procedure film_rental(in p_film_id int)
begin
    start transaction;

    update stock_part_1
    set stock = stock - 1
    where film_id = p_film_id and stock > 0;

    if row_count() > 0 then
        select 'wypożyczono';
        commit;
    else
        select 'brak w magazynie';
        rollback;
    end if;
end; $$

delimiter ;

call film_rental(3);



