-- Run this script once every git pull

USE e_commerce;

-- table shop
DROP TABLE IF EXISTS shop;
CREATE TABLE shop (
    shop_id varchar(9) not null,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner varchar(9) not null,
    create_date date,
    -- amount_customer int,
    primary key(shop_id)
);
ALTER TABLE shop
ADD FOREIGN KEY (shop_owner) REFERENCES user(user_id);




-- table order_detail
DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail (
    order_id varchar(9) not null, 
    shipping_id int not null,
    order_status varchar(10),
    create_date date,
    user_id varchar(9) not null,
    sname varchar(40) not null,
    saddress text not null,
    sphone_number varchar(10) not null,
    primary key(order_id)
);
ALTER TABLE order_detail
ADD FOREIGN KEY (user_id) REFERENCES user(user_id);
ALTER TABLE order_detail
ADD FOREIGN KEY (shipping_id) REFERENCES shipping_unit(shipping_id);




-- table product_category
DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category(
    shop_id varchar(9) not null,
    product_id varchar(9) not null,
    category_id varchar(9),
    primary key (shop_id, product_id) 
);
ALTER TABLE product_category
ADD FOREIGN KEY (shop_id, product_id) REFERENCES product(shop_id, product_id);
ALTER TABLE product_category
ADD FOREIGN KEY (category_id) REFERENCES category(category_id);


-- INSERT DATA INTO TABLES
INSERT INTO shop VALUES ('S11111111','SAMSUNG','this is description, cool here','U23456789','2021-11-01');
INSERT INTO shop VALUES ('S22222222','Lilyeyewear','fashionista','U23456788','2021-11-02');
INSERT INTO shop VALUES('S11111112','PS','health care','U12345678','2021-11-03');

INSERT INTO order_detail VALUES('O11111111','567567567', 'waiting', '2021-11-23', 'U21212121','Nguyen Trang', 'Phu Yen', '0123456789');
INSERT INTO order_detail VALUES('O11111112','123456789', 'processing', '2021-11-23', 'U12345670','Tran Thang', 'TP.HCM', '0123456798');

INSERT INTO product_category VALUES('S11111111', 'P11111111', 'C11111111');