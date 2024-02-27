

-- NOTE: When using LEFT OUTER JOIN, do not apply filter on the right table
--       When using RIGHT OUTER JOIN, do not apply filter on the left table

--- 1.Left outer join:

-- 1. Main table WHERE condition: This query fetches details of all employees from ETA. In addition it retrieves model information for employees from ETA department who have computer allocated to them.

SELECT Id, EName, Dept, E.CompId AS E_CompId, C.CompId AS C_CompId, Model 
FROM Employee E LEFT OUTER JOIN Computer C ON E.CompId = C.CompId WHERE Dept = 'ETA'


-- 2. Main table AND Condition: This query fetches details of all employees. In addition it retrives model information for employees from ETA department who have computer allocated to them

SELECT Id, EName, Dept, E.CompId AS E_CompId, C.CompId AS C_CompId, Model 
FROM Employee E LEFT OUTER JOIN Computer C ON E.CompId = C.CompId AND Dept = 'ETA'

-- NOTE THAT: James Potter's computer details are not shown even through he is allocated a computer because he is not from ETA department.

-- 3. Lookup table WHERE Condition: This query uses an LEFT OUTER join and should fetch all rows from Employee table. However due to erroneous usage of WHERE clause on lookup table attribute, all rows for Employee who are not allocated any computer does not appear in the result.

SELECT Id, EName, E.CompId AS E_CompId, C.CompId AS C_CompId, Model, mayer 
FROM Employee E LEFT OUTER JOIN Computer C ON E.CompId = C.CompId WHERE mayer = '2013'


SELECT * FROM computer

-- 4. Lookup table AND Condition: This query fetches details of all employees. In addition it retrieves model information for computers that are allocated to employees and are manufactured in 2013.

SELECT Id, EName, E.CompId AS E_CompId, C.CompId AS C_CompId, Model, mayer 
FROM Employee E LEFT OUTER JOIN Computer C ON E.CompId = C.CompId AND mayer = '2013'

-- Computer detail of the employee not allocated on year 2013 will not be shown (i.e. will be denoted as null even the computer is allocated).


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- RIGHT OUTER Join for tables A and B will always return all records from table B even if matching record is not found in table A as per the join condition. 
-- Right outer join is the mirror image of left join. In fact it is rarely used because the same resultset can be obtained by using a left join and reversing the order of the tables in the query. 
-- Let us understand this join using tables in Employee database:

SELECT ID, ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, MODEL 
FROM Employee E RIGHT OUTER JOIN Computer C ON E.COMPID = C.COMPID

-- Aove query can be return as below by changing the order of the table in query of the left outer join. result will be the same:

SELECT ID, ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, MODEL 
FROM Computer C LEFT OUTER JOIN Employee E ON E.COMPID = C.COMPID


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- FULL OUTER Join combines the effect of both LEFT OUTER JOIN and the RIGHT OUTER JOIN. 
-- Full Outer Join between table A and table B returns matched as well as unmatched rows from both tables. 
-- For two tables with p and q rows, a 1:1 relationship and m matched rows the total number of rows in the resultset is m + (p - m) + (q - m) = p + q - m. 
-- Let us understand this join using tables in Employee database:

SELECT ID, ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, MODEL
FROM Employee E FULL OUTER JOIN Computer C ON E.COMPID = C.COMPID; -- this query will give error for mysql, coz: mysql does not support full outer join directly


-- MySQL does not directly support the FULL OUTER JOIN syntax. 
-- However, you can simulate the behavior of a FULL OUTER JOIN using UNION with a combination of LEFT JOIN and RIGHT JOIN. 
-- Here's an example:

SELECT E.ID, E.ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, C.MODEL
FROM Employee E
LEFT JOIN Computer C ON E.COMPID = C.COMPID
UNION
SELECT E.ID, E.ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, C.MODEL
FROM Employee E
RIGHT JOIN Computer C ON E.COMPID = C.COMPID
WHERE E.COMPID IS NULL;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- JOINS SYNTEX ERROR:

-- 1. Missing alias name:

SELECT ID, ENAME, COMPID, MODEL FROM Employee E INNER JOIN Computer C ON E.COMPID = C.COMPID

-- 2. Mixing syntax 1: (Identify the error in below query):

SELECT ID, ENAME, COMPID, MODEL FROM Employee E, Computer C ON E.COMPID = C.COMPID

-- 3. Mixing syntax 2: Sometimes ANSI syntax is used but join condition in provided in WHERE clause.

SELECT ID, ENAME, COMPID, MODEL FROM Employee E INNER JOIN Computer C WHERE E.COMPID = C.COMPID

