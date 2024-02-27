

-- scalar query:

select * from employee;


SELECT Id, Ename, Salary, (SELECT AVG(Salary) FROM Employee) AS avgsalary FROM Employee;


-- The part/subquery: (SELECT AVG(Salary) FROM Employee) is called scaler subquery which runs independently

-- lets find ratio for each employee:

SELECT Id, Ename, Salary, ROUND(Salary / (SELECT AVG(Salary) FROM Employee), 2) AS SalaryRatio FROM Employee;

-- remember: subqueries always written inside: '()'

-- we cant display two or more attribute in one single scaler subquery:

SELECT Id, Ename, Salary, (SELECT AVG(Salary), MAX(Salary) FROM Employee) FROM Employee; -- it will give error

-- for such thing we can write seperate scaler subquery:

SELECT Id, Ename, Salary, 
    (SELECT AVG(Salary) FROM Employee) AS AvgSalary,
    (SELECT MAX(Salary) FROM Employee) AS MaxSalary
FROM Employee; -- it will give error


-- A subquery which returns zero row is treated as NULL in the outer query:
SELECT Id, Ename, Salary, (SELECT AVG(Salary) FROM Employee WHERE Id > 10) FROM Employee;


-- using scaler subquery as a join:

SELECT Id, Ename, Salary, (SELECT Model FROM Computer c WHERE c.compid = e.compid) FROM Employee e; -- it will work like left outer join for employee table.`ID`


--- refer to the ppt: 'scaler subquery' for more...