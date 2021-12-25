DROP DATABASE IF EXISTS `SV_Thuc_tap`;

CREATE DATABASE IF NOT EXISTS `SV_Thuc_tap`;

USE `SV_Thuc_tap`;

DROP TABLE IF EXISTS `Giangvien` ;

CREATE TABLE IF NOT EXISTS `Giangvien`(
	`Magv`		int PRIMARY KEY ,
    `Hoten` 	VARCHAR(100),
    `Luong` 	INT
) ;

INSERT INTO `sv_thuc_tap`.`giangvien` (`Magv`, `Hoten`, `Luong`) VALUES ('123', 'Ngo van An', '8000000');
INSERT INTO `sv_thuc_tap`.`giangvien` (`Magv`, `Hoten`, `Luong`) VALUES ('124', 'Nguyen thi Huyen', '7000000');
INSERT INTO `sv_thuc_tap`.`giangvien` (`Magv`, `Hoten`, `Luong`) VALUES ('125', 'nguyen thi Van', '7000000');
INSERT INTO `sv_thuc_tap`.`giangvien` (`Magv`, `Hoten`, `Luong`) VALUES ('126', 'Nguyen van hai', '9000000');


DROP TABLE IF EXISTS `Sinhvien` ;

CREATE TABLE IF NOT EXISTS `Sinhvien`(
	`Masv`		int PRIMARY KEY,
    `Hoten`	 	VARCHAR(100),
    `Namsinh`	DATETIME,
    `Quequan`	VARCHAR(100)
) ;

INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('121', 'Nguyen van A', '19991201', 'nam dinh');
INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('122', 'nguyen van B', '200001010', 'thai nguyen');
INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('123', 'Nguyen thi C', '200010201', 'ha noi');
INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('124', 'Nguyen thi D', '20000202', 'thai nguyen');
INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('125', 'Nguyen thi E', '2000-03-03', 'lao cai');



DROP TABLE IF EXISTS `DeTai`;

CREATE TABLE IF NOT EXISTS `DeTai`(
	`Madt` 			INT PRIMARY KEY,
    `Tendt`			VARCHAR(100),
    `Kinhphi`		INT,
    `NoiThucTap`	VARCHAR(100)
) ;

INSERT INTO `sv_thuc_tap`.`detai` (`Madt`, `Tendt`, `Kinhphi`, `NoiThucTap`) VALUES ('1', 'CONG NGHE SINH HOC', '40000000', 'ha noi');
INSERT INTO `sv_thuc_tap`.`detai` (`Madt`, `Tendt`, `Kinhphi`, `NoiThucTap`) VALUES ('2', 'CONG NGHE HOA HOC', '50000000', 'da nang');
INSERT INTO `sv_thuc_tap`.`detai` (`Madt`, `Tendt`, `Kinhphi`, `NoiThucTap`) VALUES ('3', 'NGHIEN CUU TOAN HOC', '30000000', 'sai gon');
INSERT INTO `sv_thuc_tap`.`detai` (`Madt`, `Tendt`, `Kinhphi`, `NoiThucTap`) VALUES ('4', 'KY THUAT CONG NGHIEP', '30000000', 'ha noi');


DROP TABLE IF EXISTS `HuongDan` ;

CREATE TABLE IF NOT EXISTS `HuongDan`(
	`ID` INT PRIMARY KEY,
    `Masv` INT,
    `Madt` INT,
    `Magv` INT,
    `Ketqua` VARCHAR(100)
) ;

INSERT INTO `sv_thuc_tap`.`huongdan` (`ID`, `Masv`, `Madt`, `Magv`, `Ketqua`) VALUES ('1', '121', '1', '123', 'DAT');
INSERT INTO `sv_thuc_tap`.`huongdan` (`ID`, `Masv`, `Madt`, `Magv`, `Ketqua`) VALUES ('2', '122', '1', '125', 'TOT');
INSERT INTO `sv_thuc_tap`.`huongdan` (`ID`, `Masv`, `Madt`, `Magv`, `Ketqua`) VALUES ('3', '121', '3', '123', 'KHONG DAT');
INSERT INTO `sv_thuc_tap`.`huongdan` (`ID`, `Masv`, `Madt`, `Magv`, `Ketqua`) VALUES ('4', '123', '2', '124', 'DAT');
INSERT INTO `sv_thuc_tap`.`huongdan` (`ID`, `Masv`, `Madt`, `Magv`, `Ketqua`) VALUES ('5', '124', '5', '126', 'TOT');


/*2. Viết lệnh để
a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn*/

SELECT * FROM `Sinhvien` WHERE `Masv` NOT IN (SELECT Distinct `Masv` FROM `HuongDan`);

/*b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’*/

SELECT * FROM `Sinhvien` SV RIGHT JOIN `HuongDan` HD ON SV.Masv = HD.Masv GROUP BY SV.Masv HAVING `Madt` = 1;

/*3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:
mã số, họ tên và tên đề tài
(Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")*/

CREATE VIEW SinhVienInfo AS(
SELECT SV.Masv, SV.Hoten, DT.Tendt FROM `Sinhvien` SV LEFT JOIN `HuongDan` HD ON SV.Masv = HD.Masv LEFT JOIN `detai` DT ON HD.Madt = DT.Madt) ;

SELECT * FROM SinhVienInfo;

/*4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900
thì hiện ra thông báo "năm sinh phải > 1900" */

DROP TRIGGER IF EXISTS insertSinhvien;

DELIMITER $$ 
CREATE TRIGGER insertSinhvien 
	BEFORE INSERT ON `Sinhvien`
    FOR EACH ROW
    BEGIN 
		IF NEW.`Namsinh` <=  '19000101' THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'năm sinh phải > 19000101';
        END IF;
    END $$
DELIMITER ;

begin WORK;

SELECT * FROM sv_thuc_tap.sinhvien;

INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('127', 'Nguyen van F', '18001201', 'Quang Ngai');

SELECT * FROM sv_thuc_tap.sinhvien;

ROLLBACK;

/*5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông
tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi*/

DROP PROCEDURE IF EXISTS deleteSinhvien;
DELIMITER $$
	CREATE PROCEDURE deleteSinhvien(IN n INT)
    BEGIN
        DELETE FROM `Sinhvien` WHERE `Masv` = n;
        DELETE FROM `Huongdan` WHERE `Masv` = n;
    END $$
DELIMITER ;

begin WORK;

SELECT * FROM sv_thuc_tap.sinhvien;

SELECT * FROM sv_thuc_tap.huongdan;

CALL deleteSinhvien(121);

SELECT * FROM sv_thuc_tap.sinhvien;

SELECT * FROM sv_thuc_tap.huongdan;

ROLLBACK;
