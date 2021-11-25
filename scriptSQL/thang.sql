-- Run this script once every git pull

USE e_commerce;

-- table product
DROP TABLE IF exists product;
CREATE TABLE product (
product_id int not null,
shop_id char(9) not null,
product_name varchar(100) CHARSET utf8 not null,
listed_price decimal(12,2) not null,
origin varchar(100) CHARSET utf8,
remaining_amount int,
information varchar(300) CHARSET utf8,

primary key (product_id, shop_id)
);

ALTER TABLE product
ADD FOREIGN KEY (shop_id) REFERENCES shop(shop_id);

-- Cửa hàng thời trang --
-- Danh mục quần áo
insert into product values('000000001','111111111',N'Áo thun nữ',200000.00,N'Hàn Quốc',20,N'Vải cotton, Màu trắng, Size M');
insert into product values('000000002','111111111',N'Áo thun nữ',200000.00,N'Hàn Quốc',15,N'Vải cotton, Màu đen, Size S');
insert into product values('000000003','111111111',N'Áo thun nam',150000.00,N'Việt Nam',20,N'Vải cotton, Màu đen, Size L');
insert into product values('000000004','111111111',N'Áo thun nam',150000.00,N'Việt Nam',10,N'Vải cotton, Màu đen, Size XL');
-- Danh mục giày dép
insert into product values('000000005','111111111',N'Giày thể thao nữ',500000.00,N'Việt Nam',5,N'Giày thể thao nữ buộc dây siêu nhẹ, Màu trắng, Size 38');
insert into product values('000000006','111111111',N'Giày thể thao nam',550000.00,N'Việt Nam',8,N'Giày thể thao nam êm ái, Màu đen, Size 42');

-- Cửa hàng điện tử --
-- Danh mục điện thoại
insert into product values('000000007','222222222',N'iPhone 13 Pro Max',33990000.00,N'Trung Quốc',10,N'RAM: 8GB, ROM: 256GB, Năm sản xuất: 2021');
insert into product values('000000008','222222222',N'iPhone 12',20000000.00,N'Trung Quốc',10,N'RAM: 6GB, ROM: 128GB, Năm sản xuất: 2020');
insert into product values('000000009','222222222',N'Samsung Galaxy Z Fold 3',44990000.00,N'Hàn Quốc',10,N'RAM: 12GB, ROM: 512GB, Năm sản xuất: 2021');
insert into product values('000000010','222222222',N'Samsung Galaxy A03',4990000.00,N'Hàn Quốc',10,N'RAM: 6GB, ROM: 64GB, Năm sản xuất: 2020');
-- Danh mục laptop
insert into product values('000000011','222222222',N'Asus Vivobook M513UA',18990000.00,N'Trung Quốc',5,N'Chip: R5 5500U, RAM: 8GB, SSD: 512GB, Năm sản xuất: 2021');
insert into product values('000000012','222222222',N'Lenovo ThinkPad E15',22990000.00,N'Trung Quốc',5,N'Chip: i7 1165G, RAM: 8GB, SSD: 512GB, Năm sản xuất: 2020');

-- Cửa hàng đồ da dụng -- 
-- Danh mục điện da dụng
insert into product values('000000013','333333333',N'Máy xay sinh tố',9990000.00,N'Trung Quốc',10,N'Hãng: Sunhouse, Chất liệu: Nhựa siêu bền');
insert into product values('000000014','333333333',N'Nồi chiên không dầu',19990000.00,N'Trung Quốc',10,N'Hãng: Toshiba, Chất liệu: Thép không gỉ');
insert into product values('000000015','333333333',N'Ấm đun nước siêu tốc',8990000.00,N'Trung Quốc',10,N'Hãng: Lock&Lock, Chất liệu: Nhựa siêu bền');
insert into product values('000000016','333333333',N'Nồi cơm điện',8990000.00,N'Trung Quốc',10,N'Hãng: Cooking, Chất liệu: Nhựa siêu bền');
-- Danh mục dụng cụ da dụng
insert into product values('000000017','333333333',N'Chảo chống dính',2990000.00,N'Trung Quốc',10,N'Hãng: MyCook, Chất liệu: Đá đáy từ');
insert into product values('000000018','333333333',N'Nồi inox',1990000.00,N'Trung Quốc',10,N'Hãng: Mycook, Chất liệu: Inox');

-- Cửa hàng sách --
-- Danh mục SGK
insert into product values('000000019','444444444',N'Tập Đọc 1',20000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 1');
insert into product values('000000020','444444444',N'Đạo Đức 1',18000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 1');
insert into product values('000000021','444444444',N'Ngữ Văn 6',22000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 6');
insert into product values('000000022','444444444',N'Toán 6',18000.00,N'Việt Nam',100,N'NXB: Bộ Giáo Dục và Đào Tạo, Lớp: 6');
-- Danh mục tiểu thuyết
insert into product values('000000023','444444444',N'Nhà nàng ở cạnh nhà tôi',180000.00,N'Việt Nam',50,N'NXB: Thanh niên');
insert into product values('000000024','444444444',N'Nhà tôi ở cạnh nhà nàng',200000.00,N'Việt Nam',40,N'NXB: Thanh niên');

-- Cửa hàng mỹ phẩm
-- Danh mục son môi
insert into product values('000000025','555555555',N'Son lì',180000.00,N'Việt Nam',10,N'Màu: Hồng cánh sen');
insert into product values('000000026','555555555',N'Son dưỡng',180000.00,N'Việt Nam',10,N'Màu: Không màu');
insert into product values('000000027','555555555',N'Son Eglips',190000.00,N'Việt Nam',10,N'Màu: Đỏ gạch');
insert into product values('000000028','555555555',N'Son thỏi',200000.00,N'Việt Nam',15,N'Màu: Đỏ cam');
-- Danh mục sửa rửa mặt
insert into product values('000000029','555555555',N'Sữa rửa mặt Cosrx',150000.00,N'Việt Nam',10,N'Khối lượng: 320g');
insert into product values('000000030','555555555',N'Sữa rửa mặt Catephil',200000.00,N'Việt Nam',10,N'Khối lượng: 320g');













