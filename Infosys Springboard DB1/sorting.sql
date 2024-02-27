

-- single column default:
Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY SALARY

-- single column ascending:
Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY DEPT ASC

-- single column descending order:
Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY DOJ DESC

-- multiple column: Provide comma separated any number of columns in Order by clause to sort on multiple columns:
Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY DEPT, DESIGNATION

-- multiple sort order:
Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY DEPT ASC, DESIGNATION DESC

INSERT INTO Employee (ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION) 
VALUES (10, 'john doe', '2025-07-01', 430000.00, 'ACC','SE');


-- positional sort:Column position in the query can be used as an alternative to column name in ORDER BY clause

Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY 2 DESC

Select ID, ENAME, DOJ, SALARY, DEPT, DESIGNATION FROM Employee ORDER BY 2 

-- not in select clause: The column being sorted need not be present in the SELECT clause:
Select ID, ENAME, DOJ, DEPT, DESIGNATION FROM Employee ORDER BY SALARY

-- last clause: Order By clause must be the last clause in the query:
Select ID, ENAME, DOJ, DEPT, DESIGNATION FROM Employee ORDER BY SALARY WHERE ID < 5 -- will give error

-- null columns ASC: You can specify ORDER BY on columns that contain NULL values.
Select ID, ENAME, DOJ, SALARY, BONUS, DEPT, DESIGNATION FROM Employee ORDER BY BONUS

-- null columns desc:
Select ID, ENAME, DOJ, SALARY, BONUS, DEPT, DESIGNATION FROM Employee ORDER BY BONUS DESC


-- Display product id, category and discount of the products which belongs to 
--- the category ‘Sports’ or ‘Apparel’ in ascending order of category and discount:

select prodid, category, discount from product 
where category = 'Sports' or category = 'Apparel' order by category, discount;