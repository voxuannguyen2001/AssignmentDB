-- Run this script once every git pull

USE e_commerce;

-- table shop
DROP TABLE IF EXISTS shop;
CREATE TABLE shop (
    shop_id int not null auto_increment,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner varchar(9) not null,
    create_date date,
    shop_condition bool not null default true, # true: still working normally / false: no longer functioning
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
    user_id int not null,
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


-- INSERT DATA INTO TABLES
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES ('SAMSUNG','this is description, cool here',1,'2021-11-01');
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES ('Lilyeyewear','fashionista',2,'2021-11-02');
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES('PS','health care',3,'2021-11-03');

INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(1, 'waiting', '2021-11-23', 1,'Nguyen Trang', 'Phu Yen', '0123456789');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(2, 'processing', '2021-11-23', 2,'Tran Thang', 'TP.HCM', '0123456798');


-- hihi