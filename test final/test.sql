/*
 Student(ID,Name,Age,Gender)
 Subject(ID, Name)
 StudentSubject(StudentID,SubjectID,Mark,Date)
*/
DROP DATABASE IF EXISTS `QLHS`;
CREATE DATABASE IF NOT EXISTS `QLHS`;

USE `QLHS`;

DROP TABLE IF EXISTS `Student`;
CREATE TABLE `Student`(
	`ID` TINYINT UNSIGNED PRIMARY KEY Auto_Increment,
    `Name` VARCHAR(50) NOT NULL,
    `Age` TINYINT UNSIGNED,
    `Gender` BIT
);

INSERT INTO `QLHS`.`Student` (`Name`, `Age`, `Gender`) VALUES ('Nguyen Van A', '21', 1);
INSERT INTO `QLHS`.`Student` (`Name`, `Age`, `Gender`) VALUES ('Nguyen Van C', '22', 0);
INSERT INTO `QLHS`.`Student` (`Name`, `Age`) VALUES ('Nguyen Van B', '22');
INSERT INTO `QLHS`.`Student` (`Name`, `Age`) VALUES ('Nguyen Thi Ly', '22');
INSERT INTO `QLHS`.`Student` (`Name`, `Age`) VALUES ('Nguyen Anh Quan', '22');
SELECT * FROM QLHS.Student;

DROP TABLE IF EXISTS `Subject`;
CREATE TABLE `Subject`(
	`ID` TINYINT UNSIGNED PRIMARY KEY Auto_Increment,
    `Name` VARCHAR(50) NOT NULL
);

INSERT INTO `QLHS`.`Subject` (`Name`) VALUES ('Toan');
INSERT INTO `QLHS`.`Subject` (`Name`) VALUES (' Van');
INSERT INTO `QLHS`.`Subject` (`Name`) VALUES ('Anh');
INSERT INTO `QLHS`.`Subject` (`Name`) VALUES ('Vat Ly');
SELECT * FROM QLHS.Subject;

DROP TABLE IF EXISTS `StudentSubject`;
CREATE TABLE `StudentSubject`(
	StudentID TINYINT UNSIGNED,
    SubjectID TINYINT UNSIGNED,
    Mark TINYINT UNSIGNED,
    Date DATETIME,
	PRIMARY KEY (StudentID, SubjectID)
);

INSERT INTO `QLHS`.`StudentSubject` (`StudentID`, `SubjectID`, `Mark`, `Date`)
 VALUES 
 ('1', '2', '5', '20221201'),
 ('1', '1', '10', '20221210'),
 ('1', '3', '5', '20221201'),
 ('2', '1', '9', '20221201'),
 ('2', '2', '5', '20221201');
 SELECT * FROM QLHS.StudentSubject;

/*
2. Viết lệnh để
a) Lấy tất cả các môn học không có bất kì điểm nào*/
SELECT * FROM `Subject` WHERE ID NOT IN (SELECT Distinct `SubjectID` FROM StudentSubject);

SELECT S.* FROM `Subject` S LEFT JOIN StudentSubject SS ON S.ID = SS.SubjectID WHERE SS.SubjectID IS NULL;

/*
Cau 2: 
b) Lấy danh sách các môn học có ít nhất 2 điểm*/
SELECT S.ID, S.Name, COUNT(SS.SubjectID) AS `Total` FROM `Subject` S LEFT JOIN StudentSubject SS ON S.ID = SS.SubjectID GROUP BY S.ID HAVING `Total` >= 2 ;

/*
3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
Student ID,Subject ID, Student Name, Student Age, Student Gender,
Subject Name, Mark, Date
(Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
'Unknow' thay thế cho null)*/
DROP VIEW IF EXISTS StudentInfo;
CREATE VIEW StudentInfo AS(
	SELECT S1.ID AS `StudentId`, S3.ID AS `SubjectId`, S1.Name AS `StudentName`, S1.Age, 
	CASE 
		WHEN S1.Gender = 1 THEN 'Female' 
		WHEN S1.Gender = 0 THEN 'Male'
		ELSE 'Unknow'
	END AS `Gender`,
	S3.Name AS `SubjectName`, S2.Mark, S2.Date 
	FROM `Student` S1 LEFT JOIN `StudentSubject` S2 ON S1.ID = S2.StudentID LEFT JOIN `Subject` S3 ON S2.SubjectID = S3.ID);

SELECT * FROM StudentInfo;


/*
4. Không sử dụng On Update Cascade & On Delete Cascade
a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
Khi thay đổi data của cột ID của table Subject, thì giá trị tương
ứng với cột SubjectID của table StudentSubject cũng thay đổi
theo*/

DROP TRIGGER IF EXISTS updateSubject;

DELIMITER $$ 
CREATE TRIGGER updateSubject 
	BEFORE UPDATE ON `Subject`
    FOR EACH ROW
    BEGIN 
		UPDATE `StudentSubject` SET SubjectID = NEW.ID WHERE SubjectID = OLD.ID;
    END $$
DELIMITER ;

SET SQL_SAFE_UPDATES = 0;

begin work;
SELECT * FROM QLHS.StudentSubject;
SELECT * FROM QLHS.Subject;

UPDATE `Subject` SET ID = 10 WHERE ID = 1;

SELECT * FROM QLHS.StudentSubject;
SELECT * FROM QLHS.Subject;

rollback;

/*
Cau 4 :
b) Tạo trigger cho table StudentSubject có tên là StudentDeleteID:
Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
cột StudentID của table StudentSubject cũng bị xóa theo*/

DROP TRIGGER IF EXISTS StudentDeleteID;

DELIMITER $$ 
CREATE TRIGGER StudentDeleteID 
	BEFORE DELETE ON `Student`
    FOR EACH ROW
    BEGIN 
		DELETE FROM StudentSubject WHERE StudentID = OLD.ID; 
    END $$
DELIMITER ;

Begin work;
SELECT * FROM QLHS.Student;
SELECT * FROM QLHS.StudentSubject;

DELETE FROM `Student` WHERE ID = 1;

SELECT * FROM QLHS.Student;
SELECT * FROM QLHS.StudentSubject;
rollback;

/*
5. Viết 1 store procedure (có 2 parameters: student name) sẽ xóa tất cả các
thông tin liên quan tới học sinh có cùng tên như parameter
Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
các học sinh
*/

DROP PROCEDURE IF EXISTS deleteStudent;
DELIMITER $$
	CREATE PROCEDURE deleteStudent(IN n VARCHAR(50))
    BEGIN
        IF(n = '*')
			THEN DELETE FROM Student;
		ELSE 
			DELETE FROM Student WHERE `Name` = n; 
		END IF;
    END $$
DELIMITER ;

begin work;
SELECt * FROM `Student`;
CALL deleteStudent('Nguyen Van A');
SELECt * FROM `Student`;
rollback;

begin work;
SELECt * FROM `Student`;
CALL deleteStudent('*');
SELECt * FROM `Student`;
rollback;