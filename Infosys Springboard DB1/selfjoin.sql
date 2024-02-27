

-- SELF Join represents join of a table with itself. In this example we use inner self join to retrive employee's manager name. 
-- The Cartesian product of Employee table with itself will contain 5 x 5 = 25 rows.
-- However only three rows have manager matching id and these appears on the result.


SELECT * FROM Employee;

SELECT EMP.ID EMPID, EMP.ENAME EMPNAME, MGR.ID MGRID, MGR.ENAME MGRNAME 
FROM Employee EMP INNER JOIN Employee MGR ON EMP.MANAGER = MGR.ID 

-- NOTE: refer to folder: imagine self join, to understand it more clear

-- UPDATE Employee SET Manager = 6 WHERE ID = 9;


--- LEFT OUTER JOIN:

-- LEFT OUTER Join for tables A and B will always return all records from table A even if matching record is not found in table B as per the join condition.
-- For records where match is found the result set is exactly same as the inner join result. 
-- However for non matching records all columns from table B appear as NULL in the result. 
-- Let us understand this join using Employee and Computer tables:

SELECT ID, ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, MODEL
FROM Employee E LEFT OUTER JOIN Computer C ON E.COMPID = C.COMPID



