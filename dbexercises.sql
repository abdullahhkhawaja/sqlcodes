create table Employees(
	employee_id int, 
    first_name varchar(15),
    last_name varchar(15), 
    email varchar(30),
    phone_number varchar(11), 
    hire_date date, 
    job_id int, 
    salary decimal, 
    department_id int, 
    
    primary key (employee_id),
    unique(email)
    
);

create table Jobs(
	job_id int,
    job_title varchar(30), 
    min_salary decimal,
    max_salary decimal,
    
    primary key (job_id)
);

create table Departments(
	department_id int, 
    department_name varchar(30),
    location_id int, 
    
    primary key(department_id)
);

create table Locations(
	location_id int,
    street_address varchar(30),
    city varchar(20),
    state_province varchar(20), 
    postal_code varchar(20),
    country_id varchar(20),
    
    primary key (location_id)
);

INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, department_id)
VALUES
(1, 'Abdullah', 'Khawaja', 'abdullah.khawaja@example.com', '03115667555', '2003-10-01', 1, 300000, 90),
(2, 'Babar', 'Azam', 'ba56@example.com', '03154096085', '1995-10-15', 2, 45000000, 90),
(3, 'Mahrukh', 'Kanwal', 'mahrukh.kanwal.baka@example.com', '3456789012', '2021-05-10', 1, 70000, 3),
(4, 'Sara', 'Lee', 'sara.lee@example.com', '4567890123', '2020-11-18', 3, 50000, 1),
(5, 'Tom', 'Wilson', 'tom.wilson@example.com', '5678901234', '2021-12-05', 1, 55000, 4);

insert into employees
values (6, 'Loser', 'Boy', 'loser.boy@example.com', '0544695645', '2021-12-05', 1, 20, 4);

explain select *
from Employees
where department_id = 90; 

select first_name, last_name, salary
from employees 
order by  last_name asc;  

select first_name, last_name, salary
from employees
order by salary desc
limit 5; 

insert into Jobs
values
(1,'IT Manager', 20000, 300000), 
(2,'No 1. Batsman ITITIT', 200000, 3000000), 
(3,'ICT Technician', 45500, 565655);  


select e.employee_id, e.first_name, j.job_title
from Employees as e join Jobs as j on (e.job_id = j.job_id)
where job_title like '%IT%';  

select e.first_name, e.last_name, j.job_title
from Employees as e join Jobs as j on (e.job_id = j.job_id); 

select department_id, AVG(salary) AS average_salary
FROM Employees
GROUP BY department_id;

select j.job_title, count(e.employee_id) 
from Jobs as j join Employees as e on e.job_id = j.job_id
group by j.job_title;

insert into Departments(department_id,department_name,location_id)
values
(90,'Top Class Department',1),
(1,'ICT Dept',2),
(3,'Bio Dept',1), 
(4,'Meow dept',3);


select d.department_name, count(e.employee_id) 
from Departments as d join Employees as e on e.department_id = d.department_id
group by d.department_name
having (count(e.employee_id) > 1); 

INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, department_id)
values(10,'departmentless','individual', 'fdvdv', '03154096083', '1995-10-15', 1, 0, null);

select employee_id, first_name, last_name
from Employees
where department_id is null;   

insert into Locations (location_id, street_address, city, state_province, postal_code, country_id)
values
(1,'324A Johar Town', 'Lahore', 'Punjab', '547180', 'Pk'),
(2,'F sector', 'Islamabad', 'Capital Territory', '642136', 'Pk'),
(3,'Stadium Road', 'Multan', 'Punjab', '547111', 'Pk'); 

select e.first_name, e.last_name, l.city
from (Departments as d join Employees as e on e.department_id = d.department_id) join Locations as l on d.location_id = l.location_id;

select e.employee_id, e.first_name, e.salary, j.job_title
from Employees as e join Jobs as j on (e.job_id = j.job_id)
where (e.salary > j.min_salary);

select e.employee_id, e.first_name, e.salary, j.job_title
from Employees as e join Jobs as j on (e.job_id = j.job_id)
where (e.salary > j.min_salary);

select e.first_name, e.last_name, e.department_id, e.salary
from Employees as e
where e.salary = (
    select MAX(salary)
    from Employees
    where department_id = e.department_id
);

insert into Departments(department_id,department_name,location_id)
values
(5,'Employeeless Dept',1); 

select d.department_name 
from Departments as d 
where not exists (
	select 1 
    from employees as e	
    where e.department_id = d.department_id
    );

select employee_id, first_name, last_name, salary
from Employees 
where salary > ( 
	select avg(salary) 
    from employees 
    );
    
select e.first_name, e.last_name, d.department_name
from Employees e join Departments d on e.department_id = d.department_id
where (d.department_name = 'Bio dept' or d.department_name = 'ICT dept'); 

select j.job_title, avg(e.salary) 
from Employees e
join Jobs j on e.job_id = j.job_id
group by j.job_title
having avg(e.salary) > 7000;

select e.employee_id, e.first_name, e.last_name, e.department_id, e.salary,
       rank() over (partition by e.department_id order by e.salary desc) as salary_rank
from Employees e
order by e.department_id, salary_rank;

select first_name, last_name, salary,
       case
           when salary < 50000 then 'Low'
           when salary >= 50000 and salary < 100000 then 'Medium'
           when salary >= 100000 then 'High'
       end as salary_grade
from Employees;







