alter table order_contains_product 
	add	foreign key(shop_id) references shop(shop_id),
	add	foreign key(product_id) references product(product_id),
    add foreign key(order_id) references order_detail(order_id);

ALTER TABLE order_detail
	ADD FOREIGN KEY (user_id) REFERENCES user(user_id),
	ADD FOREIGN KEY (shipping_id) REFERENCES shipping_unit(shipping_id);

ALTER TABLE shop
	ADD FOREIGN KEY (shop_owner) REFERENCES user(user_id);

ALTER TABLE product_category
	ADD FOREIGN KEY (shop_id, product_id) REFERENCES product(shop_id, product_id),
	ADD FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE user_manage_shop
	ADD CONSTRAINT ums_shopfk
	FOREIGN KEY (shop_id) REFERENCES shop(shop_id);

ALTER TABLE user_manage_shop
	ADD CONSTRAINT ums_userfk
	FOREIGN KEY (user_id) REFERENCES users(user_id);

ALTER TABLE product
	ADD FOREIGN KEY (shop_id) REFERENCES shop(shop_id);

ALTER TABLE cart_contain_product
	ADD CONSTRAINT cnp_prodshopfk
	FOREIGN KEY (product_id,shop_id) REFERENCES product(product_id,shop_id);

ALTER TABLE cart_contain_product
	ADD CONSTRAINT cnp_cartuserfk
	FOREIGN KEY (cart_id, user_id) REFERENCES cart(cart_id, user_id);