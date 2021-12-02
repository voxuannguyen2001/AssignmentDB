USE e_commerce;

DROP TABLE IF exists User_manage_shop;
CREATE TABLE User_manage_shop (
user_id	int not null,
shop_id int not null
);

-- constraint pk
ALTER TABLE User_manage_shop
ADD CONSTRAINT user_shop_pk
primary key (user_id, shop_id);

DROP TABLE IF exists shipping_unit;
CREATE TABLE shipping_unit (
shipping_id int not null auto_increment,
shipping_name varchar(20) not null,
shipping_phone char(10),
shipping_website varchar(30),	
primary key (shipping_id),
unique(shipping_name)
);

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

-- table the_user 
drop table if exists the_user;
create table the_user(
	user_id integer not null auto_increment,
    username varchar(30) not null,
    pass varchar(30) not null,
    mobile varchar(16),
    email varchar(50),
    fullname varchar(50) not null ,
    sex char(1),
    dob date,
    avatar varchar(64),
    seller_flag boolean,
    buyer_flag boolean,
    
    primary key(user_id)
);

-- insert to user procedure
drop procedure if exists add_user;
delimiter //
create procedure add_user (
	in username varchar(30), 
    in pass varchar(30),
    in mobile varchar(12),
    in email varchar(50),
    in fullname varchar(50),
    in sex char(1),
    in dob date,
	in avatar varchar(64),
    in seller_flag boolean,
    in buyer_flag boolean
)
begin
	insert into the_user (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag)
		values (username, pass, mobile, email, fullname, sex, dob, avatar, seller_flag, buyer_flag);
end//
delimiter ;

-- table shop
DROP TABLE IF EXISTS shop;
CREATE TABLE shop (
    shop_id int not null auto_increment,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner_id int not null,
    create_date date,
    -- amount_customer int,
    primary key(shop_id)
);

-- table product
DROP TABLE IF exists product;
CREATE TABLE product (
product_id int not null AUTO_INCREMENT,
shop_id int not null,
product_name varchar(100) CHARSET utf8 not null,
listed_price decimal(12,2) not null,
origin varchar(100) CHARSET utf8,
remaining_amount int,
information varchar(300) CHARSET utf8,

primary key (product_id, shop_id)
);

DROP TABLE IF EXISTS cart;
CREATE TABLE cart (
    cart_id int not null AUTO_INCREMENT,
    user_id int not null,

    primary key(cart_id,user_id)
);

-- table order contains_product
drop table if exists order_contains_product;
create table order_contains_product(
	shop_id integer not null,
    product_id integer not null,
    order_id integer not null,
    amount integer not null default 1,
    selling_price integer not null,
    primary key(shop_id, product_id, order_id)
);

-- 1. procedure insert
-- tạo constraint giới hạn số lượng sản phẩm của một loại sản phẩm trong giỏ hàng từ 1 -> 10.
alter table cart_contain_product
add constraint product_range 
check (product_count between 1 and 10);

-- tạo procedure
drop procedure if exists add_product_into_cart
delimiter //
create procedure add_product_into_cart (
    in cart_id int,
	in user_id	int,
	in product_id int,
	in shop_id int,
	in product_count  int,
	in saleprice integer
)
begin
    insert into cart_contain_product (cart_id, user_id, product_id, shop_id, product_count, saleprice) 
    values (cart_id, user_id, product_id, shop_id, product_count, saleprice);
end//
delimiter ;

-- function
-- function1
-- tính số lượng loại sản phẩm có selling_price >= x vnđ (với x <= 1.000.000 vnd) trong đơn hàng có order_id cụ thể nào đó

-- function: truyen vao tham so va tra ve gia tri
-- muon lay cac gia tri trong cac column cua bang de thao tac tinh toan
-- ==> dung cursor (nap vao tu select) de tro den tung row trong table de lay gia tri vao bien

DELIMITER $$
DROP function if exists num_of_product_type_in_order $$
CREATE function num_of_product_type_in_order(para_order_id int, x int)
returns int
READS SQL DATA
DETERMINISTIC
BEGIN
	if (x > 1000000) then
		signal sqlstate '45000' set message_text = "Invalid input x!";
    else
    begin
		declare num int default 0;  
		declare func_selling_price int;
		DECLARE exit_loop BOOLEAN;  
		DECLARE cur CURSOR FOR
			SELECT selling_price
			FROM order_contains_product
			where order_id = para_order_id
			having selling_price >= x;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
		OPEN cur;
		order_loop: LOOP
			FETCH cur INTO func_selling_price;
			IF exit_loop THEN
				CLOSE cur;
				LEAVE order_loop;        
			END IF;
			set num = num + 1;
		END LOOP order_loop;
		return num;
		end;
    end if;
 END $$
 DELIMITER ;  

-- function2
-- tính tổng tiền của các sản phẩm thuộc 1 shop nào đó trong giỏ hàng của tất cả user
-- truyen vao tham so la shop_id

DELIMITER $$
DROP function if exists total_money_pay_shop_in_cart $$
CREATE function total_money_pay_shop_in_cart(para_shop_id int)
returns int
READS SQL DATA
DETERMINISTIC
BEGIN
	-- kiem tra shop_id truyen vao co ton tai ko
    declare input_valid bool default true;
    declare tmp_id int default -1;
    declare cur_check cursor for 
		select shop_id 
		from shop
		where shop_id = para_shop_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET input_valid = false;
	OPEN cur_check;
    check_loop: loop
		fetch cur_check into tmp_id;
        IF (input_valid = false) THEN
			CLOSE cur_check;
			LEAVE check_loop;        
		END IF;
        if (tmp_id > -1) then
			CLOSE cur_check;
			LEAVE check_loop;        
		END IF;
	end loop check_loop;
    
    -- neu shop_id truyen vao khong ton tai
	if (input_valid = false) then
		signal sqlstate '45000' set message_text = "Invalid shop_id!";
    else
    begin
		DECLARE total int default 0;  
        declare amount int; 
		declare func_saleprice int;
		DECLARE exit_loop BOOLEAN;  
		DECLARE cur CURSOR FOR
			SELECT product_count, saleprice
			FROM cart_contain_product
			where shop_id = para_shop_id;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
		OPEN cur;
		cart_loop: LOOP
			FETCH cur INTO amount,func_saleprice;
			IF exit_loop THEN
				CLOSE cur;
				LEAVE cart_loop;        
			END IF;
			set total = total + amount*func_saleprice;
		END LOOP cart_loop;
		return total;
		end;
    end if;
 END $$
 DELIMITER ;  
 
-- trigger1
-- neu 1 user_id them 1 loai san pham vs so luong sp cua loai vao gio hang cua ho --> kiem 
-- tra gio hang da day chua? (gio hang chua toi da la 20 loai san pham)

drop trigger if exists cart_full_check
delimiter $$
create trigger cart_full_check before insert on cart_contain_product
for each row
begin
	DECLARE prodtype_count INT DEFAULT 0;
	SELECT COUNT(*) INTO prodtype_count
	FROM cart_contain_product
	WHERE user_id = new.user_id;
    
    if (prodtype_count = 3) then
		begin
			 signal sqlstate '45000' set message_text = "cart of user has been fulled. Can't add product!";
		end;
	end if;
end;
$$
Delimiter ;

-- trigger2 - after insert
-- khi 1 user them san pham voi so luong nhat dinh vao gio hang cua ho thi update tong so luong san pham 
-- va tong tien o table cart

-- add column total_num_of_prod and total_money to table cart
ALTER TABLE cart ADD COLUMN total_num_of_prod INT DEFAULT 0;
ALTER TABLE cart ADD COLUMN total_money INT DEFAULT 0;

drop trigger if exists update_cart_with_total_quantity
delimiter $$
create trigger update_cart_with_total_quantity after insert on cart_contain_product
for each row
begin
-- update total number of products
    update cart
    set total_num_of_prod = (cart.total_num_of_prod + new.product_count)
    where cart.cart_id = new.cart_id;
    
-- update total money of products in cart
	update cart
    set total_money = (cart.total_money + new.product_count*new.saleprice)
    where cart.cart_id = new.cart_id;
end;
$$
Delimiter ;  

-- procedure
-- procedure1
-- truy vấn loại sản phẩm được lưu của 1 người mua nào đó trong giỏ hàng của họ: 
-- lấy thêm thông tin từ table product và sắp xếp saleprice tăng dần or giảm dần
-- join 2 table: cart_contain_product and product

drop procedure if exists get_product_info_in_cart
delimiter $$
create procedure get_product_info_in_cart(
    in p_user_id int,
    in type_order varchar(4)
    )
begin
    if type_order = "ASC"
    then
    begin
        select user_id, product.product_id, product_name, saleprice, information
        from cart_contain_product, product
        where user_id = p_user_id and cart_contain_product.product_id = product.product_id
        order by saleprice;
    end;
    end if;
    if type_order = "DESC"
    then
    begin
        select user_id, product.product_id, product_name, saleprice, information
        from cart_contain_product, product
        where user_id = p_user_id and cart_contain_product.product_id = product.product_id
        order by saleprice DESC;
    end;
    end if;
end;
$$
Delimiter ;

-- procedure2
-- truy vấn username, user_id, fullname, mobile ứng với giỏ hàng của họ: 
-- lấy tổng tiền của tất cả sản phẩm trong giỏ hàng → group by id người mua, having thành tiền >= x vnđ
-- aggregate function lấy tổng, order by sắp xếp theo tổng tiền.
-- join user và cart_contain_product
drop procedure if exists get_total_money_in_cart_and_user_info
delimiter $$
create procedure get_total_money_in_cart_and_user_info(
    in x int,
    in type_order varchar(4)
    )
begin
    if type_order = "ASC"
    then
    begin
        select the_user.user_id, username, fullname, mobile, sum(saleprice*product_count) as total_money
        from the_user, cart_contain_product
        where the_user.user_id = cart_contain_product.user_id
        group by cart_contain_product.user_id
        having total_money >= x
        order by total_money;
    end;
    end if;
    if type_order = "DESC"
    then
    begin
        select the_user.user_id, username, fullname, mobile, sum(saleprice*product_count) as total_money
        from the_user, cart_contain_product
        where the_user.user_id = cart_contain_product.user_id
        group by cart_contain_product.user_id
        having total_money >= x
        order by total_money DESC;
    end;
    end if;
end;
$$
Delimiter ;

-- create data ----------------------------------------------------------------------------------------------
-- create data for table shipping_unit
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangnhanh','0912345678','giaohangnhanh.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangtietkiem','0923423423','giaohangtietkiem.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('superfastship','0934534534','superfastship.com');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('giaohangdambao','0945645645','giaohangdambao.vn');
insert into shipping_unit (shipping_name,shipping_phone,shipping_website) values ('shippingstar','0956756756','shippingstar.com');

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

-- create data for table User_manage_shop
insert into User_manage_shop values (1,1);
insert into User_manage_shop values (2,2);
insert into User_manage_shop values (3,3);
insert into User_manage_shop values (4,4);
insert into User_manage_shop values (5,5);

-- insert data to user
call add_user (
'voxuannguyen2001',
'123456',
'0397003301',
'voxuannguyen2001@gmail.com',
'Vo Trinh Xuan Nguyen',
'M',
date('2001-02-18'),
concat('voxuannguyen2001/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenphuoctri',
'12345689',
'0914370975',
'ngphuoctri.bmt@gmail.com',
'Nguyen Phuoc Tri',
'M',
date('2001-08-28'),
concat('nguyenphuoctri/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenphuoctri',
'12345689',
'0914370975',
'ngphuoctri.bmt@gmail.com',
'Nguyen Phuoc Tri',
'M',
date('2001-08-28'),
concat('nguyenphuoctri/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'hotruongluong',
'htluong123',
'01678934556',
'truongluongho_ctnd@gmail.com',
'Ho Truong Luong',
'M',
date('2001-10-08'),
concat('hotruongluong/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenthanhcong',
'ntcong01',
'01697053312',
'ntcong@hcmut.edu.vn',
'Nguyen Thanh Cong',
'M',
date('2001-07-15'),
concat('nguyenthanhcong/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenhaison',
'sonhainguyenbmt',
'0915559871',
'nhson2001@hcmut.edu.vn',
'Nguyen Hai Son',
'M',
date('2001-02-24'),
concat('nguyenhaison/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'nguyenminhhai',
'minhhaivippro',
'0913737095',
'minhhaideptrai@gmail.com',
'Nguyen Minh Hai',
'M',
date('2001-10-19'),
concat('nguyenminhhai/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'yennhi_01',
'123456',
'091334987',
'yennhi_le@hcmut.edu.vn',
'Le Nguyen Yen Nhi',
'F',
date('2001-04-19'),
concat('yennhi_le/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'linhchidepgai',
'linhchi01',
'0167642349',
'linhchi_lethi@hcmut.edu.vn',
'Le Thi Linh Chi',
'F',
date('2000-12-25'),
concat('linhchidepgai/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

call add_user (
'khanhchann',
'khanhtranxinhdep',
'0918239861',
'tnkhanhtran@hcmut.edu.vn',
'Tran Ngoc Khanh Tran',
'M',
date('2001-03-23'),
concat('khanhchann/avatar_', date_format(now(), "%Y_%j_%H%_%i_%s")),
false,
true
);

INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES ('SAMSUNG','this is description, cool here',1,'2021-11-01');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES ('Lilyeyewear','fashionista',2,'2021-11-02');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('PS','health care',3,'2021-11-03');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('HAHA','health care',4,'2021-11-03');
INSERT INTO shop(shop_name, shop_description, shop_owner_id, create_date) VALUES('HiHi','health care',5,'2021-11-03');


-- Cửa hàng thời trang --
-- Danh mục quần áo
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nữ',200000.00,N'Hàn Quốc',20,N'Vải cotton, Màu trắng, Size M');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nữ',200000.00,N'Hàn Quốc',15,N'Vải cotton, Màu đen, Size S');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nam',150000.00,N'Việt Nam',20,N'Vải cotton, Màu đen, Size L');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Áo thun nam',150000.00,N'Việt Nam',10,N'Vải cotton, Màu đen, Size XL');
-- Danh mục giày dép
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Giày thể thao nữ',500000.00,N'Việt Nam',5,N'Giày thể thao nữ buộc dây siêu nhẹ, Màu trắng, Size 38');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(1,N'Giày thể thao nam',550000.00,N'Việt Nam',8,N'Giày thể thao nam êm ái, Màu đen, Size 42');

-- Cửa hàng điện tử --
-- Danh mục điện thoại
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'iPhone 13 Pro Max',33990000.00,N'Trung Quốc',10,N'RAM: 8GB, ROM: 256GB, Năm sản xuất: 2021');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'iPhone 12',20000000.00,N'Trung Quốc',10,N'RAM: 6GB, ROM: 128GB, Năm sản xuất: 2020');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Samsung Galaxy Z Fold 3',44990000.00,N'Hàn Quốc',10,N'RAM: 12GB, ROM: 512GB, Năm sản xuất: 2021');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Samsung Galaxy A03',4990000.00,N'Hàn Quốc',10,N'RAM: 6GB, ROM: 64GB, Năm sản xuất: 2020');
-- Danh mục laptop
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Asus Vivobook M513UA',18990000.00,N'Trung Quốc',5,N'Chip: R5 5500U, RAM: 8GB, SSD: 512GB, Năm sản xuất: 2021');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(2,N'Lenovo ThinkPad E15',22990000.00,N'Trung Quốc',5,N'Chip: i7 1165G, RAM: 8GB, SSD: 512GB, Năm sản xuất: 2020');

-- Cửa hàng đồ da dụng -- 
-- Danh mục điện da dụng
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Máy xay sinh tố',9990000.00,N'Trung Quốc',10,N'Hãng: Sunhouse, Chất liệu: Nhựa siêu bền');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Nồi chiên không dầu',19990000.00,N'Trung Quốc',10,N'Hãng: Toshiba, Chất liệu: Thép không gỉ');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Ấm đun nước siêu tốc',8990000.00,N'Trung Quốc',10,N'Hãng: Lock&Lock, Chất liệu: Nhựa siêu bền');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Nồi cơm điện',8990000.00,N'Trung Quốc',10,N'Hãng: Cooking, Chất liệu: Nhựa siêu bền');
-- Danh mục dụng cụ da dụn
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Chảo chống dính',2990000.00,N'Trung Quốc',10,N'Hãng: MyCook, Chất liệu: Đá đáy từ');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(3,N'Nồi inox',1990000.00,N'Trung Quốc',10,N'Hãng: Mycook, Chất liệu: Inox');

-- Cửa hàng sách --
-- Danh mục SGK
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Tập Đọc 1',20000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 1');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Đạo Đức 1',18000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 1');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Ngữ Văn 6',22000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 6');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Toán 6',18000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 6');
-- Danh mục tiểu thuyết
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Nhà nàng ở cạnh nhà tôi',180000.00,N'Việt Nam',50,N'NXB: Thanh niên');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(4,N'Nhà tôi ở cạnh nhà nàng',200000.00,N'Việt Nam',40,N'NXB: Thanh niên');

-- Cửa hàng mỹ phẩm
-- Danh mục son môi
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son lì',180000.00,N'Việt Nam',10,N'Màu: Hồng cánh sen');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son dưỡng',180000.00,N'Việt Nam',10,N'Màu: Không màu');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son Eglips',190000.00,N'Việt Nam',10,N'Màu: Đỏ gạch');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Son thỏi',200000.00,N'Việt Nam',15,N'Màu: Đỏ cam');
-- Danh mục sữa rửa mặt
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Sữa rửa mặt Cosrx',150000.00,N'Việt Nam',10,N'Khối lượng: 320g');
insert into Product (shop_id,product_name,listed_price,origin,remaining_amount,information) values(5,N'Sữa rửa mặt Catephil',200000.00,N'Việt Nam',10,N'Khối lượng: 320g');

insert into cart (user_id) values (1);
insert into cart (user_id) values (2);
insert into cart (user_id) values (3);
insert into cart (user_id) values (4);
insert into cart (user_id) values (5);
insert into cart (user_id) values (6);
insert into cart (user_id) values (7);
insert into cart (user_id) values (8);
insert into cart (user_id) values (9);
insert into cart (user_id) values (10);


-- insert data into contains_product
insert into order_contains_product values (1, 1, 1, 3, 17000);
insert into order_contains_product values (2, 3, 1, 2, 29000);

insert into order_contains_product values (1, 3, 2, 1, 51000);
insert into order_contains_product values (2, 2, 2, 3, 22000);
insert into order_contains_product values (2, 4, 2, 1, 15000);

insert into order_contains_product values (3, 1, 3, 1, 140000);
insert into order_contains_product values (4, 2, 3, 1, 59000);
insert into order_contains_product values (2, 1, 3, 1, 32000);

insert into order_contains_product values (2, 4, 4, 2, 52000);
insert into order_contains_product values (3, 2, 4, 1, 11000);

insert into order_contains_product values (5, 4, 5, 3, 29000);
insert into order_contains_product values (2, 3, 5, 1, 87000);
insert into order_contains_product values (4, 2, 5, 3, 29000);

insert into order_contains_product values (2, 3, 6, 1, 87000);
insert into order_contains_product values (5, 4, 6, 3, 29000);
insert into order_contains_product values (2, 5, 6, 1, 87000);

insert into order_contains_product values (5, 4, 7, 3, 29000);
insert into order_contains_product values (2, 3, 7, 1, 87000);

insert into order_contains_product values (3, 2, 8, 2, 53000);
insert into order_contains_product values (2, 4, 8, 1, 69000);
insert into order_contains_product values (1, 3, 8, 2, 30000);

insert into order_contains_product values (1, 4, 9, 2, 29000);
insert into order_contains_product values (2, 2, 9, 2, 117000);

insert into order_contains_product values (4, 5, 10, 4, 6000);
insert into order_contains_product values (2, 2, 10, 3, 9000);
insert into order_contains_product values (5, 3, 10, 3, 29000);

insert into order_contains_product values (2, 2, 11, 3, 38000);
insert into order_contains_product values (1, 3, 11, 1, 57000);

insert into order_contains_product values (5, 1, 12, 1, 87000);
insert into order_contains_product values (3, 3, 12, 1, 229000);

-- table User_manage_shop
ALTER TABLE User_manage_shop
ADD CONSTRAINT ums_shopfk
FOREIGN KEY (Shop_id) REFERENCES shop(Shop_id);

ALTER TABLE User_manage_shop
ADD CONSTRAINT ums_userfk
FOREIGN KEY (User_id) REFERENCES the_user(User_id);

-- table shipping_unit

-- table cart_contain_product
ALTER TABLE cart_contain_product
ADD CONSTRAINT cnp_prodshopfk
FOREIGN KEY (Product_id,Shop_id) REFERENCES product(Product_id,Shop_id);

ALTER TABLE cart_contain_product
ADD CONSTRAINT cnp_cartuserfk
FOREIGN KEY (Cart_id,User_id) REFERENCES cart(Cart_id,User_id);

-- end-----------------------------------------------------------------------------

-- add product_id 30 of shop_id 5 into cart of user_id 2
call add_product_into_cart(2,2,30,5,2,200000);
call add_product_into_cart(1,1,29,5,1,100000);
select * from cart_contain_product;
call get_product_info_in_cart(3,"DESC");
call get_total_money_in_cart_and_user_info(200000,"DESC");
select * from order_contains_product where order_id = 3;
select num_of_product_type_in_order(3,2000000);
select * from cart_contain_product where shop_id = 1;
select total_money_pay_shop_in_cart(1);



