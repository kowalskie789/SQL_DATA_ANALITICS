drop procedure if exists film_rental_2;

delimiter $$
create procedure film_rental_2(in p_film_id int)
begin
    declare rent_status varchar(20);
    declare remaining_stock int;
    start transaction;

    update stock_part_1
    set stock = stock - 1
    where film_id = p_film_id and stock > 0;

    if row_count() > 0 then
        set rent_status = 'wypożyczono';
        commit;
    else
        set rent_status = 'brak w magazynie';
        rollback;
    end if;

    select stock
    into remaining_stock
    from stock_part_1
    where film_id = p_film_id limit 1;

    select rent_status, remaining_stock;
end; $$

delimiter ;

call film_rental_2(4);



