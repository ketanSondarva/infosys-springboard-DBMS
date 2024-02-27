

-- imagine a scenario, i want to display only 5 employee from top of the employee list or..
--                     i want to display top 5 employees based on their salary. 

-- query that display the row number for each record:


SELECT 
    (@row_number:=@row_number + 1) AS rownum,
    id,
    Ename,
    salary
FROM 
    employee, (SELECT @row_number := 0) AS r;


select itemcode, descr, price from item where itemcode in 
(select itemcode from (select (@r := @r + 1) as r, itemcode from item, (select @r := 0) as r where @r = 2 order by desc))

-- display 4 records from employee:

SELECT (@r := @r + 1) AS rownum, Id, Ename, Salary 
FROM Employee, (SELECT @r := 0) AS r WHERE @r < 4;


-- display top 4 employees based on highest salary:

SELECT (@r := @r + 1) AS rownum, Id, Ename, Salary
FROM Employee, (SELECT @r := 0) AS r WHERE @r < 4 ORDER BY Salary DESC; -- it wont WORK


-----------------------------------------------------------------------------------------------

-- INTRODUCTION to INLINE VIEW:

-- diplaying top 4 employee getting highest salary using inline view:

SELECT (@r := @r + 1) AS rownum, Id, Ename, Salary FROM 
    (SELECT Id, Ename, Salary FROM Employee ORDER BY Salary DESC) E, 
    (SELECT @r := 0) AS r 
WHERE @r < 4;

-- when we select another table using the subquery after the FROM keyword it is called as inline view
-- nothing but subquery in FROM clause
-- inline evaluated first and result is given to the outer table.
-- it can return multiple rows and columns.
-- we can use it to find top 'n' records.  



-- taking the concept to advanced level:


-- task1: we have students who purchase the courses, some student purchase 1 coures while some 2 courses or more. 
--       write query that give the count of course and number of student purchase that many courses.
--       i.e. there are 2 students who purchased the 2 courses. 5 students purchased 1 course ...

-- NOTE: refer ppt: 'inline view'

-- count the number of courses purchased by particular student:
select s.fname, count(m.courseid) courseCount from studentdetail s left outer join marks_details m  
on s.StudentId = m.StudentId group by s.Fname, s.StudentId;

-- we can achive this using the inline view:
SELECT CourseCount, COUNT(Fname) AS Frequency FROM 
    (select s.fname, count(m.courseid) courseCount from studentdetail s left outer join marks_details m  
    on s.StudentId = m.StudentId group by s.Fname, s.StudentId) StudentCourse
group by CourseCount order by CourseCount desc;


-- task2: display the salary ratio based of the employee with respect to his own dept's avg salary


-- counting the avg salary for each dept:
SELECT Dept, AVG(Salary) AvgSalary FROM Employee GROUP BY Dept;

SELECT E.Id, E.Ename, E.Salary, E.Dept, ROUND(E.salary / D.AvgSalary, 2) AS SalaryRatio 
FROM (SELECT Dept, AVG(Salary) AvgSalary FROM Employee GROUP BY Dept) D
INNER JOIN  Employee E ON E.Dept = D.Dept;


-- Usage of inline view: finding top 'n' rows, performing a GROUP BY on grouped data.ADD
