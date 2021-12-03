-- Run this script once every git pull

use e_commerce;

-- table user 
drop table if exists the_user;
create table the_user(
	user_id integer not null auto_increment,
    username varchar(30) not null unique,
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
    shop_manage_count integer not null default 0,
    primary key(user_id)
);


-- create index for the_user
alter table the_user 
drop index if exists idx_fullname;
create index idx_fullname on the_user(fullname);


-- Table order contains_product
drop table if exists order_contains_product;
create table order_contains_product(
	shop_id integer not null,
    product_id integer not null,
    order_id integer not null,
    amount integer not null default 1,
    selling_price integer not null,
    primary key(shop_id, product_id, order_id)
);


-- Procedure: insert to user procedure with input validation
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
	if not (username regexp '^[a-z0-9_.]*$') then
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
    
    if not (mobile regexp '^[0-9]*$') then
		signal sqlstate '45000'
			set message_text = 'mobile number can only contains numbers';
	end if;
    
    if not (email regexp '@.*\.') then
		signal sqlstate '45000'
			set message_text = 'email is not valid';
    end if;
    
	insert into the_user (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag)
		values (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag);
end//
delimiter ;


-- Trigger: after insert a new shop. Insert (user_id, shop_id) into table user_manage_shop
drop trigger if exists on_create_shop;
delimiter //
create trigger on_create_shop after insert on shop
for each row
begin
    insert into user_manage_shop values(new.shop_owner, new.shop_id, CURRENT_DATE);
end;//
delimiter ;


-- Trigger: after insert new data to user_manage_shop, change user's seller_flag to true and increase shop_manage_count to one
drop trigger if exists on_insert_user_manage_shop;
delimiter //
create trigger on_insert_user_manage_shop after insert on user_manage_shop
for each row
begin
	update the_user set seller_flag = true, shop_manage_count = shop_manage_count + 1
	where user_id = new.user_id;
end;//
delimiter ;


-- Trigger: before inserting a new user, assign date_created to current date if it is not set
drop trigger if exists on_create_user;
delimiter //
create trigger on_create_user before insert on the_user
for each row
if (new.date_created = 0) then
	set new.date_created = curdate();
end if;
//
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
concat('img/voxuannguyen2001/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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
concat('img/nguyenphuoctri/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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
concat('img/hotruongluong/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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
concat('img/nguyenthanhcong/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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
concat('img/nguyenhaison/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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
concat('img/nguyenminhhai/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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
concat('img/yennhi_le/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'ltlinhchi',
'linhchi01',
'0167642349',
'linhchi_lethi@hcmut.edu.vn',
'Le Thi Linh Chi',
'F',
date('2000-12-25'),
concat('img/ltlinhchi/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'khanhtran.2001',
'khanhchannn',
'0918239861',
'tnkhanhtran@hcmut.edu.vn',
'Tran Ngoc Khanh Tran',
'F',
date('2001-03-23'),
concat('img/khanhtran.2001/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
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



