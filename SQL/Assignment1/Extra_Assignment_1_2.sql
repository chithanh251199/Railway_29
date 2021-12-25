create database `Extra_Assignment_1`;

use `Extra_Assignment_1`;

create table if not exists `Trainee` (
    TraineeID int,
    Full_name varchar(100) NOT NULL,
    Birth_date date NOT NULL,
    Gender ENUM('Male', 'Female', 'Unknow') NOT NULL,
    ET_IQ int Unsigned check(ET_IQ<=20),
    ET_Gmathint int Unsigned check(ET_IQ<=20),
    ET_English int Unsigned check(ET_IQ<=20),
    Tranining_class varchar(100) NOT NULL,
    Evaluation_Notes TEXT ,
    VIT_Account varchar(20) NOT NULL
);

/*EX2
ID : smallint Primary key auto_increment,
Name : varchar(50),
Code : char(5) check(code=5),
ModifiedDate : datetime default now();
*/

/*Ex3
ID : smallint Primary key auto_increment,
Name : varchar(50),
Birthdate : date,
Gender : Enum(0, 1, Null),
IsDeleteFlag : bit NOT NULL;
 