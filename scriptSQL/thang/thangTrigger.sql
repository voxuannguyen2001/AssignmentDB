
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










DROP PROCEDURE IF EXISTS get_products_bought_by_user_in_order_of_price;
DELIMITER $$
CREATE PROCEDURE get_products_orderd_by_user_in_order_of_price(
    in the_user_idx int
)
BEGIN
    DECLARE haha TABLE;
    DECLARE hihi TABLE;
    SELECT order_id INTO haha FROM order_detail WHERE order_detail.the_user_id = the_user_idx;
    SELECT product_id, shop_id INTO hihi FROM order_contains_product WHERE order_id = haha.order_id;
    SELECT * FROM product WHERE product_id = hihi.product_id AND shop_id = hihi.shop_id ORDER BY listed_price;
END;

DROP PROCEDURE IF EXISTS get_products_orderd_by_user_in_order_of_price;
DELIMITER $$
CREATE PROCEDURE get_products_orderd_by_user_in_order_of_price(
    in the_user_idx int
)
BEGIN
    SELECT product.product_id, product.listed_price FROM order_detail 
    INNER JOIN order_contains_product AS ocp ON ocp.order_id = order_detail.order_id
    INNER JOIN product ON product.product_id = ocp.product_id AND product.shop_id = ocp.shop_id
    WHERE order_detail.the_user_id = the_user_idx ORDER BY product.listed_price;
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

DROP FUNCTION IF EXISTS funca;
DELIMITER $$
CREATE FUNCTION funcb(
    in shop_idx int
    in yearx int
)
BEGIN
   

END;

DELIMITER $$
DROP function IF EXISTS  func $$
CREATE function func( 
    shop_idx int,
    yearx int)
returns decimal(12,2)
READS SQL DATA
DETERMINISTIC
BEGIN

END $$
DELIMITER ;  



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
    total decimal(10,2) default 0.0,
    primary key(order_id)
);


















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


ALTER TABLE order_detail ADD total decimal(10,2) default 0.0;



DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
    feedback_id int not null auto_increment,
    shop_id int not null,
    product_id int not null,
    review_content text,
    rating int not null,
    create_date date,
    the_user_id int not null,
    primary key(feedback_id, shop_id, product_id),
    constraint rating_ck check (rating between 0 and 5)
);
 
ALTER TABLE feedback
ADD FOREIGN KEY ( product_id,shop_id) REFERENCES product(product_id,shop_id);
ALTER TABLE feedback
ADD FOREIGN KEY (the_user_id) REFERENCES the_user(the_user_id);
