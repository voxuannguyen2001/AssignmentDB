USE eCommerce;
-- Create Gio_hang

DROP TABLE IF EXISTS CART;
CREATE TABLE CART (
    Cart_id varchar(9) not null,
    User_id varchar(9) not null,

    primary key(Cart_id,User_id),
    foreign key(User_id) references USER(user_id)
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
    Category_id varchar(9) not null, 
    Name_category varchar(25) not null,
    Total_product int not null, 
    primary key(Category_id)
);

DROP TABLE IF EXISTS CATEGORY_Child;
CREATE TABLE CATEGORY_Child (
    Category_Child_id varchar(9) not null,
    Parent_category_id varchar(9) not null,

    primary key(Category_id),
    foreign key(Parent_category_id) references CATEGORY(Category_id)
);
-- Insert Data Into CATEGORY
INSERT INTO CATEGORY VALUES ('T22012D','','3');
INSERT INTO CATEGORY VALUES ('S92033D','','2');
INSERT INTO CATEGORY VALUES ('S42209A','','5');
INSERT INTO CATEGORY VALUES ('T5192XS','','7');
INSERT INTO CATEGORY VALUES ('T372X6A','','6');
-- Insert Data Into CATEGORY_Child
INSERT INTO CATEGORY_Child VALUES ('S93492D','T22012D');
INSERT INTO CATEGORY_Child VALUES ('S63228S','S92033D');
INSERT INTO CATEGORY_Child VALUES ('H44003','S42209A');
INSERT INTO CATEGORY_Child VALUES ('T84610A','T5192XS');
INSERT INTO CATEGORY_Child VALUES ('H04433','T372X6A');