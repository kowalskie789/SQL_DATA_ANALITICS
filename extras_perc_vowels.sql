drop procedure if exists perc_vowels;

delimiter $$
create procedure perc_vowels()
begin
    declare finished boolean default false;
    declare vowels int default 0;
    declare letters int default 0;
    declare one_name varchar(90);
    declare i smallint;
    declare c char(1);

    declare actor_names cursor for
        select upper(replace(concat(first_name, last_name), ' ', ''))
        from actor;

    declare continue handler for not found set finished = true;

    open actor_names;
    actors: loop
        fetch actor_names into one_name;
        if finished then
            leave actors;
        end if;
        set i = 1;
        while i <= char_length(one_name) do
            set letters = letters + 1;
            set c = substring(one_name from i for 1);
            if c in ('A', 'E', 'I', 'O', 'U', 'Y') then
                set vowels = vowels + 1;
            end if;
            set i = i + 1;
        end while;
    end loop;
    close actor_names;
    select (vowels / letters) * 100;
end; $$
delimiter ;

call perc_vowels();


