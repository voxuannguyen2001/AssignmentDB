USE e_commerce;


-- Create Danh_muc

DROP TABLE IF EXISTS category;
CREATE TABLE category (
    category_id int not null, 
    name_category varchar(25) not null,
    total_product int not null, 
    primary key(category_id)
);
-- Insert Data Into CATEGORY
INSERT INTO category VALUES ('191','Quần','10');
INSERT INTO category VALUES ('192','Áo','11');
INSERT INTO category VALUES ('193','Giày','12');
INSERT INTO category VALUES ('194','Đồng hồ','13');
INSERT INTO category VALUES ('195','Nón','14');

