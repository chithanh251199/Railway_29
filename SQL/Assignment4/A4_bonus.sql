CREATE DATABASE ThucTap;
USE ThucTap;
CREATE TABLE TBLKhoa
(Makhoa char(10)primary key,
Tenkhoa char(30),
Dienthoai char(10));
CREATE TABLE TBLGiangVien(
Magv int primary key,
Hotengv char(30),
Luong decimal(5,2),
Makhoa char(10) references TBLKhoa);
CREATE TABLE TBLSinhVien(
Masv int primary key,
Hotensv char(40),
Makhoa char(10) foreign key references TBLKhoa,
Namsinh int,
Quequan char(30));
CREATE TABLE TBLDeTai(
Madt char(10)primary key,
Tendt char(30),
Kinhphi int,
Noithuctap char(30));
CREATE TABLE TBLHuongDan(
Masv int primary key,
Madt char(10) foreign key references TBLDeTai,
Magv int foreign key references TBLGiangVien,
KetQua decimal(5,2));
INSERT INTO TBLKhoa VALUES
(&#39;Geo&#39;,&#39;Dia ly va QLTN&#39;,3855413),
(&#39;Math&#39;,&#39;Toan&#39;,3855411),

(&#39;Bio&#39;,&#39;Cong nghe Sinh hoc&#39;,3855412);
INSERT INTO TBLGiangVien VALUES
(11,&#39;Thanh Binh&#39;,700,&#39;Geo&#39;),
(12,&#39;Thu Huong&#39;,500,&#39;Math&#39;),
(13,&#39;Chu Vinh&#39;,650,&#39;Geo&#39;),
(14,&#39;Le Thi Ly&#39;,500,&#39;Bio&#39;),
(15,&#39;Tran Son&#39;,900,&#39;Math&#39;);
INSERT INTO TBLSinhVien VALUES
(1,&#39;Le Van Son&#39;,&#39;Bio&#39;,1990,&#39;Nghe An&#39;),
(2,&#39;Nguyen Thi Mai&#39;,&#39;Geo&#39;,1990,&#39;Thanh Hoa&#39;),
(3,&#39;Bui Xuan Duc&#39;,&#39;Math&#39;,1992,&#39;Ha Noi&#39;),
(4,&#39;Nguyen Van Tung&#39;,&#39;Bio&#39;,null,&#39;Ha Tinh&#39;),
(5,&#39;Le Khanh Linh&#39;,&#39;Bio&#39;,1989,&#39;Ha Nam&#39;),
(6,&#39;Tran Khac Trong&#39;,&#39;Geo&#39;,1991,&#39;Thanh Hoa&#39;),
(7,&#39;Le Thi Van&#39;,&#39;Math&#39;,null,&#39;null&#39;),
(8,&#39;Hoang Van Duc&#39;,&#39;Bio&#39;,1992,&#39;Nghe An&#39;);
INSERT INTO TBLDeTai VALUES
(&#39;Dt01&#39;,&#39;GIS&#39;,100,&#39;Nghe An&#39;),
(&#39;Dt02&#39;,&#39;ARC GIS&#39;,500,&#39;Nam Dinh&#39;),
(&#39;Dt03&#39;,&#39;Spatial DB&#39;,100, &#39;Ha Tinh&#39;),
(&#39;Dt04&#39;,&#39;MAP&#39;,300,&#39;Quang Binh&#39; );
INSERT INTO TBLHuongDan VALUES
(1,&#39;Dt01&#39;,13,8),
(2,&#39;Dt03&#39;,14,0),
(3,&#39;Dt03&#39;,12,10),
(5,&#39;Dt04&#39;,14,7),
(6,&#39;Dt01&#39;,13,Null),
(7,&#39;Dt04&#39;,11,10),
(8,&#39;Dt03&#39;,15,6);