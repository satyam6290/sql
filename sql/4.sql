create database  if not exists college;
use college;
create table teacher(
id int primary key,
name varchar(50),
 subject varchar(15),
 salary int
 );
insert into teacher
value
(01,"satyam kumar", "coding",150000),
(02,"chandan kumar", "coding",100000),
(03,"aditya kumar", "coding",90000),
(04,"shivam kumar", "coding",50000),
(05,"bittu kumar", "coding",120000);

select * from teacher;

select * from teacher
where salary>100000;

alter table teacher
change column salary ctc int;



update teacher 
set ctc = ctc + ctc * 0.25;

set sql_safe_updates=0;

alter table teacher
add column city varchar(15) default "chennai";

alter table teacher
drop column ctc;


use college;
create table student_info(
roll_no int(05),
name varchar(10),
city varchar(10),
marks int(05)
);
select * from student_info;

insert into student_info
value
(110,"adam","delhi",76),
(108,"bob","mumbai",65),
(124,"casey","pune",94),
(112,"duke","pune",80);

select * from student_info
where marks>75;

select city from student_info group by city;
select distinct city from student_info;

select city, max(marks)
from student_info 
group by city;
select avg(marks)
from student_info;

alter table student_info
add column grade varchar(2);

update student_info
set grade = "O"
where marks >=80;

update student_info
set grade = "A"
where marks >70;

update student_info
set grade = "B"
where marks >60;

update student_info
set grade = "C"
where marks <50;

select * from student_info;