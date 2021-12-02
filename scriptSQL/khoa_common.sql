USE e_commerce;

DROP TABLE IF exists user_manage_shop;
CREATE TABLE user_manage_shop (
user_id	int not null,
shop_id int not null,
start_date date not null
);

delimiter //
create trigger on_insert_user_manage_shop before insert on user_manage_shop
for each row
if (isnull(new.start_date)) then
	set new.start_date = curdate();
end if;
//
delimiter ;

-- constraint pk
ALTER TABLE user_manage_shop
ADD CONSTRAINT user_shop_pk
primary key (user_id, shop_id);

-- create data for table user_manage_shop
insert into user_manage_shop(user_id, shop_id) values (1,1);
insert into user_manage_shop(user_id, shop_id) values (2,2);
insert into user_manage_shop(user_id, shop_id) values (3,3);
insert into user_manage_shop(user_id, shop_id) values (4,4);
insert into user_manage_shop(user_id, shop_id) values (5,5);

DROP TABLE IF exists shipping_unit;
CREATE TABLE shipping_unit (
shipping_id int not null auto_increment,
shipping_name varchar(20) not null,
shipping_phone char(10),
shipping_website varchar(30),	
primary key (shipping_id),
unique(shipping_name)
);

-- create data for table shipping_unit
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangnhanh','0912345678','giaohangnhanh.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangtietkiem','0923423423','giaohangtietkiem.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('superfastship','0934534534','superfastship.com');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangdambao','0945645645','giaohangdambao.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('shippingstar','0956756756','shippingstar.com');

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

-- create data for table cart_contain_product
-- shop_id 1 --> product_id 1->6
-- shop_id 2 --> product_id 7->12
-- shop_id 3 --> product_id 13->18
-- shop_id 4 --> product_id 19->24
-- shop_id 5 --> product_id 25->30

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
