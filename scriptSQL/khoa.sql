-- Run this script once every git pull

USE e_commerce;

-- table user_manage_shop
DROP TABLE IF exists user_manage_shop;
CREATE TABLE user_manage_shop (
user_id		char(9)  not null,
shop_id		char(9)  not null,
primary key (user_id, shop_id)
);


-- create data for table user_manage_shop
insert into user_manage_shop values ('123456789','111111111');
insert into user_manage_shop values ('123456789','222222222');
insert into user_manage_shop values ('334455667','333333333');
insert into user_manage_shop values ('234234234','333333333');
insert into user_manage_shop values ('123123123','111111111');




-- table shipping_unit
DROP TABLE IF exists shipping_unit;
CREATE TABLE shipping_unit (
shipping_id		char(9)  not null,
shipping_name	varchar(20)  not null,
shipping_phone	char(10),
shipping_website	varchar(30),	
primary key (shipping_id),
unique(shipping_name)
);

-- create data for table shipping_unit
insert into shipping_unit values ('123456789','giaohangnhanh','0912345678','giaohangnhanh.vn');
insert into shipping_unit values ('234234234','giaohangtietkiem','0923423423','giaohangtietkiem.vn');
insert into shipping_unit values ('345345345','superfastship','0934534534','superfastship.com');
insert into shipping_unit values ('456456456','giaohangdambao','0945645645','giaohangdambao.vn');
insert into shipping_unit values ('567567567','shippingstar','0956756756','shippingstar.com');




-- table cart_contain_product
DROP TABLE IF exists cart_contain_product;
CREATE TABLE cart_contain_product (
cart_id		char(9)  not null,
user_id	    char(9)  not null,
product_id	char(9)  not null,
shop_id	    char(9)  not null,
product_count  int,
saleprice 	DECIMAL(10,2),
primary key (cart_id, user_id, product_id, shop_id)
);

-- create data for table cart_contain_product
insert into cart_contain_product values ('000000000','200000000','100000000','111111111',2,10000.5);
insert into cart_contain_product values ('000000000','200000000','100000001','111111111',1,100000);
insert into cart_contain_product values ('000000000','200000000','100000002','222222222',5,21000.3);

insert into cart_contain_product values ('000000001','200000001','100000000','111111111',4,10000.5);
insert into cart_contain_product values ('000000001','200000001','100000003','333333333',1,50000.7);
insert into cart_contain_product values ('000000001','200000001','100000007','111111111',2,20000.5);

insert into cart_contain_product values ('000000002','200000002','100000005','111111111',2,10000.5);
insert into cart_contain_product values ('000000002','200000002','100000006','111111111',2,20000.5);
insert into cart_contain_product values ('000000002','200000002','100000008','222222222',2,30000.5);
insert into cart_contain_product values ('000000002','200000002','100000009','333333333',2,40000.5);

insert into cart_contain_product values ('000000003','200000003','100000010','222222222',2,60000.5);
insert into cart_contain_product values ('000000003','200000003','100000011','111111111',1,70000.5);
insert into cart_contain_product values ('000000003','200000003','100000012','333333333',3,80000.5);
insert into cart_contain_product values ('000000003','200000003','100000013','111111111',4,100000.5);
insert into cart_contain_product values ('000000003','200000003','100000014','222222222',1,7000.5);

