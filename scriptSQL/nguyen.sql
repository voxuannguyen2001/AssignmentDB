-- Run this script once every git pull

use e_commerce;

-- table user 
drop table if exists user;
create table user(
	user_id integer not null auto_increment,
    username varchar(30) not null,
    pass varchar(50) not null,
    mobile varchar(16),
    email varchar(50),
    fullname varchar(50) not null ,
    sex char(1),
    dob date,
    avatar varchar(64),
    seller_flag boolean,
    buyer_flag boolean,
    date_created date not null,
    primary key(user_id)
);


-- table order contains_product
drop table if exists order_contains_product;
create table order_contains_product(
	shop_id integer not null,
    product_id integer not null,
    order_id integer not null,
    amount integer not null default 1,
    selling_price integer not null,
    primary key(shop_id, product_id, order_id)
);


-- procedure: insert to user procedure with input validation
drop procedure if exists add_user;
delimiter //
create procedure add_user (
	in username varchar(30), 
    in pass varchar(50),
    in mobile varchar(12),
    in email varchar(50),
    in fullname varchar(50),
    in sex char(1),
    in dob date,
	in avatar varchar(64),
    in seller_flag boolean,
    in buyer_flag boolean
)

begin
	if not regexp_like(username, '^[a-z0-9_.]*$') then
		signal sqlstate '45000' 
			set message_text = 'username can only contains lowercase characters, numbers, dot(.) and underscore(_)';
    end if;
    
    if char_length(username) < 6 or char_length(username) > 30 then 
		signal sqlstate '45000' 
			set message_text = 'username\'s length must be between 6 and 30';
    end if;
    
    if char_length(pass) < 8 then 
		signal sqlstate '45000'
			set message_text = 'password\'s length must be at least 8 characters';
    end if;
    
    if not regexp_like(mobile, '^[0-9]*$') then
		signal sqlstate '45000'
			set message_text = 'mobile number can only contains numbers';
	end if;
    
    if not regexp_like(email, '@.*\.') then
		signal sqlstate '45000'
			set message_text = 'email is not valid';
    end if;
    
	insert into user (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag)
		values (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag);
end//
delimiter ;


# Trigger: when create a new shop. Change the shop owner's seller_flag to true and insert (user_id, shop_id) into table user_manage_shop
drop trigger if exists on_create_shop;
delimiter //
create trigger on_create_shop after insert on shop
for each row
begin
	set @found_user = (select count(*) from user where id = new.shop_owner);
    if @found_user = 0 then
		signal sqlstate '45000' set message_text = 'shop_owner not found';
	end if;
	update user set seller_flag = true 
	where user_id = new.shop_owner;
    insert into user_manage_shop values(shop_owner, new.shop_id);
end;//
delimiter ;


# Trigger: before inserting a new user, assign date_created to current date if it is null
drop trigger if exists on_create_user;
delimiter //
create trigger on_create_user before insert on user
for each row
if (isnull(new.date_created)) then
	set new.date_created = curdate();
end if;
//
delimiter ;


# Procedure: get shop owned by a user
drop procedure if exists get_shop_owned_by_user
delimiter //
create procedure get_shop_owned_by_user (in _username varchar(30))
begin
	select username, fullname, shop_id, shop_name, create_date 
    from user, shop
    where username = _username and user_id = shop_owner;
end //
delimiter ;


# Function: Calculate the total price of an order
drop function if exists get_total_price;
delimiter //
create function get_total_price(_order_id integer)
returns integer
deterministic
begin

	declare done bool default false;
	declare total_price int default 0;
    declare price, amt int;
    declare cur cursor for select selling_price, amount from order_contains_product where order_id = _order_id;
    declare continue handler for not found set done = true;
    
	if not exists (select count(*) from order_detail where order_id = _order_id) then
		signal sqlstate '45000' 
			set message_text = 'Cannot found an order with order_id';
	end if;
    
    open cur;
    
    read_loop: loop
		fetch cur into price, amt;
		if done then 
			leave read_loop;
		end if;
		set total_price = total_price + price * amt;
    end loop;
    close cur;
    return total_price;
end //
delimiter ;


# Procedure: get order ids of a user
drop procedure if exists get_order_details_of_user;
delimiter //
create procedure get_order_details_of_user (in name varchar(30))
begin
	select od.order_id as Order_Id, (select(get_total_price(od.order_id))) as Total_Price, od.create_date as Date_Created,
		count(*) as Number_of_products
    from user as u, order_detail as od
    where u.username = name and u.user_id = od.user_id
    group by od.order_id
    order by od.create_date;
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
	if order_cnt >= 10 and order_cnt < 30 then
		set membership = 'Silver';
	elseif order_cnt >= 30 and order_cnt < 50 then
		set membership = 'Gold';
	else 
		set membership = 'Platinum';
    end if;
    return membership;
end //
delimiter ;




-- insert data to user
call add_user (
'voxuannguyen2001',
'12345678',
'0397003301',
'voxuannguyen2001@gmail.com',
'Vo Trinh Xuan Nguyen',
'M',
date('2001-02-18'),
concat('voxuannguyen2001/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenphuoctri',
'12345689',
'0914370975',
'ngphuoctri.bmt@gmail.com',
'Nguyen Phuoc Tri',
'M',
date('2001-08-28'),
concat('nguyenphuoctri/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenphuoctri',
'12345689',
'0914370975',
'ngphuoctri.bmt@gmail.com',
'Nguyen Phuoc Tri',
'M',
date('2001-08-28'),
concat('nguyenphuoctri/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'hotruongluong',
'htluong123',
'01678934556',
'truongluongho_ctnd@gmail.com',
'Ho Truong Luong',
'M',
date('2001-10-08'),
concat('hotruongluong/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenthanhcong',
'ntcong01',
'01697053312',
'ntcong@hcmut.edu.vn',
'Nguyen Thanh Cong',
'M',
date('2001-07-15'),
concat('nguyenthanhcong/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenhaison',
'sonhainguyenbmt',
'0915559871',
'nhson2001@hcmut.edu.vn',
'Nguyen Hai Son',
'M',
date('2001-02-24'),
concat('nguyenhaison/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenminhhai',
'minhhaivippro',
'0913737095',
'minhhaideptrai@gmail.com',
'Nguyen Minh Hai',
'M',
date('2001-10-19'),
concat('nguyenminhhai/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'yennhi_01',
'12345678',
'091334987',
'yennhi_le@hcmut.edu.vn',
'Le Nguyen Yen Nhi',
'F',
date('2001-04-19'),
concat('yennhi_le/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'linhchidepgai',
'linhchi01',
'0167642349',
'linhchi_lethi@hcmut.edu.vn',
'Le Thi Linh Chi',
'F',
date('2000-12-25'),
concat('linhchidepgai/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'khanhchann',
'khanhtranxinhdep',
'0918239861',
'tnkhanhtran@hcmut.edu.vn',
'Tran Ngoc Khanh Tran',
'F',
date('2001-03-23'),
concat('khanhchann/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'phuvotrinhan',
'anphu123',
'0915236160',
'anphu02@gmail.com',
'Vo Trinh An Phu',
'M',
date('2008-01-05'),
null,
false,
true
);

-- insert data into contains_product
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 1, 1, 3, 17000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 3, 1, 2, 29000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 3, 2, 1, 51000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 2, 2, 3, 22000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 4, 2, 1, 15000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (3, 1, 3, 1, 140000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (4, 2, 3, 1, 59000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 1, 3, 1, 32000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 4, 4, 2, 52000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (3, 2, 4, 1, 11000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (5, 4, 5, 3, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 3, 5, 1, 87000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (4, 2, 5, 3, 29000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 3, 6, 1, 87000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (5, 4, 6, 3, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 5, 6, 1, 87000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (5, 4, 7, 3, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 3, 7, 1, 87000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (3, 2, 8, 2, 53000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 4, 8, 1, 69000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 3, 8, 2, 30000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 4, 9, 2, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 2, 9, 2, 117000);

insert into order_contains_product values (4, 5, 10, 4, 6000);
insert into order_contains_product values (2, 2, 10, 3, 9000);
insert into order_contains_product values (5, 3, 10, 3, 29000);

insert into order_contains_product values (2, 2, 11, 3, 38000);
insert into order_contains_product values (1, 3, 11, 1, 57000);

insert into order_contains_product values (5, 1, 12, 1, 87000);
insert into order_contains_product values (3, 3, 12, 1, 229000);




