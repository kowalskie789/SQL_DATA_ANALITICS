drop procedure if exists newsletter;

delimiter $$
create procedure newsletter(out p_emails text)
begin
    declare finished boolean default false;
    declare c_email varchar(50);

    declare cur_emails cursor for
    select distinct c.email
    from
     customer c inner join address a on (
         c.address_id = a.address_id
         and a.district = 'Buenos Aires'
         and c.active = 1
    );
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = true;

    open cur_emails;
    set p_emails = '';

    emails: loop
        fetch cur_emails into c_email;
        if finished then
            leave emails;
        end if;
        set p_emails = concat(p_emails, ';', c_email);
    end loop;

    close cur_emails;
    set p_emails = substring(p_emails from 2);
end; $$
delimiter ;

call newsletter(@emails);

select @emails;


