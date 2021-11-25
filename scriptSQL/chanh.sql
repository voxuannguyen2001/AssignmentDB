-- Run this script once every git pull

USE e_commerce;

-- Create Gio_hang

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
    cart_id varchar(9) not null,
    user_id varchar(9) not null,

    primary key(cart_id,user_id),
    foreign key(user_id) references user(user_id)
);

-- Insert Data Into cart

INSERT INTO cart VALUES ('J960245','');
INSERT INTO cart VALUES ('S80241D','');
INSERT INTO cart VALUES ('S62184B','');
INSERT INTO cart VALUES ('S82443E','');
INSERT INTO cart VALUES ('T825381','');
INSERT INTO cart VALUES ('J633567','');
INSERT INTO cart VALUES ('X374547','');
INSERT INTO cart VALUES ('T598144','');
INSERT INTO cart VALUES ('S634978','');
INSERT INTO cart VALUES ('S711515','');




-- Create Danh_muc

DROP TABLE IF EXISTS category;
CREATE TABLE category (
    category_id varchar(9) not null, 
    Name_category varchar(25) not null,
    Total_product int not null, 
    primary key(category_id)
);




-- contains_category table
DROP TABLE IF EXISTS contains_category;
CREATE TABLE contains_category (
    contains_category_id varchar(9) not null,
    parent_category_id varchar(9) not null,

    primary key(category_id),
    foreign key(parent_category_id) references category(category_id)
);
-- Insert Data Into category
INSERT INTO category VALUES ('T22012D','','3');
INSERT INTO category VALUES ('S92033D','','2');
INSERT INTO category VALUES ('S42209A','','5');
INSERT INTO category VALUES ('T5192XS','','7');
INSERT INTO category VALUES ('T372X6A','','6');
-- Insert Data Into contains_category
INSERT INTO contains_category VALUES ('S93492D','T22012D');
INSERT INTO contains_category VALUES ('S63228S','S92033D');
INSERT INTO contains_category VALUES ('H44003','S42209A');
INSERT INTO contains_category VALUES ('T84610A','T5192XS');
INSERT INTO contains_category VALUES ('H04433','T372X6A');