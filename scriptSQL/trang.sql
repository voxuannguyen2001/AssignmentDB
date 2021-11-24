-- Run this script once every git pull
-- SHOP(shop_id), ORDER_DETAIL(order_id), PRODUCT_CATEGORY(shop_id, product_id)
-- uses USER(user_id), SHIPPING_UNIT(shipping_id), PRODUCT(shop_id, product_id), CATEGORY(category_id)
USE eCommerce;

DROP TABLE IF EXISTS SHOP;
CREATE TABLE SHOP (
    shop_id varchar(9) not null,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner varchar(9) not null,
    create_date date,
    -- amount_customer int,
    primary key(shop_id)
);
ALTER TABLE SHOP
ADD FOREIGN KEY (shop_owner) REFERENCES USER(user_id);

DROP TABLE IF EXISTS ORDER_DETAIL;
CREATE TABLE ORDER_DETAIL (
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
ALTER TABLE ORDER_DETAIL
ADD FOREIGN KEY (user_id) REFERENCES USER(user_id);
ALTER TABLE ORDER_DETAIL
ADD FOREIGN KEY (shipping_id) REFERENCES SHIPPING_UNIT(shipping_id);

DROP TABLE IF EXISTS PRODUCT_CATEGORY;
CREATE TABLE PRODUCT_CATEGORY(
    shop_id varchar(9) not null,
    product_id varchar(9) not null,
    category_id varchar(9),
    primary key (shop_id, product_id) 
);
ALTER TABLE PRODUCT_CATEGORY
ADD FOREIGN KEY (shop_id, product_id) REFERENCES PRODUCT(shop_id, product_id);
ALTER TABLE PRODUCT_CATEGORY
ADD FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id);


-- INSERT DATA INTO TABLES
INSERT INTO SHOP VALUES ('S11111111','SAMSUNG','this is description, cool here','U23456789','2021-11-01');
INSERT INTO SHOP VALUES ('S22222222','Lilyeyewear','fashionista','U23456788','2021-11-02');
INSERT INTO SHOP VALUES('S11111112','PS','health care','U12345678','2021-11-03');

INSERT INTO ORDER_DETAIL VALUES('O11111111','567567567', 'waiting', '2021-11-23', 'U21212121','Nguyen Trang', 'Phu Yen', '0123456789');
INSERT INTO ORDER_DETAIL VALUES('O11111112','123456789', 'processing', '2021-11-23', 'U12345670','Tran Thang', 'TP.HCM', '0123456798');

INSERT INTO PRODUCT_CATEGORY VALUES('S11111111', 'P11111111', 'C11111111');