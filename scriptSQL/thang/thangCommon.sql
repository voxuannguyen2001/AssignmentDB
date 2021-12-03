DROP DATABASE IF EXISTS e_commerce;
CREATE DATABASE e_commerce;

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

-- table shop
DROP TABLE IF EXISTS shop;
CREATE TABLE shop (
    shop_id int not null auto_increment,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner_id int not null,
    create_date date,
    rating  int default 0,
    primary key(shop_id)
);


-- table order_detail
DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail (
    order_id int not null auto_increment, 
    shipping_id int not null,
    order_status varchar(10),
    create_date date,
    user_id int not null,
    sname varchar(40) not null,
    saddress text not null,
    sphone_number varchar(10) not null,
    total decimal(12,2) default 0.0,
    primary key(order_id)
);


-- table product_category
DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category(
    shop_id int not null,
    product_id int not null,
    category_id int,
    primary key (shop_id, product_id) 
);

-- table product
DROP TABLE IF exists product;
CREATE TABLE product (
product_id int not null AUTO_INCREMENT,
shop_id int not null,
product_name varchar(100) CHARSET utf8 not null,
listed_price decimal(12,2) not null,
origin varchar(100) CHARSET utf8,
remaining_amount int,
information varchar(300) CHARSET utf8,

primary key (product_id, shop_id)
);

-- table feedback
DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
    feedback_id int not null auto_increment,
    shop_id int not null,
    product_id int not null,
    review_content text,
    rating int not null,
    create_date date,
    user_id int not null,
    primary key(feedback_id, shop_id, product_id),
    constraint rating_ck check (rating between 0 and 5)
);

-- table user_manage_shop
DROP TABLE IF exists user_manage_shop;
CREATE TABLE user_manage_shop (
user_id	int not null,
shop_id int not null
);

-- constraint pk user_manage_shop
ALTER TABLE user_manage_shop
ADD CONSTRAINT user_shop_pk
primary key (user_id, shop_id);

DROP TABLE IF exists shipping_unit;
CREATE TABLE shipping_unit (
shipping_id int not null auto_increment,
shipping_name varchar(20) not null,
shipping_phone char(10),
shipping_website varchar(30),	
primary key (shipping_id),
unique(shipping_name)
);

DROP TABLE IF exists cart_contain_product;
CREATE TABLE cart_contain_product (
cart_id	int  not null,
user_id	int  not null,
product_id int not null,
shop_id int not null,
product_count  int,
saleprice integer,
primary key (cart_id, user_id, product_id, shop_id)
);

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
    cart_id int not null AUTO_INCREMENT,
    user_id int not null,

    primary key(cart_id,user_id)
);

DROP TABLE IF EXISTS category;
CREATE TABLE category (
    category_id int not null AUTO_INCREMENT, 
    name_category varchar(25) not null,
    total_product int, 
    parent_category_id int,

    primary key(category_id)
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

drop trigger if exists on_create_user;
delimiter //
create trigger on_create_user before insert on user
for each row
if (isnull(new.date_created)) then
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
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 3, 1, 2, 29000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 3, 2, 1, 51000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 7, 2, 3, 22000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 8, 2, 1, 15000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 1, 3, 1, 140000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 2, 3, 1, 59000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 9, 3, 1, 32000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 10, 4, 2, 52000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (3, 14, 4, 1, 11000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (5, 25, 5, 3, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 8, 5, 1, 87000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (4, 19, 5, 3, 29000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 8, 6, 1, 87000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (5, 28, 6, 3, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 10, 6, 1, 87000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (5, 29, 7, 3, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 11, 7, 1, 87000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (3, 15, 8, 2, 53000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 8, 8, 1, 69000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 3, 8, 2, 30000);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 4, 9, 2, 29000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (2, 12, 9, 2, 117000);

insert into order_contains_product values (4, 20, 10, 4, 6000);
insert into order_contains_product values (2, 8, 10, 3, 9000);
insert into order_contains_product values (5, 30, 10, 3, 29000);

insert into order_contains_product values (2, 12, 11, 3, 38000);
insert into order_contains_product values (1, 6, 11, 1, 57000);

insert into order_contains_product values (5, 29, 12, 1, 87000);
insert into order_contains_product values (3, 18, 12, 1, 229000);


-- INSERT DATA INTO TABLES
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES ('Lilyeyewear','fashionista',2,'2021-11-02');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES ('FPT','this is description, cool here',1,'2021-11-01');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('Houseware','health care',3,'2021-11-03');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('Book World','All thing you need',4,'2021-11-04');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('Cosmetics','You are beautiful',5,'2021-11-05');

INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(1, 'waiting', '2021-11-23', 1,'Nguyen Trang', 'Phu Yen', '0123456789');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(2, 'processing', '2021-11-23', 2,'Tran Thang', 'TP.HCM', '0123456798');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(3, 'success', '2021-11-27', 3,'Le Hoang Phuc', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(4, 'success', '2021-11-27', 4,'Le Tuyet Anh', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(1, 'waiting', '2021-11-23', 1,'Nguyen Bao', 'Phu Yen', '0123456789');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(2, 'processing', '2021-11-23', 2,'Tran Hung', 'TP.HCM', '0123456798');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(3, 'success', '2021-11-27', 3,'Thu Vi', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(4, 'success', '2021-11-27', 4,'Dan Anh', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(3, 'success', '2021-11-27', 3,'Lam Truong', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(4, 'success', '2021-11-27', 4,'Le Trung', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(3, 'success', '2021-11-27', 3,'Tan Truong', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(4, 'success', '2021-11-27', 4,'NGoc Trung', 'TP.HCM', '0123456700');

-- create data for table shipping_unit
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangnhanh','0912345678','giaohangnhanh.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangtietkiem','0923423423','giaohangtietkiem.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('superfastship','0934534534','superfastship.com');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangdambao','0945645645','giaohangdambao.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('shippingstar','0956756756','shippingstar.com');

-- cart of user 1
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (1,1,1,1,2,10000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (1,1,7,2,1,100000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (1,1,13,3,5,21000);

-- cart of user 3
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (3,3,2,1,4,10000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (3,3,8,2,1,50000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (3,3,14,3,2,20000);

-- cart of user 4
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (4,4,19,4,2,10000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (4,4,25,5,2,20000);

-- cart of user 5
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (5,5,20,4,2,30000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (5,5,26,5,2,40000);

-- cart of user 7
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (7,7,3,1,2,60000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (7,7,4,1,1,70000);

-- cart of user 8
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (8,8,15,3,3,80000);
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (8,8,16,3,4,100000);

-- cart of user 10
insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) values (9,9,30,5,1,7000);

insert into user_manage_shop values (1,1);
insert into user_manage_shop values (2,2);
insert into user_manage_shop values (3,3);
insert into user_manage_shop values (4,4);
insert into user_manage_shop values (5,5);


-- Cửa hàng thời trang --
-- Danh mục quần áo
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nữ',200000.00,N'Hàn Quốc',20,N'Vải cotton, Màu trắng, Size M');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nữ',200000.00,N'Hàn Quốc',15,N'Vải cotton, Màu đen, Size S');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nam',150000.00,N'Việt Nam',20,N'Vải cotton, Màu đen, Size L');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nam',150000.00,N'Việt Nam',10,N'Vải cotton, Màu đen, Size XL');
-- Danh mục giày dép
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Giày thể thao nữ',500000.00,N'Việt Nam',5,N'Giày thể thao nữ buộc dây siêu nhẹ, Màu trắng, Size 38');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Giày thể thao nam',550000.00,N'Việt Nam',8,N'Giày thể thao nam êm ái, Màu đen, Size 42');

-- Cửa hàng điện tử --
-- Danh mục điện thoại
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'iPhone 13 Pro Max',33990000.00,N'Trung Quốc',10,N'RAM: 8GB, ROM: 256GB, Năm sản xuất: 2021');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'iPhone 12',20000000.00,N'Trung Quốc',10,N'RAM: 6GB, ROM: 128GB, Năm sản xuất: 2020');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Samsung Galaxy Z Fold 3',44990000.00,N'Hàn Quốc',10,N'RAM: 12GB, ROM: 512GB, Năm sản xuất: 2021');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Samsung Galaxy A03',4990000.00,N'Hàn Quốc',10,N'RAM: 6GB, ROM: 64GB, Năm sản xuất: 2020');
-- Danh mục laptop
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Asus Vivobook M513UA',18990000.00,N'Trung Quốc',5,N'Chip: R5 5500U, RAM: 8GB, SSD: 512GB, Năm sản xuất: 2021');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Lenovo ThinkPad E15',22990000.00,N'Trung Quốc',5,N'Chip: i7 1165G, RAM: 8GB, SSD: 512GB, Năm sản xuất: 2020');

-- Cửa hàng đồ da dụng -- 
-- Danh mục điện da dụng
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Máy xay sinh tố',9990000.00,N'Trung Quốc',10,N'Hãng: Sunhouse, Chất liệu: Nhựa siêu bền');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Nồi chiên không dầu',19990000.00,N'Trung Quốc',10,N'Hãng: Toshiba, Chất liệu: Thép không gỉ');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Ấm đun nước siêu tốc',8990000.00,N'Trung Quốc',10,N'Hãng: Lock&Lock, Chất liệu: Nhựa siêu bền');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Nồi cơm điện',8990000.00,N'Trung Quốc',10,N'Hãng: Cooking, Chất liệu: Nhựa siêu bền');
-- Danh mục dụng cụ da dụn
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Chảo chống dính',2990000.00,N'Trung Quốc',10,N'Hãng: MyCook, Chất liệu: Đá đáy từ');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Nồi inox',1990000.00,N'Trung Quốc',10,N'Hãng: Mycook, Chất liệu: Inox');

-- Cửa hàng sách --
-- Danh mục SGK
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Tập Đọc 1',20000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 1');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Đạo Đức 1',18000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 1');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Ngữ Văn 6',22000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 6');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Toán 6',18000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 6');
-- Danh mục tiểu thuyết
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Nhà nàng ở cạnh nhà tôi',180000.00,N'Việt Nam',50,N'NXB: Thanh niên');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Nhà tôi ở cạnh nhà nàng',200000.00,N'Việt Nam',40,N'NXB: Thanh niên');

-- Cửa hàng mỹ phẩm
-- Danh mục son môi
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son lì',180000.00,N'Việt Nam',10,N'Màu: Hồng cánh sen');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son dưỡng',180000.00,N'Việt Nam',10,N'Màu: Không màu');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son Eglips',190000.00,N'Việt Nam',10,N'Màu: Đỏ gạch');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son thỏi',200000.00,N'Việt Nam',15,N'Màu: Đỏ cam');
-- Danh mục sữa rửa mặt
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Sữa rửa mặt Cosrx',150000.00,N'Việt Nam',10,N'Khối lượng: 320g');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Sữa rửa mặt Catephil',200000.00,N'Việt Nam',10,N'Khối lượng: 320g');


insert into cart (user_id) values (1);
insert into cart (user_id) values (2);
insert into cart (user_id) values (3);
insert into cart (user_id) values (4);
insert into cart (user_id) values (5);
insert into cart (user_id) values (6);
insert into cart (user_id) values (7);
insert into cart (user_id) values (8);
insert into cart (user_id) values (9);
insert into cart (user_id) values (10);
insert into cart (user_id) values (11);

insert into category (name_category) values ('categort_1');
insert into category (name_category) values ('categort_2');
insert into category (name_category) values ('categort_3');
insert into category (name_category) values ('categort_4');
insert into category (name_category) values ('categort_5');
insert into category (name_category) values ('categort_6');
insert into category (name_category) values ('categort_7');
insert into category (name_category) values ('categort_8');
insert into category (name_category) values ('categort_9');
insert into category (name_category) values ('categort_10');

-- add foreign key
ALTER TABLE product
ADD FOREIGN KEY (shop_id) REFERENCES shop(shop_id);

ALTER TABLE order_contains_product  
ADD FOREIGN KEY (order_id) REFERENCES order_detail(order_id);

ALTER TABLE order_contains_product  
ADD FOREIGN KEY (shop_id, product_id) REFERENCES product(shop_id, product_id);

ALTER TABLE shop
ADD FOREIGN KEY (shop_owner_id) REFERENCES user(user_id);

ALTER TABLE order_detail
ADD FOREIGN KEY (user_id) REFERENCES user(user_id);

ALTER TABLE order_detail
ADD FOREIGN KEY (shipping_id) REFERENCES shipping_unit(shipping_id);

ALTER TABLE product_category
ADD FOREIGN KEY (shop_id, product_id) REFERENCES product(shop_id, product_id);

ALTER TABLE product_category
ADD FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE user_manage_shop
ADD FOREIGN KEY (shop_id) REFERENCES shop(shop_id);

ALTER TABLE user_manage_shop
ADD FOREIGN KEY (user_id) REFERENCES user(user_id);

ALTER TABLE cart_contain_product
ADD FOREIGN KEY (product_id,shop_id) REFERENCES product(product_id,shop_id);

ALTER TABLE cart_contain_product
ADD FOREIGN KEY (cart_id,user_id) REFERENCES cart(cart_id,user_id);

ALTER TABLE cart
add foreign key(user_id) references user(user_id);

ALTER TABLE category
add foreign key(parent_category_id) references category(category_id);

ALTER TABLE feedback
ADD FOREIGN KEY ( product_id,shop_id) REFERENCES product(product_id,shop_id);

ALTER TABLE feedback
ADD FOREIGN KEY ( user_id) REFERENCES user(user_id);

insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 1, 9, 2, 117000);
insert into order_contains_product(shop_id, product_id, order_id, amount, selling_price) values (1, 1, 10, 100, 10);
DELETE FROM order_contains_product WHERE order_id = 10 AND shop_id = 1 AND product_id = 1;