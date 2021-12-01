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
    SELECT oder_id from order_contains_product where shop_id = shop_idx;

END;

-- tính tổng doanh thu của một shop_id trong 1 năm