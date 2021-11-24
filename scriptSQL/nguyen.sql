-- Run this script once every git pull

use e_commerce;

-- table user
create table user(
	user_id integer not null,
    username varchar(30) not null,
    pass varchar(30) not null,
    mobile varchar(12),
    email varchar(30),
    full_name varchar(50) not null default '',
    sex char(1),
    date_of_birth date,
    avatar blob,
    seller_flag boolean,
    buyer_flag boolean,
    
    primary key(user_id)
);




-- table contains_product
create table contains_product(
	shop_id integer not null,
    product_id integer not null,
    order_id integer not null,
    amount integer not null default 1,
    selling_price integer not null,
    
    primary key(shop_id, product_id, order_id),
    foreign key(shop_id) references shop(shop_id),
    foreign key(product_id) references product(product_id),
    foreign key(order_id) references order_detail(order_id)
)

