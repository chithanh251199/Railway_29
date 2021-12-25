-- database để quản lý điểm của học sinh
DROP DATABASE IF EXISTS `Bang_Diem`;

CREATE DATABASE IF NOT EXISTS `Bang_diem`;

USE `Bang_Diem`;

DROP TABLE IF EXISTS `Student`;

CREATE TABLE IF NOT EXISTS `Student`(
	`ID` 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Name` 		VARCHAR(100) NOT NULL,
    `Age`		TINYINT UNSIGNED,
    `Gender`	BIT 
);

DROP TABLE IF EXISTS `Subject`;

CREATE TABLE IF NOT EXISTS `Subject`(
	`ID` 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Name`		VARCHAR(100) NOT NULL
);


DROP TABLE IF EXISTS `StudenSubject`;

CREATE TABLE IF NOT EXISTS `StudentSubject`(
	`StudentID` TINYINT UNSIGNED ,
    `SubjectID`	TINYINT UNSIGNED ,
    `Mark`		TINYINT UNSIGNED,
    `Date`		DATETIME,
	PRIMARY KEY (`StudentID`,`SubjectID`)
    
);

INSERT INTO 	`Student` 	(`Name`			, 		`Age`, 	`Gender`)
VALUES						('Nguyen van an' ,		20 ,	 1 	),
							('nguyen thi chau',	 	19 ,	 0 	),
                            ('nguyen hoang long',	 21 ,	 1 	),
                            ('nguyen thi thao',	 	18 ,	NULL ),
							('nguyen thi huyen',	19 ,	 0	);
                            
INSERT INTO 	`Subject`	(`Name`)
VALUES						('Matth'),
							('Chemistry'),
                            ('Physics'),
                            ('English'),
							('Literature');
		
INSERT INTO		`StudentSubject` 	(`StudentID`, `SubjectID`, `Mark`	, `Date`)
VALUES								(1,				1,			'8'  	, 20211212),
									(1,				5,			'6'  	, 20211112),
                                    (3,				3,			'8'  	, 20211012),
                                    (3,				4,			'7'  	, 20211211),
                                    (2,				2,			'10'  	, 20211010);
                                    
                                    
                                    
INSERT INTO `bang_diem`.`StudentSubject` (`StudentID`, `SubjectID`, `Mark`, `Date`)
 VALUES 
 ('1', '2', '5', '20221201'),
 ('1', '1', '10', '20221210'),
 ('1', '3', '5', '20221201'),
 ('2', '1', '9', '20221201'),
 ('2', '2', '5', '20221201');
 SELECT * FROM QLHS.StudentSubject;
-- Lấy tất cả các môn học không có bất kì điểm nào

SELECT S.* FROM `Subject` S
LEFT JOIN `StudentSubject` SS ON S.ID = SS.SubjectID
WHERE 	SS.Mark IS NULL;

SELECT S.* FROM `Subject` S LEFT JOIN  `studentsubject` ON ID = SubjectID GROUP BY SubjectID HAVING (count(SubjectID) = 0) ;

SELECT * FROM `Subject` WHERE ID  NOT IN (SELECT DISTINCT `SubjectID` FROM StudentSubject); 

-- Lấy danh sách các môn học có ít nhất 2 điểm
SELECT S.Name, count(SS.Mark) AS `Total`
FROM `Subject` S
LEFT JOIN `StudentSubject` SS ON S.ID = SS.SubjectID
GROUP BY S.ID
HAVING `Total` >= 2;

SELECT S.* FROM `Subject` S LEFT JOIN  `studentsubject` ON ID = SubjectID GROUP BY SubjectID HAVING (count(SubjectID) = 2) ;

SELECT S.ID, S.Name,count(SS.SubjectID) AS `Total` FROM `Subject` S LEFT JOIN  `studentsubject` SS ON S.ID = SS.SubjectID GROUP BY S.ID
HAVING `Total` = 2;


/*Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
Student ID,Subject ID, Student Name, Student Age, Student Gender,
Subject Name, Mark, Date
(Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
'Unknow' thay thế cho null)*/

SELECT * FROM `Student` S LEFT JOIN  `StudentSubject` SS ON S.ID = SS.StudentID LEFT JOIN `Subject` SJ ON SS.SubjectID = SJ.id;

DROP VIEW IF EXISTS StudentInfo;
CREATE VIEW StudentInfo AS(
SELECT S.ID AS `StudentID`,SJ.ID AS `SubjectID`, S.Name AS `StudentName`, S.Age,
	CASE S.Gender
		WHEN  1 THEN 'Female'
        WHEN  0 THEN 'Male'
        ELSE 'Unknow'
	END AS `Gender`,
    SJ.Name AS `SubjectName`, SS.Mark, SS.Date FROM `Student` S 
LEFT JOIN  `StudentSubject` SS ON S.ID = SS.StudentID 
LEFT JOIN `Subject` SJ ON SS.SubjectID = SJ.id);

SELECT * FROM StudentInfo;

/*4. Không sử dụng On Update Cascade & On Delete Cascade
a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
Khi thay đổi data của cột ID của table Subject, thì giá trị tương
ứng với cột SubjectID của table StudentSubject cũng thay đổi
theo */

DROP TRIGGER IF EXISTS updateSubject;
DELIMITER $$
CREATE TRIGGER updateSubject
	BEFORE UPDATE ON `Subject`
	FOR EACH ROW
	BEGIN
		UPDATE `studentsubject` SET SubjectID = NEW.ID WHERE SubjectID = OLD.ID;
    END $$
DELIMITER ;

BEGIN WORK;
SELECT * FROM bang_diem.subject;
SELECT * FROM bang_diem.studentsubject;

UPDATE `Subject` SET  ID = 10 WHERE ID = 1;

SELECT * FROM bang_diem.subject;
SELECT * FROM bang_diem.studentsubject;
ROLLBACK;

/*b) Tạo trigger cho table StudentSubject có tên là StudentDeleteID:
Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
cột StudentID của table StudentSubject cũng bị xóa theo*/



DROP TRIGGER IF EXISTS StudentDeleteID;
DELIMITER $$
CREATE TRIGGER StudentDeleteID
	BEFORE UPDATE ON `Student`
	FOR EACH ROW
	BEGIN
		DELETE FROM `studentsubject` WHERE StudentID = OlD.ID;
    END $$
DELIMITER ;

BEGIN WORK;
SELECT * FROM bang_diem.subject;
SELECT * FROM bang_diem.studentsubject;

DELETE FROM `Student` WHERE ID = 1;

SELECT * FROM bang_diem.subject;
SELECT * FROM bang_diem.studentsubject;
ROLLBACK;

/*Viết 1 store procedure (có 2 parameters: student name) sẽ xóa tất cả các
thông tin liên quan tới học sinh có cùng tên như parameter
Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
các học sinh*/

DROP PROCEDURE IF EXISTS deleteStudent;
DELIMITER $$
CREATE PROCEDURE deleteStudent(IN n VARCHAR(50))
	BEGIN
		IF(n = '*')
			THEN DELETE FROM `Student`;
		ELSE
			DELETE FROM `Student` WHERE `Name` = n;
		END IF;
	END$$
DELIMITER ;

BEGIN WORK;
SELECT * FROM `Student`;

CALL deleteStudent('nguyen van an');

SELECT * FROM `Student`;
ROLLBACK;




							