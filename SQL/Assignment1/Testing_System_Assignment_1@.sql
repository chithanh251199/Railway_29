/*
IF NOT EXISTS : tạo ra database nếu chưa tồn tại, nếu đã tồn tại không tạo nữa.
*/
-- lệnh tạo database  
-- drop database `testing_system`;
create database `Testing_System`;
-- lệnh xóa database
-- drop database `testing_system`;

-- chọn cơ sở dữ liệu(CSDL) cần dùng 
use `Testing_System`;

create table if not exists `Department`(
	  DepartmentID tinyint unsigned Primary key Auto_increment,
	  DepartmentName Varchar(50)
 );      
 -- truy xuất toàn bộ dữ liệu bảng Department
 -- select * from `Department
-- (Auto_increment) chỉ có thể dùng với primary key và số.
-- (unsigned) chỉ được dùng sau kiểu số (int...). 
create table if not exists `Position`(
    PositionID tinyint unsigned Primary key Auto_increment,
    PositionName enum('DEV', 'Test', 'Scrum Master', 'PM')
);

create table if not exists `Account`(
    AccountID tinyint unsigned Primary key Auto_increment,
    Email varchar(100) unique,
    UserName varchar(50) not null,
    FullName varchar(50),
    DepartmentID tinyint unsigned Primary key Auto_increment,
    PositionID  tinyint unsigned Primary key Auto_increment,
    CreateDate datetime,
    CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position` (`PositionID`) ON DELETE SET NULL ON UPDATE CASCADES
);
-- drop table `Group`;
 create table if not exists `Group`(
    GroupID tinyint unsigned Primary key Auto_increment,
    GroupName varchar(50),
    CreatorID int,
    CreatorDate datetime 
);    
create table if not exists `GroupAccount`(
	GroupID int,
    AccountID int,
    JoinDate datetime 
);

create table if not exists `TypeQuestion`(
    TypeID tinyint unsigned Primary key Auto_increment,
    TypeName varchar(50) 
);

create table if not exists `CategoryQuestion`(
    CategoryID tinyint unsigned Primary key Auto_increment,
    CategoryName varchar(50) 
);

create table if not exists `Question`(
    QuestionID tinyint unsigned Primary key Auto_increment,
    Content varchar(50),
    CategoryID int,
    TypeID int,
    CreatorID int,
    CreatorDate datetime 
);
create table if not exists `Answer`(
    AnswerID tinyint unsigned Primary key Auto_increment,
    Content varchar(50),
    QuestionID int,
    Iscorrect bit 
    );

create table if not exists `Exam`(
    ExamID tinyint unsigned Primary key Auto_increment,
    `Code` varchar(50),
    Title varchar(50),
    CategoryID int,
    Duration int,
    CreatorID int,
    CreatorDate datetime 
);

create table if not exists `ExamQuestion`(
    ExamID tinyint unsigned Primary key Auto_increment,
    QuestionID int 
);

insert into deparment (deparmentName)
value ('phong ky thuat 1');