USE eCommerce;
-- Create Gio_hang

DROP TABLE IF EXISTS CART;
CREATE TABLE CART (
    Cart_id varchar(9) not null,
    Number_product int not null,
    Price_product int not null, 

    primary key(Cart_id)
);

-- Insert Data Into CART

INSERT INTO CART VALUES ('J960245','5','100');
INSERT INTO CART VALUES ('S80241D','2','50');
INSERT INTO CART VALUES ('S62184B','5','250');
INSERT INTO CART VALUES ('S82443E','4','200');
INSERT INTO CART VALUES ('T825381','6','300');
INSERT INTO CART VALUES ('J633567','8','1000');
INSERT INTO CART VALUES ('X374547','1','30');
INSERT INTO CART VALUES ('T598144','4','650');
INSERT INTO CART VALUES ('S634978','3','180');
INSERT INTO CART VALUES ('S711515','2','280');

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
    Category_id varchar(9) not null,
    Name_category varchar(25) not null,
    Total_product int not null, 

    primary key(Category_id),
    foreign key(Category_id) references CATEGORY(Category_id)
);
