drop procedure if exists film_classification;

delimiter $$
create procedure film_classification (in film_length int, out category varchar(20))
begin
    if film_length <= 60 then
        set category = 'very short';
    elseif film_length <= 90 then set category = 'short';
    elseif film_length <= 120 then set category = 'normal';
    elseif film_length <= 150 then set category = 'long';
    else set category = 'very long';
    end if;
end; $$
delimiter ;


call film_classification(67, @c);
select @c;
call film_classification(155, @c);
select @c;
call film_classification(88, @c);
select @c;
call film_classification(100, @c);
select @c;



