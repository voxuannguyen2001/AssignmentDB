USE eCommerce;
-- Create Gio_hang

DROP TABLE IF EXISTS CART;
CREATE TABLE CART (
    cart_id int not null,
    user_id int not null,

    primary key(cart_id,user_id),
    foreign key(user_id) references USER(user_id)
);

-- Insert Data Into CART

INSERT INTO CART VALUES ('J960245','');
INSERT INTO CART VALUES ('S80241D','');
INSERT INTO CART VALUES ('S62184B','');
INSERT INTO CART VALUES ('S82443E','');
INSERT INTO CART VALUES ('T825381','');
INSERT INTO CART VALUES ('J633567','');
INSERT INTO CART VALUES ('X374547','');
INSERT INTO CART VALUES ('T598144','');
INSERT INTO CART VALUES ('S634978','');
INSERT INTO CART VALUES ('S711515','');

-- Create Danh_muc

DROP TABLE IF EXISTS CATEGORY;
CREATE TABLE CATEGORY (
    category_id int not null, 
    name_category varchar(25) not null,
    total_product int not null, 
    primary key(category_id)
);

DROP TABLE IF EXISTS CONTAINS_CATEGORY;
CREATE TABLE CONTAINS_CATEGORY (
    contains_category_id int not null,
    parent_category_id int not null,

    primary key(category_id),
    foreign key(parent_category_id) references CATEGORY(category_id)
);
-- Insert Data Into CATEGORY
INSERT INTO CATEGORY VALUES ('T22012D','','3');
INSERT INTO CATEGORY VALUES ('S92033D','','2');
INSERT INTO CATEGORY VALUES ('S42209A','','5');
INSERT INTO CATEGORY VALUES ('T5192XS','','7');
INSERT INTO CATEGORY VALUES ('T372X6A','','6');
-- Insert Data Into CONTAINS_CATEGORY
INSERT INTO CONTAINS_CATEGORY VALUES ('S93492D','T22012D');
INSERT INTO CONTAINS_CATEGORY VALUES ('S63228S','S92033D');
INSERT INTO CONTAINS_CATEGORY VALUES ('H44003','S42209A');
INSERT INTO CONTAINS_CATEGORY VALUES ('T84610A','T5192XS');
INSERT INTO CONTAINS_CATEGORY VALUES ('H04433','T372X6A');



--Add dang mục

drop procedure if exists add_category

create procedure add_category(
    in category_id int,
    in name_category text,
    

)