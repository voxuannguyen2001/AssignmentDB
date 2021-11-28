-- Trigger khi thêm một row trong bảng order_contains_product, tự động trừ số lượng còn lại của trong bảng product. (chưa kiểm tra âm)

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
DELIMITER;


DROP TRIGGER IF EXISTS after_delete_order_contains_product;
DELIMITER $$
CREATE TRIGGER after_delete_order_contains_product 
AFTER DELETE ON order_contains_product 
FOR EACH ROW
BEGIN
    UPDATE product SET remaining_amount = remaining_amount + old.amount WHERE (product_id = old.product_id and shop_id = old.shop_id);
END$$
DELIMITER;