DROP DATABASE IF EXISTS  `Extra_Assignment_3`;
create database `Extra_Assignment_3`;

use `Extra_Assignment_3`;

create table if not exists `Trainee` (
    TraineeID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Full_name varchar(100) NOT NULL,
    Birth_date date NOT NULL,
    Gender ENUM('Male', 'Female', 'Unknow') NOT NULL,
    ET_IQ int Unsigned check(ET_IQ<=20),
    ET_Gmath int Unsigned check(Gmath<=20),
    ET_English int Unsigned check(ET_IQ<=50),
    Tranining_class varchar(100) NOT NULL,
    Evaluation_Notes TEXT ,
    VIT_Account varchar(100) UNIQUE NOT NULL
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
 