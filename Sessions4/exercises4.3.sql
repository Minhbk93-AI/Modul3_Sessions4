CREATE DATABASE exercises4_3;
USE exercises4_3;

CREATE TABLE VatTu(
 maVT INT PRIMARY KEY AUTO_INCREMENT,
 tenVT VARCHAR(255) NOT NULL
);

CREATE TABLE DonDatHang(
 soDH INT PRIMARY KEY AUTO_INCREMENT,
 maNCC INT,
 ngayDH DATETIME
);
 CREATE TABLE ChiTietDonDatHang(
 maVT INT NOT NULL,
 soDH INT NOT NULL,
 FOREIGN KEY (maVT) REFERENCES VatTu(maVT),
 FOREIGN KEY (soDH) REFERENCES DonDatHang(soDH)
 );

CREATE TABLE NhaCungCap(
 maNCC INT,
 tenNCC VARCHAR(255) NOT NULL,
 diaChi VARCHAR(255) NOT NULL,
 soDienThoai VARCHAR(11) NOT NULL,
 FOREIGN KEY (maNCC) REFERENCES DonDatHang(maNCC)
);

CREATE TABLE PhieuXuat(
 soPx INT PRIMARY KEY AUTO_INCREMENT,
 ngayXuat DATETIME
);

CREATE TABLE PhieuXuatChiTiet(
 soPx INT NOT NULL,
 maVT INT NOT NULL,
 FOREIGN KEY( soPX) REFERENCES PhieuXuat(soPx),
 FOREIGN KEY(maVT) REFERENCES VatTu(maVT),
 donGiaXuat DOUBLE,
 soLuongXuat INT
);

CREATE TABLE PhieuNhap(
 soPn INT PRIMARY KEY AUTO_INCREMENT,
 ngayNhap DATETIME
);

CREATE TABLE PhieuNhapChiTiet(
 soPn INT NOT NULL,
 maVT INT NOT NULL,
 FOREIGN KEY (soPn) REFERENCES PhieuNhap(soPn),
 FOREIGN KEY (maVT) REFERENCES VatTu(maVT),
 donGiaNhap DOUBLE,
 soLuongNhap INT
);

INSERT INTO VatTu (tenVT)
VALUES ('Cement'), ('Steel'), ('Bricks'), ('Paint'), ('Tiles'), ('Sand'), ('Wood'), ('Glass'), ('Pipes'), ('Nails');

INSERT INTO DonDatHang (maNCC, ngayDH) 
VALUES (1, '2024-02-15'), (2, '2024-02-16'), (3, '2024-01-10'), (4, '2024-03-05'), (5, '2024-02-20');

INSERT INTO NhaCungCap (tenNCC, diaChi, soDienThoai)
VALUES ('Supplier A', '123 Supplier St', '0912345678'), 
       ('Supplier B', '456 Supply Blvd', '0987654321'), 
       ('Supplier C', '789 Material Ave', '0901234567'),
       ('Supplier D', '321 Industry Rd', '0945678901'),
       ('Supplier E', '654 Build Ln', '0976543210');

INSERT INTO PhieuXuatChiTiet (soPx, maVT, donGiaXuat, soLuongXuat)
VALUES (1, 1, 120, 50), (1, 2, 150, 30), (2, 3, 60, 100), (3, 4, 200, 20), (4, 5, 90, 70), 
       (4, 6, 50, 150), (5, 7, 75, 25), (6, 8, 180, 10), (6, 9, 300, 5), (6, 10, 10, 500);

INSERT INTO PhieuNhapChiTiet (soPn, maVT, donGiaNhap, soLuongNhap)
VALUES (1, 1, 100, 200), (1, 2, 140, 120), (2, 3, 55, 300), (3, 4, 195, 40), (3, 5, 80, 90), 
       (4, 6, 45, 500), (5, 7, 70, 80), (5, 8, 175, 60), (6, 9, 280, 15), (6, 10, 8, 600);
   
--  Hiển thị tất cả vật tư dựa vào phiếu xuất có số lượng lớn hơn 10:   
SELECT v.tenVT, pxct.soLuongXuat, pxct.donGiaXuat
FROM VatTu v
JOIN PhieuXuatChiTiet pxct ON v.maVT = pxct.maVT
WHERE pxct.soLuongXuat > 10;

--  Hiển thị tất cả vật tư mua vào ngày 12/02/2023:
SELECT v.tenVT, d.ngayDH
FROM VatTu v
JOIN ChiTietDonDatHang ctd ON v.maVT = ctd.maVT
JOIN DonDatHang d ON ctd.soDH = d.soDH
WHERE DATE(d.ngayDH) = '2023-02-12';

-- Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 1.200.000:
SELECT v.tenVT, pnct.donGiaNhap
FROM VatTu v
JOIN PhieuNhapChiTiet pnct ON v.maVT = pnct.maVT
WHERE pnct.donGiaNhap > 1200000;

-- Hiển thị tất cả vật tư dựa vào phiếu xuất có số lượng lớn hơn 5:
SELECT v.tenVT, pxct.soLuongXuat, pxct.donGiaXuat
FROM VatTu v
JOIN PhieuXuatChiTiet pxct ON v.maVT = pxct.maVT
WHERE pxct.soLuongXuat > 5;

-- Hiển thị tất cả nhà cung cấp ở Long Biên có số điện thoại bắt đầu với '09':
SELECT tenNCC, diaChi, soDienThoai
FROM NhaCungCap
WHERE diaChi LIKE '%Long Biên%' AND soDienThoai LIKE '09%';
