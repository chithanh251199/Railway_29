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


/*2. Vi???t l???nh ?????
a) L???y t???t c??? c??c sinh vi??n ch??a c?? ????? t??i h?????ng d???n*/

SELECT * FROM `Sinhvien` WHERE `Masv` NOT IN (SELECT Distinct `Masv` FROM `HuongDan`);

/*b) L???y ra s??? sinh vi??n l??m ????? t??i ???CONG NGHE SINH HOC???*/

SELECT * FROM `Sinhvien` SV RIGHT JOIN `HuongDan` HD ON SV.Masv = HD.Masv GROUP BY SV.Masv HAVING `Madt` = 1;

/*3. T???o view c?? t??n l?? "SinhVienInfo" l???y c??c th??ng tin v??? h???c sinh bao g???m:
m?? s???, h??? t??n v?? t??n ????? t??i
(N???u sinh vi??n ch??a c?? ????? t??i th?? column t??n ????? t??i s??? in ra "Ch??a c??")*/

CREATE VIEW SinhVienInfo AS(
SELECT SV.Masv, SV.Hoten, DT.Tendt FROM `Sinhvien` SV LEFT JOIN `HuongDan` HD ON SV.Masv = HD.Masv LEFT JOIN `detai` DT ON HD.Madt = DT.Madt) ;

SELECT * FROM SinhVienInfo;

/*4. T???o trigger cho table SinhVien khi insert sinh vi??n c?? n??m sinh <= 1900
th?? hi???n ra th??ng b??o "n??m sinh ph???i > 1900" */

DROP TRIGGER IF EXISTS insertSinhvien;

DELIMITER $$ 
CREATE TRIGGER insertSinhvien 
	BEFORE INSERT ON `Sinhvien`
    FOR EACH ROW
    BEGIN 
		IF NEW.`Namsinh` <=  '19000101' THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'n??m sinh ph???i > 19000101';
        END IF;
    END $$
DELIMITER ;

begin WORK;

SELECT * FROM sv_thuc_tap.sinhvien;

INSERT INTO `sv_thuc_tap`.`sinhvien` (`Masv`, `Hoten`, `Namsinh`, `Quequan`) VALUES ('127', 'Nguyen van F', '18001201', 'Quang Ngai');

SELECT * FROM sv_thuc_tap.sinhvien;

ROLLBACK;

/*5. H??y c???u h??nh table sao cho khi x??a 1 sinh vi??n n??o ???? th?? s??? t???t c??? th??ng
tin trong table HuongDan li??n quan t???i sinh vi??n ???? s??? b??? x??a ??i*/

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
