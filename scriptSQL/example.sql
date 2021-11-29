-- Run this script once every git pull

 USE e_commerce;


 DROP TABLE IF EXISTS department;
 CREATE TABLE department (
   dname        varchar(25) not null,
   dnumber      int not null,
   mgrssn      char(9) not null, 
   mgrstartdate date,
   CONSTRAINT pk_department primary key (dnumber),
   CONSTRAINT uk_dname UNIQUE (dname) 
 );


 INSERT INTO department VALUES ('Research','5','333445555','1978-05-22');
 INSERT INTO department VALUES ('Administration','4','987654321','1985-01-01');
 INSERT INTO department VALUES ('Headquarters','1','888665555','1971-06-19');
 INSERT INTO department VALUES ('Software','6','111111100','1999-05-15');
 INSERT INTO department VALUES ('Hardware','7','444444400','1998-05-15');
 INSERT INTO department VALUES ('Sales','8','555555500','1997-01-01');
