/*
IF NOT EXISTS : tạo ra database nếu chưa tồn tại, nếu đã tồn tại không tạo nữa.
*/
-- lệnh tạo database  

create database `Testing_System`;
-- lệnh xóa database
-- drop database `testing_system`;

-- chọn cơ sở dữ liệu(CSDL) cần dùng 
use `Testing_System`;

create table if not exists `Deparment`(
	  DepartmentID Int,
	  DepartmentName Varchar(50)
 );      
 -- truy xuất toàn bộ dữ liệu bảng Department
 -- select * from `Department`deparmentdeparmentdeparment

create table if not exists `Position`(
    PositionID int,
    PositionName varchar(50)
);

create table if not exists `Account`(
    AccountID int,
    Email varchar(50),
    UserName varchar(50),
    FullName varchar(50),
    DepartmentID int,
    PositionID int,
    CreateDate datetime
);
-- drop table `Group`;
 create table if not exists `Group`(
    GroupID int,
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
    TypeID int,
    TypeName varchar(50) 
);

create table if not exists `CategoryQuestion`(
    CategoryID int,
    CategoryName varchar(50) 
);

create table if not exists `Question`(
    QuestionID int,
    Content varchar(50),
    CategoryID int,
    TypeID int,
    CreatorID int,
    CreatorDate datetime 
);

create table if not exists `Answer`(
    ExamID int,
    Code varchar(50),
    Title varchar(50),
    CategoryID int,
    Duration int,
    CreatorID int,
    CreatorDate datetime 
);

create table if not exists `ExamQuestion`(
    ExamID int,
    QuestionID int 
);

insert into deparment (deparmentName)
value ('phong ky thuat 1');