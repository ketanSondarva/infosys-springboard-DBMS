-- Active: 1708238809852@@127.0.0.1@3306@infosyssb

--- union: (it removes the duplicate rows)

SELECT * FROM Employee WHERE Designation = 'PM' 
UNION
SELECT * FROM Employee WHERE Dept = 'ICP';

--- union all: (int dont remove the duplicate row):

SELECT * FROM Employee WHERE Designation = 'PM'
UNION ALL
SELECT * FROM Employee WHERE Dept = 'ICP';

-- NOTE: See image name: union in Imp Stuff Folder to see the clear diff between these two

SELECT CompId FROM Employee UNION SELECT CompId FROM Computer

SELECT CompId FROM Employee UNION ALL SELECT CompId FROM Computer

-- column count missmatch: The number of columns in both SELECT statements must be the same.
SELECT CompId, EName FROM Employee UNION SELECT CompId FROM Computer -- will give an error

-- DataType missmatch: Data Type of columns at same position in both SELECT statements must be the same:
Data Type of columns at same position in both SELECT statements must be the same. -- will give an error

-- order by: UNION clause does not guarantee the order in which rows from both SELECT statements will appear in the final result. 
----You can use ORDER BY to sort the final result. ORDER BY clause can be placed only once and it must be at the end of second SELECT statement.

SELECT CompId FROM Employee UNION SELECT CompId FROM Computer ORDER BY CompId


-- EXERCISES:

-- 1.Display details of salesmen whose name contains character 'e' and whose location contains character 'o'. 
---- Also display salesmen whose name contains character 'a' and whose location contains character 'a'. Use UNION ALL clause for the same.

SELECT * FROM Salesman WHERE Sname LIKE '%e%' AND LOCATION LIKE '%o%'
UNION ALL
SELECT * FROM Salesman WHERE Sname LIKE '%a%' AND LOCATION LIKE '%a%';

-- 2.Write a query to display ProdId, Pdesc, Category, Discount of Products that have less than 10% discount or whose category is 'Sports'.
--  Display duplicate records if any.

SELECT prodid, pdesc, category, discount FROM Product WHERE discount < 10 OR category = 'Sports'
UNION ALL
SELECT prodid, pdesc, category, discount FROM Product WHERE discount < 10 AND category = 'Sports';

-- 3. Want same columns as above query with same condition but remove duplicate:
SELECT prodid, pdesc, category, discount FROM Product WHERE discount < 10 OR category = 'Sports'
UNION
SELECT prodid, pdesc, category, discount FROM Product WHERE discount < 10 AND category = 'Sports';
-- OR:
SELECT prodid, pdesc, category, discount FROM Product WHERE discount < 10 OR category = 'Sports'
-- it doesn't matter :)

-- 4.Display id and name for salesmen along with id and category of products in a single table. 
-- Indicate the source of the row in result by adding an additional column TYPE with possible values as 'S' (Salesman) and 'P' (Product). Display all rows.

select 'S' as TYPE, sid as ID, sname DETAILS from salesman
UNION 
select 'P' as TYPE, prodid as ID, category as DETAILS from product;

--NOTE: refer to the image: special union challange