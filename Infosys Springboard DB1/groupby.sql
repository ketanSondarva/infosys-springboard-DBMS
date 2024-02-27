

--- GROUP BY groups the data from the table into different groups based on the criteria provided and calculates the aggregate function for each group. 
---- Thus the result has 1 row for each group.

-- lets first insert some more data in employee:
INSERT INTO Employee (ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION) 
VALUES (2, 'Ethan McCarty', '2025-02-01', 440000.00, 'ICP','TA');

select * from employee;

-- aggregate without group by:
select count(id) from employee;

-- group by single column:
select dept, count(id) from employee group by dept;

-- Group By converts the entire rows in a group into a single row in result. You cannot fetch details from individual rows in a category.
--  Let us try to fetch count and names of employees in each department.

SELECT Dept, ENAME, Count(ID) FROM Employee GROUP BY Dept; -- will give ERROR

-- group by multiple columns:
--- IMP: Group By can also be used with multiple columns. In that case it treats each distinct combination of the columns as a single category. 
---      Let us display maximum salary paid to each designation, within each department.

select dept, designation, max(salary) from employee group by dept, designation;

-- group by multiple functions: You can use multiple aggregate functions in the same query as long as category for grouping is the same
SELECT Dept, MIN(SALARY), MAX(Salary) FROM Employee GROUP BY Dept;

-- nesting aggregate functions:
SELECT MAX(AVG(Salary)) max_sal FROM Employee GROUP BY dept;  -- it is not working for mysql

-- group by on nullable columns:
select bonus, count(*) from employee group by bonus;

-- or we can write subsequent queries like these:

select count(*) null_bonus from employee where bonus is null;
select count(*) '1000.00' from employee where bonus = 1000.00;
select count(*) '100.00' from employee where bonus = 100.00;


--- HAVING: Having allows aggregate functions to be used as filter criteria which cannot be done using WHERE clause.

--- group by errors:

-- 1. aggregate function error: Aggregate functions cannot be used in WHERE clause.
SELECT Id, EName, Salary, Dept FROM Employee E1 WHERE Salary = MAX(Salary)

-- 2. aggregate function error: Aggregate functions cannot be used in WHERE clause even if GROUP BY is used.
SELECT DEPT, SUM(Salary) FROM Employee WHERE SUM(Salary) > 90000 GROUP BY DEPT

-- 3. nested aggregate function: Nested aggregate function cannot be used in SELECT clause without GROUP BY clause.
SELECT MAX(AVG(Salary)) FROM Employee

-- 4.Incorrect order by: Order By cannot be used on columns on which Grouping is not being done.
SELECT Dept, SUM(Salary) FROM Employee GROUP BY Dept ORDER BY Designation



--- IMPORTANT EXERCISE (how to use group by with having best example):

select * from saledetail;

-- Problem statement: Display product id and total quantity for products that have been sold more than once. 
--- Consider only those sale instances when the quantity sold was more than 1.

--- NOTE: WHEN THIS KIND OF QUESTION IS GIVEN BREAK DOWN THE STATEMENT AND FIND SOLUTION

-- step 1: Display product id and total quantity, only those sale instances when the quantity sold was more than 1:
select prodid, sum(quantity) QTY_SOLD from saledetail where quantity > 1 group by prodid;

-- step2: products that have sold more than once: (means prodid appear in table more than once):
select prodid, sum(quantity) QTY_SOLD from saledetail where quantity > 1 group by prodid having count(prodid) > 1; -- final result

-- conclusion: it is asking you to find product id's which appear more than 1 times and which sold more than 1 (qty > 1)



--- IMPORTANT EXERCISE 2: Display month of sale and number of sales done in that month sorted in descending order of sales.

SELECT MONTH(sldate) AS Month_of_Sale, COUNT(*) AS Number_of_Sales
FROM Sale
GROUP BY MONTH(sldate)
ORDER BY Number_of_Sales DESC;
