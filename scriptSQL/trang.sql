-- Run this script once every git pull


call add_feedback(1,1,
    "great deal",
    4,'2021-11-27',3);
call add_feedback(1,2,
    "White, square and functional, like a librarian",
    4,'2021-11-28',3);
call add_feedback(2,9,
    "high quality",
    4,'2021-11-29',3);
call add_feedback(2,10,
    "great price",
    4,'2021-11-30',4);
call add_feedback(3,14,
    "pencils ever",
    5,'2021-11-30',4);
call add_feedback(2,11,
    "good value",
    3,'2021-12-01',3);
call add_feedback(1,3,
    " It sets us up for criticism. That said - there is no way we can recommend this paper.",
    1,'2021-12-01',4);
call add_feedback(2,8,
    " If you work in an office and know your paper, YOU WILL NOT LIKE THIS PAPER",
    2,'2021-12-02',4);
call add_feedback(3,15,
    " The paper is exactly what I expected.",
    5,'2021-12-02',4);
call add_feedback(1,4,
    " waste of time.",
    1,'2021-12-02',3);
call add_feedback(2,12,
    " Do *NOT* order this product! it may not work and you wont' get a refund.",
    1,'2021-12-02',3);
call add_feedback(4,20,
    "Not new, broken packages.",
    1,'2021-12-02',4);
call add_feedback(1,6,
    "Very much worth the cost",
    5,'2021-12-02',3);
call add_feedback(3,18,
    "I will buy it next times",
    5,'2021-12-02',4);
call add_feedback(1,1,
    "I like it",
    5,'2021-12-02',4);    
-- foreign key at the end of page
USE e_commerce;

-- table shop
DROP TABLE IF EXISTS shop;
CREATE TABLE shop (
    shop_id int not null auto_increment,
    shop_name varchar(25) not null,
    shop_description text,
    shop_owner varchar(9) not null,
    create_date date,
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
    total decimal(12,2) default 0.0,
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
drop procedure if exists add_shop;
delimiter //
create procedure add_shop (
	in ishop_name varchar(25),
    in shop_description text,
    in ishop_owner int,
    in create_date date
)
begin
    if (ishop_owner in (select shop_owner from shop)) then
    begin 
		signal sqlstate '45000' set message_text = "this user already owns a shop";
	end;    
    end if;
    if (ishop_name in (select shop_name from shop)) then 
    begin
		signal sqlstate '45000' set message_text = "this name already is used for a shop";
	end;    
    end if;
	insert into shop(shop_name, shop_description, shop_owner, create_date)
		values (ishop_name, shop_description, ishop_owner, create_date);
end//
delimiter ;

call add_shop (
'Casio',
'Phố Đồng Hồ',
11,
date('2021-11-05')
);

INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES ('SAMSUNG','this is description, cool here',1,'2021-11-01');
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES ('Lilyeyewear','fashionista',2,'2021-11-02');
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES('PS','health care',3,'2021-11-03');
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES('Blue Light','',4,'2021-11-04');
INSERT INTO shop(shop_name, shop_description, shop_owner, create_date) VALUES('Eye Plus','',5,'2021-11-05');

INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(1, 'waiting', '2021-11-23', 1,'Nguyen Trang', 'Phu Yen', '0123456789');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(2, 'processing', '2021-11-23', 2,'Tran Thang', 'TP.HCM', '0123456798');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(3, 'success', '2021-11-27', 3,'Le Hoang Phuc', 'TP.HCM', '0123456700');
INSERT INTO order_detail(shipping_id, order_status, create_date, user_id, sname, saddress,sphone_number )  
VALUES(4, 'success', '2021-11-27', 4,'Le Tuyet Anh', 'TP.HCM', '0123456700');


-- new 30/11/2021 add data to product_category
-- modify derived value;
alter table category
modify column total_product int default 0;
insert into product_category values(1,1,1);
insert into product_category values(1,2,2);
insert into product_category values(1,3,3);
insert into product_category values(1,4,4);
insert into product_category values(1,5,5);
insert into product_category values(2,7,7);
insert into product_category values(2,8,8);
insert into product_category values(2,9,9);
insert into product_category values(3,13,10);
insert into product_category values(4,19,5);
insert into product_category values(5,25,6);

-- hihi
-- individual tasks

DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
    feedback_id int not null auto_increment,
    shop_id int not null,
    product_id int not null,
    review_content text,
    rating int not null,
    create_date date,
    user_id int not null,
    primary key(feedback_id, shop_id, product_id),
    constraint rating_ck check (rating between 0 and 5)
);




-- 1
drop procedure if exists add_feedback;
delimiter //
create procedure add_feedback (
	in shop_id int,
    in product_id int,
    in review_content text,
    in rating int,
    in create_date date,
    in user_id int
)
begin
    if rating < 1 or rating > 5 then 
		signal sqlstate '45000' 
			set message_text = 'rating must be between 1 and 5';
    end if;
	insert into feedback(shop_id, product_id, review_content, rating, create_date, user_id)
		values (shop_id, product_id, review_content, rating, create_date,user_id);
end//
delimiter ;


-- 2.1
drop trigger feedback_check
delimiter |
create trigger feedback_check before insert on feedback
for each row
begin
	if (new.user_id not in (
		select user_id 
        from order_detail, order_contains_product
		where order_detail.order_id = order_contains_product.order_id 
		and new.product_id = order_contains_product.product_id
		and new.shop_id = order_contains_product.shop_id
		and order_detail.order_status = "success"
    ))  then 
    begin 
		signal sqlstate '45000' set message_text = "this user hasn't purchased this product successfully";
	end;
    end if;
    if new.user_id in (
		select user_id
        from feedback
        where user_id = new.user_id and shop_id = new.shop_id and product_id = new.product_id)
	then 
    begin 
		signal sqlstate '45000' set message_text = "this user has sent feedback for this product";
	end;
    end if;
end;
| 
Delimiter ;

-- add feedback- success with user purchased this product when run trigger 2.1 feedback_check
insert into feedback(shop_id, product_id, review_content, rating, create_date,user_id) values(1,1,'okay',3,date('2021-11-27'),5);
call add_feedback(1,3,"fine", 4, date('2021-11-27'),2);
call add_feedback(1,1,"normal", 3, date('2021-11-27'),2);
call add_feedback(1,1,"awesome", 5, date('2021-11-27'),1);
call add_feedback(1,1,"amazming in shop_id = 1", 4, date('2021-11-27'),3);







-- 2.2

drop trigger feedback_update_to_shop
delimiter |
create trigger feedback_update_to_shop after insert on feedback
for each row
begin
	declare number_of_reviews int default 0;
	set number_of_reviews = (select count(*) from shop, feedback where shop.shop_id = feedback.shop_id) - 1;
	update shop
    set rating = (shop.rating*number_of_reviews + new.rating)/(number_of_reviews + 1)
    where shop.shop_id = new.shop_id;
	
end;
| 
Delimiter ;   

-- 3.1
drop procedure if exists get_list_feedbacks_in_order_by_product;
delimiter |
create procedure get_list_feedbacks_in_order_by_product(
    in ishop_id int,
    in iproduct_id int,
    in type_order varchar(4)
    )
begin
    if type_order = "ASC"
    then
    begin
        select *
        from feedback, product
        where feedback.shop_id = ishop_id and feedback.product_id = iproduct_id and product.product_id = iproduct_id
        order by rating;
    end;
    end if;
    -- duplicate code
    if type_order = "DESC"
    then
    begin
        select *
        from feedback, product
        where feedback.shop_id = ishop_id and feedback.product_id = iproduct_id and product.product_id = iproduct_id
        order by rating DESC;
    end;
    end if;
end;
|
Delimiter ;


-- 3.2

drop procedure if exists getFeedbackOfShop
delimiter |
create procedure getFeedbackOfShop(
    in ishop_id int,
    in type_order varchar(4)
    )
begin
	if type_order = ""
    then
    begin 
		select * 
		from product,(
			select product.product_id, count(feedback.product_id) as numFeedback
			from product
            left join feedback
            on product.product_id = feedback.product_id
			group by product.product_id
			) f
		where product.product_id = f.product_id and product.shop_id = ishop_id;
	end;
	end if;	
	if type_order = "ASC"
    then
    begin 
		select * 
		from product,(
			select product.product_id, count(feedback.product_id) as numFeedback
			from product, feedback
			where product.product_id = feedback.product_id
			group by product.product_id
			having count(product.product_id) > 0
			order by count(product.product_id)) f
		where product.product_id = f.product_id and product.shop_id = ishop_id;
	end;
	end if;	
    -- duplicate code
    if type_order = "DESC"
    then
    begin 
		select * 
		from product,(
			select product.product_id, count(feedback.product_id) as numFeedback
			from product, feedback
			where product.product_id = feedback.product_id
			group by product.product_id
			having count(product.product_id) > 0
			order by count(product.product_id) DESC) f
		where product.product_id = f.product_id and product.shop_id = ishop_id;
	end;
	end if;	
end;
| 
Delimiter ;   

-- 4.1 function just calculate the total of order by orderID
DELIMITER $$
DROP function IF EXISTS  getTotal $$
CREATE function getTotal(iorder_id int)
returns int 
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total int default 0;   
    declare iamount int;
    declare iselling_price int;
    DECLARE exit_loop BOOLEAN;   
    DECLARE item_cursor CURSOR FOR
        SELECT amount, selling_price 
        FROM order_contains_product
        where order_id = iorder_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    OPEN item_cursor;
    item_loop: LOOP
        FETCH  item_cursor INTO iamount, iselling_price;
        set total = total + iamount*iselling_price;
        
        IF exit_loop THEN
            CLOSE item_cursor;
            LEAVE item_loop;         
        END IF;
    END LOOP item_loop;
    return total;
   
 END $$
 DELIMITER ;


-- 4.2
drop function if exists get_shop_level;
delimiter //
create function get_shop_level (_shop_id int)
returns varchar(5)
deterministic
begin
	
    declare cnt1 int default 0;
    declare cnt2 int default 0;
    declare cnt3 int default 0;
    declare _level varchar(5) default 'Top N';
    
    set cnt1 = (select count(*)
				from  (
					select *, sum(total) as sumTotal
					from (
						select distinct shop_id, order_detail.order_id, total
						from order_detail, order_contains_product 
						where order_detail.order_id = order_contains_product.order_id ) f
					group by shop_id
					order by sumTotal DESC
					limit 1 ) e 
				where e.shop_id = _shop_id);  
	set cnt2 = (select count(*)
				from  (
					select *, sum(total) as sumTotal
					from (
						select distinct shop_id, order_detail.order_id, total
						from order_detail, order_contains_product 
						where order_detail.order_id = order_contains_product.order_id ) f
					group by shop_id
					order by sumTotal DESC
					limit  2) e 
				where e.shop_id = _shop_id);   
	set cnt3 = (select count(*)
				from  (
select *, sum(total) as sumTotal
					from (
						select distinct shop_id, order_detail.order_id, total
						from order_detail, order_contains_product 
						where order_detail.order_id = order_contains_product.order_id ) f
					group by shop_id
					order by sumTotal DESC
					limit  3) e 
				where e.shop_id = _shop_id);  
	if cnt1 >= 1 then
		set _level = 'Top 1';
	elseif cnt2 >= 1 then
		set _level = 'Top 2';
	elseif cnt3 >= 1 then
		set _level = 'Top 3';	
    end if;
    return _level;
end //
delimiter ;

ALTER TABLE feedback
ADD FOREIGN KEY ( product_id,shop_id) REFERENCES product(product_id,shop_id);
ALTER TABLE feedback
ADD FOREIGN KEY ( user_id) REFERENCES users(user_id);


