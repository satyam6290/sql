select emp_no,
first_name,
last_name,
case 
when gender = "M" then 'MALE'
else 'FEMALE'
end as gender
from
employees;

select e.emp_no,
e.first_name,
e.last_name,
case
when
dm.emp_no IS NOT NULL then 'Manager'
else 'EMPLOYEE'
end as is_manager
from 
employee e
LEFT JOIN
dept_manger dm ON dm.emp_no = e.emp_no
where
e.emp_no >109990;
