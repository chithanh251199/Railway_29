-- lệnh xóa database.
DROP DATABASE IF EXISTS `Testing_System_Assignment6`;

-- lệnh tạo database.
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment6`;

-- lệnh sử dụng database để làm việc. 
USE `Testing_System_Assignment6`;

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
						('MS_07',		 'De thi 07',		 1,		 	60, 		1,			 NOW()),
                        ('MS_17',		 'De thi 17',		 2,		 	60, 		2,			 NOW()),
                        ('MS_18',		 'De thi 18',		 1,		 	90, 		1,			 NOW());

INSERT INTO `ExamQuestion`
VALUES		 (1, 1),
			(2, 1),
			(3, 1),
			(4, 1),
			(5, 2),
			(6, 2),
			(7, 2);
            
/*Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
account thuộc phòng ban đó*/

DROP PROCEDURE IF EXISTS sp_GetAccFromDep;
DELIMITER $$
CREATE PROCEDURE sp_GetAccFromDep(IN in_dep_name NVARCHAR(50))
BEGIN
SELECT A.AccountID, A.FullName, D.DepartmentName FROM `account` A
INNER JOIN department D ON D.DepartmentID = A.DepartmentID
WHERE D.DepartmentName = in_dep_name;
END$$
DELIMITER ;
Call sp_GetAccFromDep('Sale');


/* rut gon*/
DROP PROCEDURE IF EXISTS GetAccFromDep;
DELIMITER $$
CREATE PROCEDURE GetAccFromDep(IN nameDP VARCHAR(50))
BEGIN
	DECLARE id INT;

	SELECT DepartmentName INTO id FROM department WHERE DepartmentName = nameDp;

	SELECT * FROM `Account` WHERE DepartmentID = id;

END$$
DELIMITER ;
Call GetAccFromDep('phong DEV 1');

-- cach 2

 DROP PROCEDURE IF EXISTS GetAccFromDep;
DELIMITER $$
CREATE PROCEDURE GetAccFromDep(IN nameDP VARCHAR(50))
BEGIN
	SELECT A.* FROM `Account` A JOIN Department USING(DepartmentID) WHERE DepartmentName = nameDP;

END$$
DELIMITER ;
Call GetAccFromDep('phong DEV 1');

/*Question 2: Tạo store để in ra số lượng account trong mỗi group*/

DROP PROCEDURE IF EXISTS GetCountAccFromGroup;
DELIMITER $$
CREATE PROCEDURE GetCountAccFromGroup(IN nameG VARCHAR(50))
BEGIN
SELECT G.GroupName, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN `group` G ON GA.GroupID = G.GroupID
WHERE G.GroupName = nameG;
END$$
DELIMITER ;
Call GetCountAccFromGroup('Testing_System_Assignment6');

--

DROP PROCEDURE IF EXISTS GetCountTotalAcc;
DELIMITER $$
CREATE PROCEDURE GetCountTotalAcc()
BEGIN
	SELECT G.GroupName, G.GroupID, Count(GA.GroupID) AS `Sl` FROM GroupAccount GA RIGHT JOIN `Group` G ON G.GroupID = GA.GroupID GROUP BY GroupID;

END$$
DELIMITER ;
Call GetCountTotalAcc();
 

/*Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
trong tháng hiện tại*/

SELECT month(now());

DROP PROCEDURE IF EXISTS GetCountTypeInMonth;
DELIMITER $$
CREATE PROCEDURE GetCountTypeInMonth()
BEGIN
SELECT TQ.TypeName, count(Q.TypeID) FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
WHERE month(Q.CreateDate) = month(now()) AND year(Q.CreateDate) = year(now())
GROUP BY Q.TypeID;
END$$
DELIMITER ;
Call GetCountTypeInMonth();

DROP PROCEDURE IF EXISTS GetCountQuestionInTypeQuestrion;
DELIMITER $$
CREATE PROCEDURE GetCountQuestionInTypeQuestrion()
BEGIN
	SELECT TQ.*, count(Q.QuestionID) AS `Total`
	FROM Typequestion TQ LEFT JOIN Question Q ON TQ.TypeID = Q.TypeID 
	WHERE Month(Q.CreateDate) = month(now()) AND year(Q.CreateDate) = year(now())
	GROUP BY TQ.TypeID;
END$$
DELIMITER ;
Call GetCountQuestionInTypeQuestrion();

/*Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất*/

DROP PROCEDURE IF EXISTS GetCountTypeQuestrion;
DELIMITER $$
CREATE PROCEDURE GetCountTypeQuestrion()
BEGIN
	SELECT TQ.*, count(Q.QuestionID) AS `Total`
	FROM Typequestion TQ JOIN Question Q ON TQ.TypeID = Q.TypeID 
	GROUP BY TQ.TypeID
    HAVING Count(Q.QuestionID) = (SELECT count(Q.QuestionID) AS `Total`
	FROM Typequestion TQ JOIN Question Q ON TQ.TypeID = Q.TypeID 
    GROUP BY TQ.TypeID ORDER BY `Total` DESC LIMIT 1);
END$$
DELIMITER ;
Call GetCountTypeQuestrion();

DROP PROCEDURE IF EXISTS GetCountTypeQuestion;
DELIMITER $$
CREATE PROCEDURE GetCountTypeQuestrion()
BEGIN
	SELECT TQ.TypeID INTO id
			FROM TypeQuestion TQ JOIN Question Q ON TQ.TypeID = Q.TypeID
            GROUP BY TQ.TypeID ORDER BY count(Q.QuestionID) DESC LIMIT 1;
END$$
DELIMITER ;
Call GetCountTypeQuestion();

/*Question 5: Sử dụng store ở question 4 để tìm ra tên của type question*/

/*Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
chuỗi của người dùng nhập vào*/

DROP PROCEDURE IF EXISTS GetGroupIDOrAccountID;
DELIMITER $$
CREATE PROCEDURE GetGroupIDOrAccountID(IN n VARCHAR(100), OUT groupID INT ,OUT acID INT )
BEGIN
	DECLARE id INT;
    SELECT GroupID INTO id FROM `Group` WHERE GroupName = n;
    IF(id IS NOT NULL)
		THEN SET groupID = id;
    END IF;
    
    SELECT AccountID INTO id FROM `Account`WHERE UserName = n;
    IF(id IS NOT NULL)
		THEN SET acID= id;
    END IF;
    
END$$
DELIMITER ;
Call GetGroupIDOrAccountID('Nhom 2', @groupID, @acID);

SELECT	@groupID, @acID;

-- cach 1
DROP PROCEDURE getGroupIDOrAccountID;
DELIMITER $$
	CREATE PROCEDURE getGroupIDOrAccountID(IN n VARCHAR(50))
    BEGIN
		DECLARE idG, idA INT;
        SELECT GroupID INTO idG FROM `Group` WHERE GroupName = n;
        IF(idG IS NOT NULL)
			THEN SELECT * FROM `Group` WHERE GroupID = idG;
		END IF;
		SELECT AccountID INTO idA FROM `Account` WHERE UserName = n;
        IF(idA IS NOT NULL)
			THEN SELECT * FROM `Account` WHERE AccountID = idA;
		END IF;
    END $$
DELIMITER ;

-- cach 2
  
DROP PROCEDURE getGroupIDOrAccountID;
DELIMITER $$
	CREATE PROCEDURE getGroupIDOrAccountID(IN n VARCHAR(50))
    BEGIN
		SELECT *, '','','' FROM `Group` WHERE GroupName = n
        UNION 
        SELECT * FROM `Account` WHERE UserName = n;
    END $$
DELIMITER ;

/*Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
trong store sẽ tự động gán:
username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ
Sau đó in ra kết quả tạo thành công*/

DROP PROCEDURE createAccount;
DELIMITER $$
	CREATE PROCEDURE createAccount(IN fName VARCHAR(50), IN email_ VARCHAR(50))
    BEGIN
		DECLARE userName_  VARCHAR(50); -- DEFAULT SUBSTRING_INDEX(email_, ' @' ,1);
        DECLARE pID, dID, accID INT;
        SET userName_ =  SUBSTRING_INDEX(email_, '@', 1);
		
        SELECT PositionID INTO pID FROM Position WHERE PositionName = 'DEV';
        SELECT DepartmentID INTO dID FROM Department WHERE DepartmentName = 'phong cho';
        
        INSERT INTO `Account` (Email, Username, FullName, DepartmentID, PositionID) VALUES
        (email_, userName_, fName, dID, pID); 
		
        SELECT AccountID INTO accID FROM `Account` WHERE UserName = userName_;
        
        IF (accID IS NOT NULL)
			THEN SELECT 'Tao Thanh Cong' AS `ket qua`;
            ELSE SELECT 'Tao That Bai';
		END IF;
    END $$
DELIMITER ;

CALL createAccount('vtiTest', 'emailVti@gmail.com');


DROP PROCEDURE createAccount;
DELIMITER $$
	CREATE PROCEDURE createAccount(IN fName VARCHAR(50), IN email_ VARCHAR(50))
    BEGIN
		DECLARE userName_ VARCHAR(50);
        DECLARE pId, dId , accId INT;
        SET userName_ =  SUBSTRING_INDEX(email_, '@', 1);
        
        SELECT PositionID INTO pId FROM Position WHERE PositionName = 'Developer';
        
        SELECT DepartmentID INTO dId FROM Department WHERE DepartmentName = 'Phòng chờ';
        
        INSERT INTO `Account` (Email, UserName, FullName, DepartmentID, PositionId) VALUES
        (email_, userName_, fName, dId, pId);
        
        SELECT AccountID INTO accId FROM `Account` WHERE UserName = userName_;
        
        IF (accId IS NOT NULL) 
			THEN SELECT 'Tạo thành công' AS `Kết quả`;
            ELSE SELECT 'Tạo thất bại';
		END IF;
        
    END $$
DELIMITER ;

CALL createAccount('vtiTest2', 'emailVti2@gmail.com');

DROP PROCEDURE createAccount;
DELIMITER $$
	CREATE PROCEDURE createAccount(IN fName VARCHAR(50), IN email_ VARCHAR(50))
    BEGIN
		DECLARE userName_ VARCHAR(50);
        DECLARE pId, dId , accId INT;
        SET userName_ =  SUBSTRING_INDEX(email_, '@', 1);
        
        SELECT PositionID INTO pId FROM Position WHERE PositionName = 'Developer';
        
        SELECT DepartmentID INTO dId FROM Department WHERE DepartmentName = 'Phòng chờ';
        
        INSERT INTO `Account` (Email, UserName, FullName, DepartmentID, PositionId) VALUES
        (email_, userName_, fName, dId, pId);
        
        SELECT AccountID INTO accId FROM `Account` WHERE UserName = userName_;
        
        IF (accId IS NOT NULL) 
			THEN SELECT 'Tạo thành công' AS `Kết quả`;
            ELSE SELECT 'Tạo thất bại';
		END IF;
        
    END $$

/*Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất*/

/* câu 11
id1 -> lưu id của phòng mà mình nhập tên
id2 -> lưu id của phòng chờ
update account có departmentID = id1 => chuyển thành departmentId = id2
xoa department có departmentId = id1 */
/* câu 12 
tạo bảng tháng từ id 1 -> 12 (bảng 1) 
tạo View hay CTE => dùng lệnh union nối từ 1->12
SELECT 1 AS `thang` UNION SELECT 2

Year(now()) cross join bảng 1  ra bảng => năm - 12 tháng (bảng 2)

bảng 2 left join Question => group by đếm
*/





