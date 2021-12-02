DROP TRIGGER IF EXISTS before_insert_order_contains_product;
DELIMITER $$
CREATE TRIGGER before_insert_order_contains_product 
BEFORE INSERT ON order_contains_product 
FOR EACH ROW
BEGIN
    DECLARE newAmount int;
    DECLARE curAmount int;
    DECLARE curPrice decimal(12,2);
    
    SELECT remaining_amount INTO curAmount FROM product WHERE (product.product_id = new.product_id and product.shop_id = new.shop_id); 
    SET newAmount = curAmount - new.amount;
    IF newAmount < 0 THEN
        SET new.amount = curAmount;  
        UPDATE product SET remaining_amount = 0 WHERE (product_id = new.product_id and shop_id = new.shop_id);
	ELSE
        UPDATE product SET remaining_amount = newAmount WHERE (product_id = new.product_id and shop_id = new.shop_id);
	END IF;
   
    SELECT listed_price INTO curPrice FROM product WHERE (product.product_id = new.product_id and product.shop_id = new.shop_id);
    IF new.selling_price < curPrice THEN
        SET new.selling_price = curPrice;
    END IF;
   
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS before_update_order_contains_product;
DELIMITER $$
CREATE TRIGGER before_update_order_contains_product
BEFORE UPDATE
ON order_contains_product FOR EACH ROW
BEGIN
    DECLARE newAmount int;
    DECLARE curAmount int;
    DECLARE curPrice decimal(12,2);
    
    SELECT remaining_amount INTO curAmount FROM product WHERE (product.product_id = new.product_id and product.shop_id = new.shop_id);
    IF new.amount > old.amount THEN 
        SET newAmount = curAmount - (new.amount - old.amount);
        IF newAmount < 0 THEN
            SET new.amount = curAmount;  
            UPDATE product SET remaining_amount + old.amount = 0 WHERE (product_id = new.product_id and shop_id = new.shop_id);
	    ELSE
            UPDATE product SET remaining_amount = newAmount WHERE (product_id = new.product_id and shop_id = new.shop_id);
	    END IF;
    ELSE
        UPDATE product SET remaining_amount = curAmount + old.amount - new.amount WHERE (product_id = new.product_id and shop_id = new.shop_id);
   
    SELECT listed_price INTO curPrice FROM product WHERE (product.product_id = new.product_id and product.shop_id = new.shop_id);
    IF new.selling_price < curPrice THEN
        SET new.selling_price = curPrice;
    END IF;
END$$    

DELIMITER ;

DROP TRIGGER IF EXISTS before_insert_order_contains_product;
DELIMITER $$
CREATE TRIGGER before_insert_order_contains_product 
BEFORE INSERT ON order_contains_product 
FOR EACH ROW
BEGIN
    DECLARE newAmount int;
    DECLARE curAmount int;
    SELECT remaining_amount INTO curAmount FROM product WHERE (product.product_id = new.product_id and product.shop_id = new.shop_id); 
    SET newAmount = curAmount - new.amount;
    IF newAmount < 0 THEN
        SET new.amount = curAmount;  
        UPDATE product SET remaining_amount = 0 WHERE (product_id = new.product_id and shop_id = new.shop_id);
	ELSE
        UPDATE product SET remaining_amount = newAmount WHERE (product_id = new.product_id and shop_id = new.shop_id);
	END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS after_delete_order_contains_product;
DELIMITER $$
CREATE TRIGGER after_delete_order_contains_product 
AFTER DELETE ON order_contains_product 
FOR EACH ROW
BEGIN
    UPDATE product SET remaining_amount = remaining_amount + old.amount WHERE (product_id = old.product_id and shop_id = old.shop_id);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_products_orderd_by_user_in_order_of_price;
DELIMITER $$
CREATE PROCEDURE get_products_orderd_by_user_in_order_of_price(
    in user_idx int
)
BEGIN
    SELECT DISTINCT product.product_id, product.product_name, product.listed_price FROM order_detail 
    INNER JOIN order_contains_product AS ocp ON ocp.order_id = order_detail.order_id
    INNER JOIN product ON product.product_id = ocp.product_id AND product.shop_id = ocp.shop_id
    WHERE order_detail.user_id = user_idx ORDER BY product.listed_price DESC;
END;


-- lấy danh sách khách hàng sắp xếp theo số lượt mua hàng của shop
DROP PROCEDURE IF EXISTS get_users_orderd_by_number_of_order_from_a_shop;
DELIMITER $$
CREATE PROCEDURE get_users_orderd_by_number_of_order_from_a_shop(
    in shop_idx int
)
BEGIN
    SELECT user.user_id, user.username, SUM(newtable.num) AS total_num FROM user
    INNER JOIN (SELECT order_detail.user_id, COUNT(order_detail.user_id) AS num FROM shop 
                INNER JOIN order_contains_product ON shop.shop_id = order_contains_product.shop_id 
                INNER JOIN order_detail ON order_detail.order_id = order_contains_product.order_id 
                WHERE shop.shop_id = 1 GROUP BY order_contains_product.order_id) AS newtable 
    ON user.user_id = newtable.user_id GROUP BY user.user_id ORDER BY total_num DESC; 
END;

-- tính tổng doanh thu của một shop_id trong 1 năm
DROP FUNCTION IF EXISTS  calculate_total_sales_of_shop_a_year;
DELIMITER $$
CREATE function calculate_total_sales_of_shop_a_year(shop_idx int, yearx int)
RETURNS decimal
READS SQL DATA
DETERMINISTIC
BEGIN
	DECLARE total decimal(12,2) default 0;
    DECLARE exit_loop BOOLEAN default FALSE;  
    DECLARE cur CURSOR FOR
		SELECT order_contains_product.selling_price
		FROM order_contains_product
		INNER JOIN order_detail ON order_detail.order_id = order_contains_product.order_id
		WHERE year(order_detail.create_date) = yearx AND order_contains_product.shop_id = shop_idx;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    OPEN cur;
        the_loop: LOOP
            FETCH cur INTO iselling_price;
            IF exit_loop THEN
                LEAVE the_loop;        
            END IF;
            SET total = total + iselling_price;
        END LOOP the_loop;
	CLOSE cur;
 
    RETURN total;
END $$
DELIMITER ; 

select calculate_total_sales_of_shop_a_year(1,2021);

DROP FUNCTION IF EXISTS  rank_product_based_rating;
DELIMITER $$
CREATE FUNCTION rank_product_based_rating(shop_idx int, product_idx int)
RETURNS varchar(10)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total decimal(8,4) default 0;
    DECLARE countx int default 0;
    DECLARE average decimal(8,4);
    DECLARE result varchar(10);
    DECLARE irating int;
    DECLARE exit_loop BOOLEAN;
    DECLARE cur CURSOR FOR
        SELECT rating
        FROM feedback
        WHERE shop_id = shop_idx AND product_id = product_idx;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    OPEN cur;
        the_loop: LOOP
			FETCH cur INTO irating;
			IF exit_loop THEN
                LEAVE the_loop;         
            END IF;
            SET total = total + irating;
            SET countx = countx + 1;
        END LOOP the_loop;
    CLOSE cur;
    
    IF countx > 0 THEN
		SET average = total/countx;
		IF average > 4.5 THEN
			SET result = 'Great';
		ELSEIF average > 4.0 THEN
			SET result = 'Good';
		ELSEIF average > 3.0 THEN
			SET result = 'Fine';
		ELSE
			SET result = 'Bad';
		END IF;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "There are no feedback for this product";    
	END IF;

    RETURN result;
 END $$
 DELIMITER ;
 
 select rank_product_based_rating(1,10);


DROP TRIGGER IF EXISTS before_insert_order_detail;
DELIMITER $$
CREATE TRIGGER before_insert_order_detail 
BEFORE INSERT ON order_detail 
FOR EACH ROW
BEGIN
    SET new.total = 
END$$
DELIMITER ;