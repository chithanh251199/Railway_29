-- lệnh xóa database.
DROP DATABASE IF EXISTS `Testing_System_Assignment5`;

-- lệnh tạo database.
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment5`;

-- lệnh sử dụng database để làm việc. 
USE `Testing_System_Assignment5`;

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

/* Assignment 4
Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
*/

SELECT A.*, DepartmentName FROM `Account` A
INNER JOIN 
Department D ON A.DepartmentID = D.DepartmentID;

SELECT A.Email, A.Username , A.FullName, D.DepartmentName FROM `Account` A
INNER JOIN -- hoặc JOIN 
Department D ON A.DepartmentID = D.DepartmentID;

/*Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010*/

SELECT * FROM `Account` WHERE CreateDate < '2020-12-20';

/*Question 3: Viết lệnh để lấy ra tất cả các developer = DEV*/
SELECT A.*, PositionName FROM `Account` A
INNER JOIN 
Position P ON A.PositionID = P.PositionID
WHERE         P.PositionID = 'DEV';

SELECT * FROM `Account` A
JOIN Department D USING(DepartmentID) WHERE DepartmentName LIKE '%DEV%';

/*Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên*/

SELECT D.DepartmentName, count(A.DepartmentID) AS `SL` FROM `Account` A
JOIN Department D ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
HAVING Count(A.DepartmentID) > 3;

SELECT D.*, Count(*) AS `SL` FROM `Account` A 
JOIN Department D USING(DepartmentID) GROUP BY DepartmentID HAVING SL > 3;

-- giữ lại toàn bộ dữ liệu bảng bên trái là dữ liệu bảng A(D) và dữ liệu chung của A(D(Department)) và bảng B(A(Account)). 
SELECT D.*,COUNT(A.DepartmentID) AS `SL` FROM Department D LEFT JOIN `Account` A ON D.DepartmentID = A.DepartmentID
GROUP BY D.DepartmentID  HAVING  Count(A.DepartmentID) > 3;
-- giữ lại toàn bộ dự liệu bảng bên phải là dữ liệu bảng A(D) và dữ liệu chung của A(D(Department)) và bảng B(A(Account)).
SELECT A.*,COUNT(A.DepartmentID) AS `SL` FROM Department A RIGHT JOIN `Account` D ON D.DepartmentID = A.DepartmentID
GROUP BY D.DepartmentID  HAVING  Count(A.DepartmentID) > 3;



/*Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều
nhất*/

SELECT  COUNT(E.QuestionID) AS `SL` FROM ExamQuestion E GROUP BY E.QuestionID;

SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = 
(SELECT MAX(CountQuestion) FROM 
(SELECT Q.Content, COUNT(Q.QuestionID) AS countQuestion FROM ExamQuestion EQ
JOIN Question Q ON EQ.QuestionID = Q.QuestionID 
GROUP BY Q.QuestionID) AS CountTable );



/*Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question*/

SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) FROM categoryquestion cq
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;

SELECT CQ.CategoryID, COUNT(*) AS `so lan` FROM CategoryQuestion CQ 
JOIN Question Q ON CQ.CategoryID = Q.CategoryID
GROUP BY Q.categoryID;

SELECT * 
FROM Question Q RIGHT JOIN CategoryQuestion CQ ON Q.CategoryID = CQ.CategoryID ORDER BY CQ.CategoryID;

SELECT CategoryID, CategoryName, count(QuestionID) AS `SL`
FROM Question RIGHT JOIN CategoryQuestion USING(categoryID) GROUP BY(CategoryID);

/*Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam*/

SELECT Q.QuestionID, Q.Content , count(EQ.QuestionID) AS `so lan` FROM examquestion EQ
RIGHT JOIN question Q ON Q.QuestionID = EQ.QuestionID
GROUP BY Q.QuestionID;

SELECT Q.Content, Count(EQ.QuestionID) AS `so lan` FROM Question Q
LEFT JOIN ExamQuestion EQ ON EQ.QuestionID = Q.QuestionID
GROUP BY EQ.QuestionID;


/*Question 8: Lấy ra Question có nhiều câu trả lời nhất*/

SELECT Q.QuestionID, Q.content, count(Q.QuestionID) FROM `Answer` A
JOIN Question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(Q.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

/*Question 9: Thống kê số lượng account trong mỗi group*/

SELECT G.GroupID, COUNT(GA.AccountID) AS 'SL'
FROM GroupAccount GA
JOIN `Group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID;

/*Question 10: Tìm chức vụ có ít người nhất*/

SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SL FROM account A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM(
SELECT count(B.PositionID) AS minP FROM account B
GROUP BY B.PositionID) AS minPA);

SELECT P.PositionID, P.PositionName, COUNT(A.PositionID) AS 'SO LUONG'
FROM Position P
INNER JOIN `Account` A ON P.PositionID = A.PositionID
GROUP BY P.PositionID
HAVING COUNT(A.PositionID) = (SELECT MIN(CountP)

FROM (SELECT

COUNT(P.PositionID) AS CountP
FROM Position P
INNER JOIN `Account` A ON P.PositionID = A.PositionID
GROUP BY P.PositionID) AS MinCountP);

/*Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM*/

SELECT DP.DepartmentName, DP.PositionName, COUNT(AccountID) AS `Sl nv` FROM
(SELECT * FROM department CROSS JOIN position) AS `DP`
LEFT JOIN `Account` A ON (DP.DepartmentID = A.DepartmentID AND DP.PositionID = A.PositionID)
GROUP  BY DP.DepartmentID, DP.PositionID;

/*Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...*/

SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN account A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC
;

/*Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm*/

SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS SL FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

/*Question 14:Lấy ra group không có account nào
Sử dụng Left Join*/

SELECT * FROM `Group` G
LEFT JOIN GroupAccount GA ON G.GroupID = GA.GroupID
WHERE GA.AccountID IS NULL;

/*Question 15: Lấy ra group không có account nào*/

SELECT * FROM `Group`
WHERE GroupID NOT IN (SELECT GroupID FROM GroupAccount);

SELECT * FROM GroupAccount GA
RIGHT JOIN `Group` G ON GA.GroupID = G.GroupID
WHERE GA.AccountID IS NULL;

/*Question 16: Lấy ra question không có answer nào*/

SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID
WHERE a.AnswerID IS NULL;

/*Question 17:
a) Lấy các account thuộc nhóm thứ 1
b) Lấy các account thuộc nhóm thứ 2
c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/

-- a) Lấy các account thuộc nhóm thứ 1 

SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2 

SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau

SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

/* Question 18:
a) Lấy các group có lớn hơn 5 thành viên
b) Lấy các group có nhỏ hơn 7 thành viên
c) Ghép 2 kết quả từ câu a) và câu b)*/

-- a) Lấy các group có lớn hơn 5 thành viên

SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5;

-- b) Lấy các group có nhỏ hơn 7 thành viên

SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) <= 7;

-- c) Ghép 2 kết quả từ câu a) và câu b)

SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5
UNION
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) <= 7;



/*Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale*/

CREATE OR REPLACE VIEW v_DSNV_Sale AS
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';

SELECT * FROM v_DSNV_Sale;

/*Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất*/

CREATE OR REPLACE VIEW v_GetAccount AS
WITH CTE_GetListCountAccount AS(
SELECT count(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY GA1.AccountID )
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM CTE_GetListCountAccount );


SELECT * FROM v_GetAccount;

/*Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
được coi là quá dài) và xóa nó đi*/

-- Tạo view có chứa câu hỏi có những content quá dài

CREATE OR REPLACE VIEW v_ContenQuadai
AS
SELECT *
FROM Question
WHERE LENGTH(Content) > 11;
SELECT * FROM v_ContenQuadai; 

-- xóa

DELETE FROM v_ContenQuadai; 


/*Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất*/

CREATE OR REPLACE VIEW v_MaxNV
AS
SELECT D.DepartmentName, count(A.DepartmentID) AS SL
FROM account A
INNER JOIN `department` D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT MAX(countDEP_ID) AS maxDEP_ID FROM
(SELECT count(A1.DepartmentID) AS countDEP_ID FROM account A1
GROUP BY A1.DepartmentID) AS TB_countDepID);

SELECT * FROM v_MaxNV;

/*Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo*/

CREATE OR REPLACE VIEW v_Que5
AS
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn';

SELECT * FROM v_Que5;





