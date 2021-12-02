-- column names are the same, some of function names were changed
-- needed in feedbackmodel.php

-- FUCNTION
-- get total of order, in order.php
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getTotal`(`iorder_id` INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE mytotal int default 0;  
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
        set mytotal = mytotal + iamount*iselling_price;
        IF exit_loop THEN
            CLOSE item_cursor;
            LEAVE item_loop;        
        END IF;
    END LOOP item_loop;
	update order_detail
    set total = mytotal
    where order_id = iorder_id;
    return mytotal;
 END$$
DELIMITER ;


-- PROCEDURE
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

-- feedbackInShop
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFeedbackOfShop`(IN `ishop_id` INT, IN `type_order` VARCHAR(4))
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
end$$
DELIMITER ;


-- TRIGGER
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

