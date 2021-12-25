-- xóa database
drop database `Testing_System_Assignment_1.1`;

create database if not exists `Testing_System_Assignment_1.1`;

USE `Testing_System_Assignment_1.1`;
drop table if  exists `Department`;
create table if not exists `Department`(
    `DepartmentID` Tinyint unsigned primary key auto_increment,
    `DepartmentName` varchar(50) not null
);

drop table `Position`;
create table if not exists `Position`(
    `PositionID` tinyint unsigned PRIMARY KEY AUTO_INCREMENT,
    `PositionName` enum('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

drop table `account`;
create table if not exists `Account`(
   `AccountID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Email`        VARCHAR(100) NOT NULL UNIQUE,
    `Username`     VARCHAR(50) NOT NULL UNIQUE,
    `Fullname`     VARCHAR(50) NOT NULL UNIQUE,
    `DepartmentID` TINYINT UNSIGNED DEFAULT 0,
    `PositionID`  TINYINT UNSIGNED,
    `CreateDate`   DATETIME DEFAULT now(),
    CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position` (`PositionID`) ON DELETE SET NULL ON UPDATE CASCADE
);

drop table `Group`;
CREATE TABLE IF NOT EXISTS `Group`(
    `GroupID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `GroupName`  VARCHAR(50) NOT NULL,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME
);
 
 drop table `GroupAccount`;
CREATE TABLE IF NOT EXISTS `GroupAccount`(
    `GroupID`   MEDIUMINT,
    `AccountID` MEDIUMINT,
    `JoinDate`  DATETIME DEFAULT NOW()
);

drop table `TypeQuestion`;
CREATE TABLE IF NOT EXISTS `TypeQuestion`(
    `TypeID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `TypeName` ENUM('ESSAY', 'Munltiple-Choice')
);

drop table `CategoryQuestion`;
CREATE TABLE IF NOT EXISTS `CategoryQuestion`(
    `CategoryID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);

drop table `Question`;
CREATE TABLE IF NOT EXISTS `Question`(
    `QuestionID` TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `CategoryID` TINYINT UNSIGNED,
    `TypeID`     TINYINT UNSIGNED,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME, 
     CONSTRAINT fk_q1 FOREIGN KEY (`CreatorID`) REFERENCES `Account` (`AccountID`) ON UPDATE CASCADE ON DELETE CASCADE ,
	 CONSTRAINT fk_q2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion` (`CategoryID`) ON UPDATE CASCADE ON DELETE CASCADE ,
     CONSTRAINT fk_q3 FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion` (`TypeID`) ON UPDATE CASCADE ON DELETE CASCADE
);

drop table `Answer`;
 CREATE TABLE IF NOT EXISTS `Answer`(
    `AnswerID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `QuestionID` TINYINT UNSIGNED,
    `isCorrect`  BIT,
    CONSTRAINT fk_qid FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`QuestionID`) ON UPDATE CASCADE ON DELETE SET NULL
);

drop table `Exam`;
CREATE TABLE IF NOT EXISTS `Exam`(
    `ExamID`     TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`       VARCHAR(20) NOT NULL,
    `Title`      VARCHAR(50) NOT NULL,
    `CategoryID` TINYINT UNSIGNED,
    `Duration`   TINYINT,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME DEFAULT NOW(),
    CONSTRAINT fk_ex_1 FOREIGN KEY (CreatorID) REFERENCES Account (AccountID) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_ex_2 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON UPDATE CASCADE ON DELETE SET NULL
);

drop table `ExamQuestion`;
CREATE TABLE IF NOT EXISTS `ExamQuestion`(
     `ExamID`     TINYINT UNSIGNED,
     `QuestionID` TINYINT UNSIGNED , 
     PRIMARY KEY (ExamID, QuestionID),
     CONSTRAINT fk_eq1 FOREIGN KEY (ExamID) REFERENCES Exam (ExamID) ON UPDATE CASCADE ON DELETE NO ACTION,
     CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID) ON UPDATE CASCADE ON DELETE NO ACTION
);

insert into `Department`(departmentName)	
values				  	('Sale'),
						('Host'),
						('Managing'),
                        ('Marketing'),
                        ('Education'),
						('Design');
                        
insert into `Position`  (PositionName)
values					('DEV'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
                        
INSERT INTO `Account`	(`Email` , `UserName`  , `FullName` , `DepartmentID` , `PositionID` )
VALUES					('1@gmail.com' , 'nguyenA' , 'nguyen van A' , 1 , 1 ),
						('2@gmail.com' , 'nguyenB' , 'nguyen van B' , 2 , 2 ),
                        ('3@gmail.com' , 'nguyenC' , 'nguyen van C' , 3 , 3 ),
                        ('4@gmail.com' , 'nguyenD' , 'nguyen van D' , 4 , 4 ),
                        ('5@gmail.com' , 'nguyenE' , 'nguyen van E' , 5 , 1);


INSERT INTO `Group`    (`GroupName` , `CreatorID`)
VALUES 				   ('Nhom1' , 1),
					   ('Nhom2' , 2),
                       ('Nhom3' , 3),
                       ('Nhom4' , 4),
                       ('Nhom5' , 5);
                       
INSERT INTO `GroupAccount` (`GroupID` , `AccountID`)
VALUES					   ( 1        , 2          ),
						   ( 2        , 1          ),
                           ( 3        , 4          ),
                           ( 4        , 3          ),
                           ( 1        , 5          );

INSERT INTO `TypeQuestion` (`TypeName`)
VALUE                      ('ESSAY'),
						   ('Munltiple-Choice');
                           
INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES						   ('Java'),
							   ('SQL'),
                               ('.Net'),
                               ('Ruby'),
                               ('Python'),
                               ('NodeJS'),
                               ('HTML'),
                               ('CSS'),
                               ('JavaScript');

INSERT INTO `Question`(`Content`, `CategoryID`, `TypeID`, `CreatorID`, `CreateDate`)
VALUES				  ('Câu hỏi SQL ', 2, 2, 1, 20210401),
					  ('Câu hỏi Java ', 1, 3, 2, 20210301),
                      ('Câu hỏi .NET', 3, 1, 3, 20210501),
                      ('Câu hỏi Ruby', 4, 1, 2, 20210101),
                      ('Câu hỏi Python', 5, 2, 1, 20210505);

INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES            	 ('Câu trả lời - Câu hỏi SQL' , 1 , 1 ),
					 ('Câu trả lời - Câu hỏi Java' , 1 , 1 ),
                     ('Câu trả lời - Câu hỏi .NET' , 1 , 1 ),
                     ('Câu trả lời - Câu hỏi Ruby' , 1 , 1 ),
                     ('Câu trả lời - Câu hỏi Python' , 1 , 1 );

INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`)
VALUES            ('MS_01', 'De Thi 01' , 1 , 90 , 1),
				  ('MS_02', 'De Thi 02' , 1 , 60 , 3),
                  ('MS_03', 'De Thi 03' , 2 , 60 , 3),
                  ('MS_04', 'De Thi 04' , 1 , 90 , 2),
                  ('MS_05', 'De Thi 05' , 2 , 60 , 1);

INSERT INTO `ExamQuestion` (`ExamID` , `Examquestion`)
VALUES                     (1 ,1),
						   (2 ,1),
                           (3, 2),
                           (4 ,2),
                           (5 ,3);

     


     
select * from Department;
SELECT * from Position;