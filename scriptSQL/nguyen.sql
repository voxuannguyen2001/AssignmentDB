-- Run this script once every git pull

use e_commerce;

-- table user 
drop table if exists user;
create table user(
	user_id integer not null auto_increment,
    username varchar(30) not null,
    pass varchar(30) not null,
    mobile varchar(16),
    email varchar(50),
    fullname varchar(50) not null ,
    sex char(1),
    dob date,
    avatar varchar(64),
    seller_flag boolean,
    buyer_flag boolean,
    
    primary key(user_id)
);




-- table order contains_product
drop table if exists order_contains_product;
create table order_contains_product(
	shop_id integer not null auto_increment,
    product_id integer not null,
    order_id integer not null,
    amount integer not null default 1,
    selling_price integer not null,
    
    primary key(shop_id, product_id, order_id)
);




-- insert to user procedure
drop procedure if exists add_user;
delimiter //
create procedure add_user (
	in username varchar(30), 
    in pass varchar(30),
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
	insert into user (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag)
		values (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag);
end//
delimiter ;




-- insert data to user
call add_user (
'voxuannguyen2001',
'123456',
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
'123456',
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
'M',
date('2001-03-23'),
concat('khanhchann/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);


-- insert data into contains_product
insert into order_contains_product values (1, 1, 1, 3, 17000);
insert into order_contains_product values (2, 3, 1, 2, 29000);

insert into order_contains_product values (1, 3, 2, 1, 51000);
insert into order_contains_product values (2, 2, 2, 3, 22000);
insert into order_contains_product values (2, 4, 2, 1, 15000);

insert into order_contains_product values (3, 1, 3, 1, 140000);
insert into order_contains_product values (4, 2, 3, 1, 59000);
insert into order_contains_product values (2, 1, 3, 1, 32000);

insert into order_contains_product values (2, 4, 4, 2, 52000);
insert into order_contains_product values (3, 2, 4, 1, 11000);

insert into order_contains_product values (5, 4, 5, 3, 29000);
insert into order_contains_product values (2, 3, 5, 1, 87000);
insert into order_contains_product values (4, 2, 5, 3, 29000);

insert into order_contains_product values (2, 3, 6, 1, 87000);
insert into order_contains_product values (5, 4, 6, 3, 29000);
insert into order_contains_product values (2, 5, 6, 1, 87000);

insert into order_contains_product values (5, 4, 7, 3, 29000);
insert into order_contains_product values (2, 3, 7, 1, 87000);

insert into order_contains_product values (3, 2, 8, 2, 53000);
insert into order_contains_product values (2, 4, 8, 1, 69000);
insert into order_contains_product values (1, 3, 8, 2, 30000);

insert into order_contains_product values (1, 4, 9, 2, 29000);
insert into order_contains_product values (2, 2, 9, 2, 117000);

insert into order_contains_product values (4, 5, 10, 4, 6000);
insert into order_contains_product values (2, 2, 10, 3, 9000);
insert into order_contains_product values (5, 3, 10, 3, 29000);

insert into order_contains_product values (2, 2, 11, 3, 38000);
insert into order_contains_product values (1, 3, 11, 1, 57000);

insert into order_contains_product values (5, 1, 12, 1, 87000);
insert into order_contains_product values (3, 3, 12, 1, 229000);

