-- Những chỉnh sửa:
--     Nguyen:
--         + Xóa auto_increment của shop_id
--         + Thêm khóa ngoại
--         + Khi insert vào bảng order_contains_product cần đảm bảo shop_id, product_id, order_id có tồn tại
--     Trang:
--         + Đổi shop_owner thành shop_owner_id
--         + Thêm khóa ngoại
--     Khoa:
--     Chanh:
--         + Sửa khá nhiều
-- p/s: DBSM của Thắng ko cho phép tạo bảng tên là user, vì vậy t đã tạm đổi tất cả user->uuser, nếu DBMS của mọi người cho phép thì có thể replace lại.
--     Đây là một bản mẫu tham khảm để mọi người tiện làm những câu tiếp theo, nếu có sai sót mong mọi người sửa lại và báo lên nhóm

DROP DATABASE IF EXISTS e_commerce;
CREATE DATABASE e_commerce;

use e_commerce;

-- Nguyen ---------------------------------------------------------
-- table uuuser 
drop table if exists uuser;
create table uuser(
	uuser_id integer not null auto_increment,
    uusername varchar(30) not null,
    pass varchar(30) not null,
    mobile varchar(16),
    email varchar(50),
    fullname varchar(50) not null ,
    sex char(1),
    dob date,
    avatar varchar(64),
    seller_flag boolean,
    buyer_flag boolean,
    
    primary key(uuser_id)
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
-- End Nguyen ---------------------------------------------------------

-- Trang ---------------------------------------------------------
-- table shop
DROP TABLE IF EXISTS shop;
CREATE TABLE shop (
    shop_id int not null auto_increment,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner_id int not null,
    create_date date,
    -- amount_customer int,
    primary key(shop_id)
);


-- table order_detail
DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail (
    order_id int not null auto_increment, 
    shipping_id int not null,
    order_status varchar(10),
    create_date date,
    uuser_id int not null,
    sname varchar(40) not null,
    saddress text not null,
    sphone_number varchar(10) not null,
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
-- End Trang ---------------------------------------------------------


-- Thang ---------------------------------------------------------
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
-- End Thang ---------------------------------------------------------


-- Khoa ---------------------------------------------------------
DROP TABLE IF exists uuser_manage_shop;
CREATE TABLE uuser_manage_shop (
uuser_id	int not null,
shop_id int not null
);

-- constraint pk
ALTER TABLE uuser_manage_shop
ADD CONSTRAINT uuser_shop_pk
primary key (uuser_id, shop_id);

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
uuser_id	int  not null,
product_id int not null,
shop_id int not null,
product_count  int,
saleprice integer,
primary key (cart_id, uuser_id, product_id, shop_id)
);
-- End Khoa ---------------------------------------------------------

-- Chanh ---------------------------------------------------------
DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
    cart_id int not null AUTO_INCREMENT,
    uuser_id int not null,

    primary key(cart_id,uuser_id)
);

DROP TABLE IF EXISTS category;
CREATE TABLE category (
    category_id int not null AUTO_INCREMENT, 
    Name_category varchar(25) not null,
    total_product int not null, 
    parent_category_id int,

    primary key(category_id)
);
-- End Chanh ------------------------------------------------

-- insert to uuser procedure
drop procedure if exists add_uuser;
delimiter //
create procedure add_uuser (
	in uusername varchar(30), 
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
	insert into uuser (uusername, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag)
		values (uusername, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag);
end//
delimiter ;


-- insert data to uuser
call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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

call add_uuser (
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
insert into order_contains_product values (1, 2, 1, 3, 17000);
insert into order_contains_product values (1, 3, 1, 3, 17000);
insert into order_contains_product values (1, 4, 2, 3, 17000);
insert into order_contains_product values (1, 5, 2, 3, 17000);
insert into order_contains_product values (1, 6, 2, 3, 17000);


-- INSERT DATA INTO TABLES
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES ('SAMSUNG','this is description, cool here',1,'2021-11-01');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES ('Lilyeyewear','fashionista',2,'2021-11-02');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('PS','health care',3,'2021-11-03');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('HAHA','health care',4,'2021-11-03');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('HiHi','health care',5,'2021-11-03');

INSERT INTO order_detail(shipping_id, order_status, create_date, uuser_id, sname, saddress,sphone_number )  
VALUES(1, 'waiting', '2021-11-23', 1,'Nguyen Trang', 'Phu Yen', '0123456789');
INSERT INTO order_detail(shipping_id, order_status, create_date, uuser_id, sname, saddress,sphone_number )  
VALUES(2, 'processing', '2021-11-23', 2,'Tran Thang', 'TP.HCM', '0123456798');

-- create data for table shipping_unit
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangnhanh','0912345678','giaohangnhanh.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangtietkiem','0923423423','giaohangtietkiem.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('superfastship','0934534534','superfastship.com');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangdambao','0945645645','giaohangdambao.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('shippingstar','0956756756','shippingstar.com');

-- cart of uuser 1
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (1,1,1,1,2,10000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (1,1,7,2,1,100000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (1,1,13,3,5,21000);

-- cart of uuser 3
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (3,3,2,1,4,10000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (3,3,8,2,1,50000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (3,3,14,3,2,20000);

-- cart of uuser 4
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (4,4,19,4,2,10000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (4,4,25,5,2,20000);

-- cart of uuser 5
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (5,5,20,4,2,30000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (5,5,26,5,2,40000);

-- cart of uuser 7
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (7,7,3,1,2,60000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (7,7,4,1,1,70000);

-- cart of uuser 8
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (8,8,15,3,3,80000);
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (8,8,16,3,4,100000);

-- cart of uuser 10
insert into cart_contain_product (cart_id, uuser_id, product_id, shop_id, product_count, saleprice) values (9,9,30,5,1,7000);

insert into uuser_manage_shop values (1,1);
insert into uuser_manage_shop values (2,2);
insert into uuser_manage_shop values (3,3);
insert into uuser_manage_shop values (4,4);
insert into uuser_manage_shop values (5,5);


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


insert into cart (uuser_id) values (1);
insert into cart (uuser_id) values (2);
insert into cart (uuser_id) values (3);
insert into cart (uuser_id) values (4);
insert into cart (uuser_id) values (5);
insert into cart (uuser_id) values (6);
insert into cart (uuser_id) values (7);
insert into cart (uuser_id) values (8);
insert into cart (uuser_id) values (9);
insert into cart (uuser_id) values (10);

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
ADD FOREIGN KEY (shop_owner_id) REFERENCES uuser(uuser_id);

ALTER TABLE order_detail
ADD FOREIGN KEY (uuser_id) REFERENCES uuser(uuser_id);

ALTER TABLE order_detail
ADD FOREIGN KEY (shipping_id) REFERENCES shipping_unit(shipping_id);

ALTER TABLE product_category
ADD FOREIGN KEY (shop_id, product_id) REFERENCES product(shop_id, product_id);

ALTER TABLE product_category
ADD FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE uuser_manage_shop
ADD FOREIGN KEY (shop_id) REFERENCES shop(shop_id);

ALTER TABLE uuser_manage_shop
ADD FOREIGN KEY (uuser_id) REFERENCES uuser(uuser_id);

ALTER TABLE cart_contain_product
ADD FOREIGN KEY (product_id,shop_id) REFERENCES product(product_id,shop_id);

ALTER TABLE cart_contain_product
ADD FOREIGN KEY (cart_id,uuser_id) REFERENCES cart(cart_id,uuser_id);

ALTER TABLE cart
add foreign key(uuser_id) references uuser(uuser_id);

ALTER TABLE category
add foreign key(parent_category_id) references category(category_id);
