# Procedure: get shop managed by a user
drop procedure if exists get_shops_managed_by_user;
delimiter //
create procedure get_shops_managed_by_user (in _user_id int)
begin
	select owner.username as username, owner.fullname as owner_name, s.shop_name as shop_name, s.create_date as create_date, ums.start_date as start_date
    from the_user as u, user_manage_shop as ums, shop as s, the_user as owner
    where u.user_id = _user_id and u.user_id = ums.user_id and ums.shop_id = s.shop_id and s.shop_owner = owner.user_id
    order by start_date;
end //
delimiter ;


# Function: Calculate the total money spent by a user
drop function if exists get_total_money_spent;
delimiter //
create function get_total_money_spent(_user_id integer)
returns integer
deterministic
begin

	declare done bool default false;
	declare total_money int default 0;
    declare price, amt int;
    declare cur cursor for 
        select selling_price, amount 
        from order_contains_product as ocp, order_detail as od
        where user_id = _user_id and ocp.order_id  = od.order_id;
    declare continue handler for not found set done = true;
    
	if not exists (select * from the_user where user_id = _user_id) then
		signal sqlstate '45000' 
			set message_text = 'Cannot found a user';
	end if;
    
    open cur;
    
    read_loop: loop
		fetch cur into price, amt;
		if done then 
			leave read_loop;
		end if;
		set total_money = total_money + price * amt;
    end loop;
    close cur;
    return total_money;
end //
delimiter ;


# Procedure: get shops information and number of its manager
drop procedure if exists get_shop_manager_count;
delimiter //
create procedure get_shop_manager_count (in min_count integer) 
begin
	select s.shop_id, s.shop_name as Shop_Name, s.create_date as Date_Created, count(*) as Number_of_Managers
    from shop as s, user_mange_shop as ums
    where s.shop_id = ums.shop_id
    group by s.shop_id
    having count(*) >= min_count
    order by count(*);
end //
delimiter ;


# Function: Determine membership of a buyer
drop function if exists get_buyer_membership;
delimiter //
create function get_buyer_membership (_user_id integer)
returns varchar(8)
deterministic
begin
	declare cur_year int default year(curdate());
    declare order_cnt int default 0;
    declare membership varchar(8) default 'Bronze';
    
    set order_cnt = (select count(*) from order_detail 
						where user_id = _user_id and year(create_date) = cur_year);
	if order_cnt < 30 then
		set membership = 'Silver';
	elseif order_cnt >= 30 and order_cnt < 50 then
		set membership = 'Gold';
	else 
		set membership = 'Platinum';
    end if;
    return membership;
end //
delimiter ;


# Procedure: get number of orders of all users
drop procedure if exists get_user_statistics;
delimiter //
create procedure get_user_statistics (in min_count int)
begin
    select u.user_id as user_id, u.username as username, u.fullname as fullname, 
        count(*) as order_count, get_total_money_spent(u.user_id) as total_money, get_buyer_membership(u.user_id) as membership
    from the_user as u, order_detail as od
    where u.user_id = od.user_id
    group by u.user_id
    having count(*) >= min_count
    order by count(*) DESC, u.user_id;
end //
delimiter ;


# Procedure: update information of a user
drop procedure if exists update_user_info;
delimiter //
create procedure update_user_info (
    in _user_id integer, 
    in _mobile varchar(12),
    in _email varchar(12), 
    in _fullname varchar(50),
    in _sex char(1),
    in _dob date,
    in _avatar varchar(64),
    in _seller_flag boolean,
    in _buyer_flag boolean
)
begin
    update the_user
    set mobile = _mobile, email = _email, fullname = _fullname, sex = _sex, dob = _dob, avatar = _avatar, seller_flag = _seller_flag, buyer_flag = _buyer_flag
    where user_id = _user_id;
end //
delimiter ;