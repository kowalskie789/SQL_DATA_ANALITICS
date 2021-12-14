drop procedure if exists film_rental_3;

delimiter $$
create procedure film_rental_3(in p_film_id int, in p_store_id int)
begin
    declare rem int;

    start transaction;

    delete from stock_part_2
    where store_id = p_store_id and film_id = p_film_id
    limit 1;

    if row_count() > 0 then
        select count(*)
        into rem
        from stock_part_2
        where film_id = p_film_id and store_id = p_store_id;

        select 'wypożyczono', rem;
        commit;
    else
        select 'brak w magazynie', store_id, count(*) as available
        from stock_part_2
        where film_id = p_film_id
        group by 1, 2
        having count(*) > 0;

        rollback;
    end if;
end; $$
delimiter ;

call film_rental_3(16, 1);