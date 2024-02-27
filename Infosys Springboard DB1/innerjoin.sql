


-- INNER Join is the most frequently used JOIN. 
-- It matches the records from both tables based on the join predicate and returns only the matched rows.
-- For ease of understanding one can think that first a Cartesian Product is created and then all the rows that do not meet the join condition are dropped from the result. 
-- Inner join also has a short hand syntax given its wide use. Let us understand this join using tables in Employee database:

SELECT ID, ENAME, E.COMPID AS E_COMPID, C.COMPID AS C_COMPID, MODEL 
FROM Employee E INNER JOIN Computer C ON E.COMPID = C.COMPID


select * from employee;
select * from computer;


--- inner join with conditoins;

-- inner join using WHERE:
SELECT Id, EName, E.CompId AS E_CompId, C.CompId AS C_CompId, Model 
FROM Employee E INNER JOIN Computer C ON E.CompId = C.CompId WHERE Dept = 'ETA';

-- inner join using AND:
SELECT Id, EName, E.CompId AS E_CompId, C.CompId AS C_CompId, Model 
FROM Employee E INNER JOIN Computer C ON E.CompId = C.CompId AND Dept = 'ETA'


--- EXERCISES:

-- 1.Display employee id, name and department along with computer id and make of computers allocated to them:
select e.id, e.ename, e.dept, e.compid, c.make 
from employee e inner join computer c on e.compid = c.compid

-- 2.Display id, name, computer id and make of the computers allocated to employees provided model is either 'Precision' or 'Edge':
select e.id, e.ename, e.compid, c.make 
from employee e inner join computer c on e.compid = c.compid where model = 'Precision' or model = 'Edge';

-- 3.Display department and number of computers made by Dell allocated in that department:
select e.dept, count(e.compid) "NUMBER OF COMPUTERS" 
from employee e inner join computer c on c.compid = e.compid where c.make = 'Dell' group by e.dept; 

-- NOTE: you can also refer image: inner join special challange
