-- Trigger khi thêm một row trong bảng order_contains_product, tự động trừ số lượng còn lại của trong bảng product. (chưa kiểm tra âm)

create trigger before_insert_order_contains_product before insert on order_contains_product for each row
    update product set remaining_amount = remaining_amount - new.amount where (product_id id = new.product_id and shop_id id = new.shop_id);