

-- find the employees whos salary is greater than the avg salary:

SELECT Id, Ename, Dept, Salary FROM employee 
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

SELECT Id, Ename, Dept, Salary FROM employee 
WHERE Salary = (SELECT MAX(Salary) FROM Employee);


select e.id, e.ename from employee e inner join computer c on c.compid = e.compid where c.mayer = '2013';

-- above query using nested subquery:
select id, ename from employee where compid in (select compid from computer where mayer = '2013');


select e.id, e.ename from employee e where id in (select manager from employee);

-- above similar query using join:
select m.id, m.ename from employee e inner join employee m where m.id = e.manager;

select e.id, e.ename from employee e inner join employee m where m.id = e.manager; -- employees who are not manager

-- to remove the duplicate column:

select distinct m.id, m.ename from employee e inner join employee m where m.id = e.manager; -- result will be same as nested subquery

-- dept wise total salary:
select dept, sum(salary) from employee group by dept;

-- max total salary dept wise:
select max(sum(salary)) from employee group by dept; -- wont work for mysql

-- this will give the max salary group by the total salary of the department:
select max(dept_salary_sum) as max_salary from 
(select dept, sum(salary) as dept_salary_sum from employee group by dept) as sum_of_dept_salary;

-- what if we want to see the corresponding department also?

select dept, sum(salary) from employee group by dept having sum(salary) = 
(select max(dept_salary_sum) as max_salary from 
(select dept, sum(salary) as dept_salary_sum from employee group by dept) as sum_of_dept_salary);


-- finding dept which has greater avg salary than avg salary of ETA dept:

select dept from employee group by dept having avg(salary) > 
(select avg(salary) from employee where dept = 'ETA');

-- same result can be obtain by:

select e1.dept from 
    (select dept, avg(salary) as avgsalary from employee group by dept) as e1
    inner join   
    (select avg(salary) as etasalary from employee where dept = 'ETA') as e2
    on e1.avgsalary > e2.etasalary;


-- nested query:

-- A subquery in WHERE clause that does not refer to outer query is called a nested subquery.   
-- we can use operator like: >, <>, >=, <=, =, !=, IN, OR, NOT
-- nested subquery can be used to filter based on aggregate values