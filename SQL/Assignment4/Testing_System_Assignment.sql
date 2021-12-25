-- lệnh xóa database.
DROP DATABASE IF EXISTS `Testing_System_Assignment4`;

-- lệnh tạo database.
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment4`;

-- lệnh sử dụng database để làm việc. 
USE `Testing_System_Assignment4`;

-- lệnh xóa bảng. 

DROP TABLE IF EXISTS `Department`;

-- lệnh tạo bảng và dữ liệu.

/*Table 1:Department
 DepartmentID: định danh của phòng ban (auto increment)
 DepartmentName: tên đầy đủ của phòng ban (VD: sale, marketing, ...)*/
CREATE TABLE IF NOT EXISTS `Department` (
		`DepartmentID` 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		`DepartmentName` 	VARCHAR(50) NOT NULL
);

/*Table 2: Position
 PositionID: định danh của chức vụ (auto increment)
 PositionName: tên chức vụ (Dev, Test, Scrum Master, PM)*/

DROP TABLE IF EXISTS `Position`;

 CREATE TABLE IF NOT EXISTS `Position`(
		`PositionID` 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `PositionName` 	ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
); 


/*Table 3: Account
 AccountID: định danh của User (auto increment)
 Email:
 Username:
 FullName:
 DepartmentID: phòng ban của user trong hệ thống
 PositionID: chức vụ của User
 CreateDate: ngày tạo tài khoản*/
DROP TABLE IF EXISTS `Account`;

CREATE TABLE IF NOT EXISTS `Account`(
		`AccountID` 	MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `Email` 		VARCHAR(100) NOT NULL UNIQUE,
        `UserName` 		VARCHAR(50) NOT NULL UNIQUE,
        `FullName`		VARCHAR(50) NOT NULL UNIQUE,
        `DepartmentID`	TINYINT UNSIGNED DEFAULT 0,
        `PositionID`	TINYINT UNSIGNED,
        `Createdate` 	DATETIME,
        CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department`(`DepartmentID`) ON UPDATE SET NULL ON DELETE CASCADE,
        CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position`(`PositionID`) ON UPDATE SET NULL ON DELETE CASCADE
);


/*Table 4: Group
 GroupID: định danh của nhóm (auto increment)
 GroupName: tên nhóm
 CreatorID: id của người tạo group
 CreateDate: ngày tạo group*/
DROP TABLE IF EXISTS `Group`;

CREATE TABLE IF NOT EXISTS `Group` (
		`GroupID` 		MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `GroupName` 	VARCHAR(50) NOT NULL,
        `CreatorID`		MEDIUMINT UNSIGNED,
        `Createdate`	DATETIME
);


/*Table 5: GroupAccount
 GroupID: định danh của nhóm
 AccountID: định danh của User
 JoinDate: Ngày user tham gia vào nhóm*/
DROP TABLE IF EXISTS `GroupAccount`;

CREATE TABLE IF NOT EXISTS `GroupAccount`(
		`GroupID` 		MEDIUMINT,
        `AccountID`		MEDIUMINT,
        `JoinDate`		DATETIME DEFAULT NOW()
);


/*Table 6: TypeQuestion
 TypeID: định danh của loại câu hỏi (auto increment)
 TypeName: tên của loại câu hỏi (Essay, Multiple-Choice)*/
DROP TABLE IF EXISTS `TypeQuestion`;

CREATE TABLE IF NOT EXISTS `TypeQuestion`(
		`TypeID` 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `TypeName`		ENUM('ESSAY', 'Multiple-Choice')
);


/*Table 7: CategoryQuestion
 CategoryID: định danh của chủ đề câu hỏi (auto increment)
 CategoryName: tên của chủ đề câu hỏi (Java, .NET, SQL, Postman, Ruby,
...)*/
DROP TABLE IF EXISTS `CategoryQUestion`;

CREATE TABLE IF NOT EXISTS `CategoryQuestion`(
		`CategoryID` 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `CategoryName`	ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);
/*Table 8: Question
 QuestionID: định danh của câu hỏi (auto increment)
 Content: nội dung của câu hỏi
 CategoryID: định danh của chủ đề câu hỏi
 TypeID: định danh của loại câu hỏi
 CreatorID: id của người tạo câu hỏi
 CreateDate: ngày tạo câu hỏi*/
DROP TABLE IF EXISTS `QUestion`;
      
CREATE TABLE IF NOT EXISTS `Question`(
		`QuestionID` 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `Content`		VARCHAR(50),
        `CategoryID`	TINYINT UNSIGNED ,
        `TypeID`		TINYINT UNSIGNED,
        `CreatorID`		MEDIUMINT UNSIGNED,
        `CreateDate`		DATETIME,
        CONSTRAINT fk_cg_id FOREIGN KEY (`categoryID`) REFERENCES `CategoryQuestion`(`CategoryID`) ON UPDATE SET NULL ON DELETE CASCADE,
        CONSTRAINT fk_tp_id FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion`(`TypeID`) ON UPDATE SET NULL ON DELETE CASCADE,
		CONSTRAINT fk_ct_id FOREIGN KEY (`CreatorID`) REFERENCES `Account`(`AccountID`) ON UPDATE SET NULL ON DELETE CASCADE
);

/*Table 9: Answer
 AnswerID: định danh của câu trả lời (auto increment)
 Content: nội dung của câu trả lời
 QuestionID: định danh của câu hỏi
 isCorrect: câu trả lời này đúng hay sai*/

DROP TABLE IF EXISTS `Answer`;

CREATE TABLE IF NOT EXISTS `Answer`(
		`AnswerID` 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `Content` 		VARCHAR(50),
        `QuestionID` 	TINYINT UNSIGNED,
        `IsCorrect`		BIT,
        CONSTRAINT fk_q_id FOREIGN KEY (`QuestionID`) REFERENCES `Question`(`QuestionID`)  ON UPDATE SET NULL ON DELETE CASCADE
);

/*Table 10: Exam
 ExamID: định danh của đề thi (auto increment)
 Code: mã đề thi
 Title: tiêu đề của đề thi
 CategoryID: định danh của chủ đề thi
 Duration: thời gian thi
 CreatorID: id của người tạo đề thi
 CreateDate: ngày tạo đề thi*/

DROP TABLE IF EXISTS `Exam`;

CREATE TABLE IF NOT EXISTS `Exam`(
		`ExamID` 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `Code`			VARCHAR(50) NOT NULL,
        `Title`			VARCHAR(50) NOT NULL,
        `CategoryID` 	TINYINT UNSIGNED,
        `Duration`		TINYINT,
        `CreatorID`		MEDIUMINT UNSIGNED,
        `CreateDate`  	DATETIME,
        CONSTRAINT fk_ex_1 FOREIGN KEY (`CreatorID`) REFERENCES `Account`(`AccountID`)  ON UPDATE SET NULL ON DELETE CASCADE,
        CONSTRAINT fk_ex_2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion`(`CategoryID`)  ON UPDATE SET NULL ON DELETE CASCADE
);

/*Table 11: ExamQuestion
 ExamID: định danh của đề thi
 QuestionID: định danh của câu hỏi*/

DROP TABLE IF EXISTS `ExamQuestion`;

CREATE TABLE IF NOT EXISTS `ExamQuestion`(
		`ExamID` 		TINYINT UNSIGNED,
        `QuestionID`	TINYINT UNSIGNED,
	    CONSTRAINT fk_eq_1 FOREIGN KEY (`ExamID`) REFERENCES `Exam`(`ExamID`) ON UPDATE SET NULL ON DELETE CASCADE,
		CONSTRAINT fk_eq_2 FOREIGN KEY (`QuestionID`) REFERENCES `Question`(`QuestionID`)  ON UPDATE SET NULL ON DELETE CASCADE
);

/*Question 3: Chuẩn bị data cho bài 3
Insert data vào 11 table, mỗi table có ít nhất 5 records để (Ví dụ như
trong ảnh dưới đây) */

INSERT INTO  	`Department` 	(`DepartmentName`)
VALUES							(' phong ky thuat 1'),
								(' phong ky thuat 2'),
								(' phong ky thuat 3'),
								(' phong DEV 1'),
								(' phong DEV 2'),
								(' phong sale 1'),
								(' phong sale 2'),
								(' phong marketing'),
								(' phong giam doc'),
								(' phong tai chinh');


INSERT INTO 	`Position` 		(`PositionName`)
VALUES							('DEV'),
								('Test'),
                                ('Scrum Master'),
                                ('PM');
                                
INSERT INTO 	`Account`		(`Email`, 			`Username`, 	`Fullname`, 		`DepartmentID`, `PositionID`, `CreateDate`)
VALUES							('an@gmail.com' , 	'VTI1' , 		'Nguyen van an' , 			1 , 		1 , 		20191212),
								('van@gmail.com' , 	'VTI2' , 		'Nguyen van van' , 			2, 			1 , 		20191112),
                                ('son@gmail.com' , 	'VTI3' , 		'Nguyen van son' , 			1 , 		2 , 		20191211),
                                ('hieu@gmail.com' , 'VTI4' , 		'Nguyen van hieu' , 		3 , 		1 , 		20191012),
                                ('hoa@gmail.com' , 	'VTI5' , 		'Nguyen van hoa' , 			1 , 		3, 			20191210),
                                ('hien@gmail.com' , 'VTI6' , 		'Nguyen van hien' , 		2 , 		3 , 		20190912),
                                ('tung@gmail.com' , 'VTI7' , 		'Nguyen van tung' , 		3 , 		2 , 		20191209),
                                ('long@gmail.com' , 'VTI8' , 		'Nguyen van long' , 		4 , 		2 , 		20190812),
                                ('loc@gmail.com' ,	'VTI9' , 		'Nguyen van loc' , 			1 , 		4 , 		20191208),
                                ('lieu@gmail.com' , 'VTI10' , 		'Nguyen van lieu' , 		2 , 		4 , 		20190712);
                                
INSERT INTO  	`Group`			(`GroupName`,	`CreatorID`,		`CreateDate`)
VALUES							('Nhom 1',			'1' , 			20190403),
								('Nhom 2',			'2' , 			20190304),
                                ('Nhom 3',			'3' , 			20190102),
                                ('Nhom 4',			'4' , 			20190201),
                                ('Nhom 5',			'5' , 			20190501),
                                ('Nhom 6',			'5' , 			20190105),
                                ('Nhom 7',			'4' , 			20191211),
                                ('Nhom 8',			'3' , 			20191112),
                                ('Nhom 9',			'2' , 			20191010),
                                ('Nhom 10',			'1' ,	 		20191020);

INSERT INTO 	`GroupAccount`	(`GroupID`, 	`AccountID`, 		`JoinDate`)
VALUES							('1',			 '1', 				20210501),
								('2',			 '2', 				20210401),
                                ('3',			 '3', 				20210301),
                                ('4',			 '4', 				20210201),
                                ('5',			 '4', 				20210101),
                                ('6',			 '3', 				20210701),
                                ('7',			 '2', 				20210801),
                                ('8',			 '1', 				20210901),
                                ('9',			 '2', 				20211001),
                                ('10',			 '3', 				20211101);
                                
INSERT INTO	 	`TypeQuestion`	(`TypeName`)
VALUES 							('ESSAY'),
								('Multiple-Choice');
                                
INSERT INTO 	`CategoryQuestion` 	(`CategoryName`)
VALUES								('Java'), 
									('SQL'),
									('.NET'),
									('Ruby'),
									('Python'),
									('NodeJS'),
									('HTML'),
									('CSS'),
									('JavaScript');

INSERT INTO		 `Question`		(`Content`,		 CategoryID, 	TypeID, 	CreatorID, 		CreateDate)
VALUES							('Câu hỏi Java 1',	 2,   		 2, 			1, 			20210401),
								('Câu hỏi Java 2', 	 2, 		 2, 			2, 			20200101),
								('Câu hỏi SQL 1',	 1,			 1,			    10,			20210701),
								('Câu hỏi SQL 2',	 1,			 2, 			5, 			20210601),
								('Câu hỏi .NET 1',	 3, 		 1, 		 	2,			20211001),
								('Câu hỏi .NET 2',	 3,			 2,				2,			20211101),
								('Câu hỏi Ruby',	 2,   		 2, 			1, 			20210501),
								('Câu hỏi Python',	 2,   		 2, 			1, 			20210801),
								('Câu hỏi Nodejs',	 2,   		 2, 			1, 			20210901);
                                
INSERT INTO		 `Answer`		(`Content`, `QuestionID`, `isCorrect`)
VALUES 							('Câu trả lời 1 - question SQL 1', 1, 1),
								('Câu trả lời 2 - question SQL 1', 1, 0),
								('Câu trả lời 3 - question SQL 1', 1, 0),
								('Câu trả lời 4 - question SQL 1', 1, 1),
								('Câu trả lời 1 - question SQL 2', 2, 0),
								('Câu trả lời 2 - question SQL 2', 2, 0),
								('Câu trả lời 3 - question SQL 2', 2, 0),
								('Câu trả lời 4 - question SQL 2', 2, 1),
								('Câu trả lời 1 - question Java 1', 3, 0),
								('Câu trả lời 2 - question Java 1', 3, 1),
								('Câu trả lời 1 - question Java 2', 4, 0),
								('Câu trả lời 2 - question Java 2', 4, 0),
								('Câu trả lời 3 - question Java 2', 4, 0),
								('Câu trả lời 4 - question Java 2', 4, 1),
								('Câu trả lời 1 - question HTML 1', 5, 1),
								('Câu trả lời 2 - question HTML 2', 5, 0);
                                
INSERT INTO	 `Exam`		(`Code`,		 `Title`, 		`CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES 					('MS_01', 		'De thi 01',		 1, 		90, 		1, 				NOW()),
						('MS_02', 		'De thi 02',		 1, 		60,			 5,			 NOW()),
						('MS_03',		 'De thi 03',		 2, 		60, 		9, 			NOW()),
						('MS_04', 		'De thi 04',		 2,		 	90,			 1,			 NOW()),
						('MS_05',		 'De thi 05',		 1, 		60,			 2,			 NOW()),
						('MS_06', 		'De thi 06',		 2,			90,			 2,			 NOW()),
						('MS_07',		 'De thi 07',		 1,		 	60, 		1,			 NOW());

INSERT INTO `ExamQuestion`
VALUES		 (1, 1),
			(2, 1),
			(3, 1),
			(4, 1),
			(5, 2),
			(6, 2),
			(7, 2);
			


/*Question 1: Thêm ít nhất 10 record vào mỗi table*/

/*Question 2: lấy ra tất cả các phòng ban*/

SELECT * FROM `Department`;

/*Question 3: lấy ra id của phòng ban "Sale"*/
 
SELECT `DepartmentID` FROM `Department` WHERE DepartmentName LIKE '%sale%';

/*Question 4: lấy ra thông tin account có full name dài nhất*/

SELECT * FROM `Account`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`) ORDER BY Fullname DESC;
 
SELECT *, character_length(Fullname) AS `lenght` FROM `Account` WHERE character_length(Fullname) = 
(SELECT character_length(Fullname) AS `lenght` FROM `Account` ORDER BY `lenght` DESC LIMIT 1); 

/*Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3*/
SELECT AccountID, Fullname, DepartmentID, character_length(Fullname) AS `length` FROM `Account`
WHERE character_length(Fullname)  = (SELECT MAX(LENGTH(Fullname)) FROM `Account` WHERE DepartmentID = 3) AND DepartmentID = 3;

/*Question 6: Lấy ra tên group đã tạo trước ngày 20/12/2019*/

SELECT * FROM `Group` WHERE Createdate < '2019/12/20';


/*Question 7: Lấy ra ID của question có >= 4 câu trả lời*/

SELECT * FROM testing_system_assignment3.answer ORDER BY QuestionID ;
SELECT QuestionID, count(QuestionID) AS `SL` FROM answer 
GROUP BY QuestionID
HAVING count(QuestionID) >=4;


/*Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày
20/12/2019*/



SELECT `code`, Title, CategoryID, Duration, CreatorID, CreateDate from `Exam` WHERE Duration >= 60 AND CreateDate < 20191220;

SELECT * from `Exam` WHERE Duration >= 60 AND CreateDate < 20191220;

SELECT `code` from `Exam` WHERE Duration >= 60 AND CreateDate < 20191220;


/*Question 9: Lấy ra 5 group được tạo gần đây nhất*/

SELECT * FROM `Group` ORDER BY CreateDate DESC LIMIT 5;

/*Question 10: Đếm số nhân viên thuộc department có id = 2*/

SELECT * FROM testing_system_assignment3.account ORDER BY DepartmentID ;

SELECT DepartmentID , count(DepartmentID) AS `SL NV` FROM `Account` WHERE DepartmentID = 2;

SELECT DepartmentID , count(*) AS `SL NV` FROM `Account` GROUP BY DepartmentID HAVING DepartmentID = 2;


/*Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"*/

SELECT Fullname FROM `Account` WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o' ;

SELECT * FROM `Account` WHERE Fullname LIKE '%D_o%'; -- hoặc SELECT * FROM `Account` WHERE Fullname LIKE '%D%o%';

/*Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019*/

-- tắt safe mode 
SET SQL_SAFE_UPDATES = 0;

DELETE FROM `Exam` WHERE CreateDate < 20191220;

/*Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"*/

SET SQL_SAFE_UPDATES = 0;

DELETE FROM `Question` WHERE Content LIKE '%Câu hỏi%';

DELETE FROM `question` WHERE (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi';

/*Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và
email thành loc.nguyenba@vti.com.vn*/

UPDATE `Account` SET Fullname = 'Nguyen Ba Loc', Email =  'loc.nguyenba@VTI.com.vn' WHERE AccountID = 5;

SELECT * FROM `Account`; 

/*Question 15: update account có id = 5 sẽ thuộc group có id = 4*/

SET SQL_SAFE_UPDATES = 0;

UPDATE `GroupAccount` SET AccountID = 5 WHERE GroupID = 4;

-- UNION : dùng để nối 2 câu lệnh.

SELECT * FROM
(SELECT Content, '' AS `Name` FROM `Question`
UNION
SELECT DepartmentID, DepartmentName FROM `Department`) AS `Tampe` WHERE Content = 1;

SELECT Content, '' AS `Name` FROM `Question`
UNION
SELECT DepartmentID, DepartmentName FROM `Department`;

-- Join nối các bảng để lấy thêm thông tin. 

SELECT AccountID, UserName, A.DepartmentID, D.DepartmentID, DepartmentName FROM `Account` A-- hoặc AS A (đặt tên cho Account) 
INNER JOIN 
Department D ON A.DepartmentID = D.DepartmentID ;

SELECT QuestionID, COUNT(QuestionID) AS `Sl` FROM ExamQuestion GROUP BY QuestionID;

SELECT COUNT(QuestionID) AS `Sl` FROM ExamQuestion GROUP BY QuestionID ORDER BY `SL` DESC LIMIT 1 ;

SELECT QuestionID,Content, COUNT(QuestionID) AS `Sl` FROM ExamQuestion JOIN question USING(QuestionID) GROUP BY QuestionID 
HAVING COUNT(QuestionID) = (SELECT COUNT(QuestionID) AS `Sl` FROM ExamQuestion GROUP BY QuestionID ORDER BY `SL` DESC LIMIT 1 );

SELECT MAX(`Countques`) FROM


Question 8: Lấy ra Question có nhiều câu trả lời nhất;


SELECT * FROM question;

SELECT * FROM `answer`;

SELECT COUNT(QuestionID) AS `Total` FROM `answer`

SELECT MAX(QuestionID) FROM 
(SELECT COUNT(QuestionID) AS `Total` FROM answer GROUP BY QuestionID ORDER BY `Total` DESC LIMIT 1);

/*cau10*/

SELECT * FROM `Position`;

SELECT * FROM `Account`;

SELECT P.PositionName, P.PositionID, COUNT(A.PositionID) AS `Total` FROM `Account` A RIGHT JOIN  `position` P ON A.PositionID = P.PositionID GROUP BY P.PositionID 
HAVING COUNT(A.PositionID) = (SELECT COUNT(A.PositionID) AS `Total` FROM `account` A 
RIGHT JOIN `position` P  ON A.PositionID = P.PositionID GROUP BY P.PositionID ORDER BY `Total` LIMIT 1);

/*cau 11*/
SELECT * FROM position;

SELECT * FROM department CROSS JOIN position ORDER BY DepartmentID, PositionID;

SELECT * FROM `Account`;

SELECT DP.DepartmentID, DP.PositionID, DP.DepartmentName, DP.PositionName, COUNT(AccountID) AS `SL` FROM (SELECT * FROM department CROSS JOIN position ) DP LEFT JOIN `Account` A 
ON DP.DepartmentID = A.DepartmentID AND DP.PositionID = A.PositionID
GROUP BY DP.DepartmentID, DP.PositionID
ORDER BY DP.DepartmentID, DP.PositionID ;

SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) as maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);

SELECT DP.DepartmentID, DP.PositionID , DP.DepartmentName, DP.PositionName , COUNT(AccountID) AS `Total` FROM (SELECT * FROM Department CROSS JOIN Position) DP LEFT JOIN `Account` A
ON DP.DepartmentID = A.DepartmentID AND DP.PositionID = A.PositionID
GROUP BY DP.DepartmentID, DP.PositionID
ORDER BY DP.DepartmentID, DP.PositionID;


SELECT DP.DepartmentID, DP.PositionID , DP.DepartmentName, DP.PositionName, 
 IF (COUNT(AccountID) = 0 , 'Khong co nv', COUNT(AccountID)) AS `Total`
FROM (SELECT * FROM Department CROSS JOIN Position) DP LEFT JOIN `Account` A
ON DP.DepartmentID = A.DepartmentID AND DP.PositionID = A.PositionID
GROUP BY DP.DepartmentID, DP.PositionID
ORDER BY DP.DepartmentID, Total DESC;


SELECT if(1<2, 'dung', 'sai 1<2') AS `Test`;

SELECT
	CASE
		WHEN 1>2 then '1>2'
        WHEN 1<2 then '1<2'
	END AS `Test`;
    

SELECT DP.DepartmentID, DP.PositionID , DP.DepartmentName, DP.PositionName, 
	CASE 
		WHEN COUNT(AccountID) = 0 THEN 'khong co nv'
        WHEN COUNT(AccountID) = 1 THEN 'co 1 nv'
        ELSE COUNT(AccountID)
	END AS `ToTal`
FROM (SELECT * FROM Department CROSS JOIN Position) DP LEFT JOIN `Account` A
ON DP.DepartmentID = A.DepartmentID AND DP.PositionID = A.PositionID
GROUP BY DP.DepartmentID, DP.PositionID
ORDER BY DP.DepartmentID, Total DESC;

-- sử dụng view
DROP VIEW IF EXISTS v_exq;
CREATE VIEW v_exq AS
		SELECT EQ.ExamID, EQ.QuestionID, Q.Content FROM ExamQuestion EQ JOIN question Q ON Q.QuestionID = EQ.QuestionID;

SELECT * FROM v_exq;

SELECT
	QuestionID,
    Content,
    Count(QuestionID) AS 'Total'
FROM
	v_exq
GROUP BY QuestionID;


WITH CTE_EXQ AS
	(SELECT * FROM examquestion EQ JOIN question Q  USING (QuestionID))
    SELECT * FROM CTE_EXQ WHERE QuestionID IN 
    (SELECT QuestionID FROM CTE_EXQ WHERE QuestionID = 1 OR QuestionID = 3);


CREATE VIEW v_GRA AS
	SELECT	GA.GroupID, G.GroupName, A.FullName FROM groupaccount GA 
    LEFT JOIN `account` A ON GA.AccountID = GA.AccountID
    LEFT JOIN `Group` G ON GA.GroupID = G.GroupID;
    
SELECT * FROM v_GRA;
    
SELECT * FROM v_GRA
WHERE GroupID = 1
UNION
SELECT * FROM v_GRA
WHERE GroupID = 2;

SELECT GroupID, count(GroupID) AS `Total` FROM v_GRA GROUP BY (GroupID) HAVING Total >=4 AND Total < 7 ;



SELECT * FROM department WHERE DepartmentName like '%Sale%';

DROP PROCEDURE getDepartmentInfo;

DELiMITER $$
	CREATE PROCEDURE getDepartmentInfo(IN nameDp VARCHAR(150), IN idDP INT)
    BEgin
		SELECT * FROM Department WHERE DepartmentName Like nameDP;
        
        SELECT * FROM department WHERE DepartmentID = idDP;
	END $$
DELIMITER ;

CALL getDepartmentInfo('', 1);
CALL getDepartmentInfo('%DEV%', 2);

DELiMITER $$
	CREATE PROCEDURE getDepartmentInfo(IN nameDp VARCHAR(150), out idDP INT)
    BEgin
		SELECT DepartmentID INTO idDP  FROM department WHERE DepartmentName = nameDP;
	END $$
DELIMITER ;

DELiMITER $$
	DELiMITER $$
	CREATE PROCEDURE getDepartmentInfo(IN idDP INT, OUT nameOut VARCHAR(100))
    BEgin
		SELECT DepartmentName INTO nameOut  FROM department WHERE DepartmentID = idDP;
	END $$
DELIMITER ;

SET @id = 'A';
CALL getDepartmentInfo(20, @id);

SELECT @id;

/*nhap vao ten phong ban va in ra Account thuoc phong ban do*/

DELiMITER $$
	DELiMITER $$
	CREATE PROCEDURE getDepartmentInfo(IN nameDp VARCHAR(100))
    BEgin
    /*tao 1 bien id de luu tam thoi id cua phong ban*/
		DECLARE id INT;
        /*tim ID cua phong ban co ten truyen vao*/
		SELECT DepartmentName INTO id FROM Department WHERE DepartmentName = nameDP;
        /*dung bien id  de select ra tat ca account  thuoc phong ban tren*/
        SELECT * FROM `Account` WHERE DepartmentID = id;
	END $$
DELIMITER ;
CALL getDepartmentInfo('phong ky thuat 1');

CALL getDepartmentInfo('phong sale');

/*nhap vao ten chuc vu va ten phong ban va in ra Account lam chuc vu do va o phong ban do*/

DELiMITER $$
	CREATE PROCEDURE getAccountInfo(IN nameDP VARCHAR(100), IN namePS VARCHAR(100))
    BEgin
    /*tao 1 bien id de luu tam thoi id cua phong ban*/
		DECLARE id INT;
        DECLARE id1 INT;
		SELECT PositionID INTO id FROM position WHERE PositionName = namePS;
        SELECT departmentID INTO id1 FROM department WHERE DepartmentName = nameDP;
	END $$
DELIMITER ;

CALL getAccountInfo();

/* truyen vao id Account lay ra ten phong ban va ten chuc vu*/
DELiMITER $$
	CREATE PROCEDURE getAccountInfo(IN idAC INT, OUT nameDP VARCHAR(100), OUT nameP VARCHAR(100))
    BEgin
    
		DECLARE idDepartment, idPosition INT;
        
		SELECT DepartmentID, PositionID INTO idDepartment, idPosition FROM `ACCOUNT` WHERE AccountID = idAC;
        
		SELECT DepartmentName INTO nameP FROM Department WHERE DepartmentID = idDepartment;
        
        SELECT PositionName INTO nameP FROM Position WHERE PositionID = idPosition;
	END $$
DELIMITER ;

CALL getAccountInfo(6, @dName, @pName);

SELECT @dName, @pName;