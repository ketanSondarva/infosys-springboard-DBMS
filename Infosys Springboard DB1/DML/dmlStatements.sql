
-- INSERT TABLE QUERY:


-- first lets create employee table:

CREATE TABLE IF NOT EXISTS Computer (
    COMPID INT NOT NULL PRIMARY KEY,
    MAKE CHAR(10) NOT NULL,
    MODEL CHAR(20) NOT NULL,
    MAYER CHAR(4) NOT NULL,
    CONSTRAINT Make_chk CHECK(MAKE IN('Dell','Lenovo','Apple'))
);

CREATE TABLE IF NOT EXISTS Employee (
    ID INT NOT NULL PRIMARY KEY,
    ENAME VARCHAR(40) NOT NULL,
    DOJ DATE NOT NULL,
    SALARY DECIMAL(9, 2) NOT NULL,
    BONUS DECIMAL(9, 2),
    DEPT CHAR(3) NOT NULL CHECK (DEPT IN ('ICP', 'ETA', 'IVS')),
    DESIGNATION CHAR(3) NOT NULL,
    MANAGER INT,
    COMPID INT UNIQUE,
    CONSTRAINT Manager_fk FOREIGN KEY (MANAGER) REFERENCES Employee (ID),
    CONSTRAINT Comp_fk FOREIGN KEY (COMPID) REFERENCES Computer (COMPID)
);

-- Insert Statements:

--- order should be maintained as we have the columns in the tables otherwise it will give error:
--- value must be provide for the all columns in correct order
INSERT INTO computer
VALUES(1001, 'Dell', 'Vostro', '2013');

INSERT INTO computer
VALUES(1002, 'Dell', 'Vostro', '2013');

INSERT INTO computer
VALUES(1003, 'Dell', 'Vostro', '2013');

INSERT INTO Employee 
VALUES(6, 'James Potter', '2025-06-01', 75000.00, 1000.00, 'ETA', 'PM', NULL, 1001);

--- columns in any order:
INSERT INTO Employee (Id, Compid, Ename, DOJ, Salary, Bonus, Dept, Designation, Manager) 
VALUES (8, 1002, 'Emily Rayner', '2025-06-01', 25000.00, 100.0, 'ETA', 'SE', NULL);

--- Attributes that allow null values can be omitted from the insert statement if null needs to be inserted:
INSERT INTO Employee (Id, Ename, DOJ, Salary, Dept, Designation, Manager, Compid) 
VALUES (9, 'Jack Abraham', '2025-06-01', 30000.00 , 'ETA', 'SSE', NULL, NULL);

-- NOTE(unique, primary and foreign key violation): 
-- If you try to insert two employee record with the same compid it will give foreign key violation error.
-- if you try to insert null in primary key it will give primary key voilaion error.
-- if you try to insert two record with same value when column in unique it will give unique violation error.

SELECT * FROM Computer;
SELECT * FROM Employee;


--- select statement:

-- all columns:
SELECT * FROM Employee;

-- filter columns:
SELECT ID, ENAME, SALARY FROM Employee;

-- alias without 'as' keyword:
SELECT ID EmpId, ENAME EmpName, SALARY EmpSalary FROM Employee;

-- alias with 'as' keyword:
SELECT ID AS EmpId, ENAME AS 'EmpName', SALARY AS EmpSalary FROM Employee;

-- expression:
SELECT ENAME, SALARY * 2 AS "Double Salary" FROM Employee;

-- constant:
SELECT EName, 30 AS Value FROM Employee;


--- DISTINCT Key Word:

-- Duplicates:
SELECT Dept FROM Employee;

-- Single column:
SELECT DISTINCT Dept FROM Employee;

-- multiple column:
SELECT DISTINCT Dept, Manager from Employee;

-- NOTE: DISTINCT must be used immediately after SELECT. Any attempt to use it between columns will result in error.
SELECT Dept, DISTINCT Manager FROM EMPLOYEE

-- Distinct can also be used with NULL columns to remove duplicate NULL values:
SELECT DISTINCT Bonus FROM Employee

--- WHERE Clause:


-- comparision operator 1:
SELECT ID, ENAME FROM Employee WHERE SALARY > 40000

-- comparision operator 2:
SELECT ID, ENAME FROM Employee WHERE ENAME = 'James Potter'

-- AND Operator:
SELECT ID, ENAME FROM Employee WHERE SALARY >= 30000 AND DEPT = 'ETA'

-- OR Operator:
SELECT ID, ENAME FROM Employee WHERE SALARY > 75000 OR DEPT = 'ICP'

-- BETWEEN Operator:
SELECT ID, ENAME FROM Employee WHERE SALARY BETWEEN 30000 AND 50000

-- IN Operator: Syntax: IN(list of values)
SELECT ID, ENAME FROM Employee WHERE ID IN (2,3)

-- NOTE: If IN clause contains duplicate values then the database server will remove duplicates before executing the query.
SELECT ID, ENAME FROM Employee WHERE DEPT IN ('ETA', 'ETA')

-- NOT IN Operator:
SELECT ID, ENAME FROM Employee WHERE ID NOT IN (2,3)

-- Equal to operator cannot be used to check for NULL values
SELECT ID, EName FROM Employee WHERE BONUS = NULL

-- IS NULL:
SELECT ID, EName FROM Employee WHERE BONUS IS NULL

-- IS NOT NULL
SELECT ID, EName FROM Employee WHERE BONUS IS NOT NULL

-- IN(NULL)
SELECT ID, ENAME FROM Employee WHERE BONUS IN (NULL)


-- CHAR:CHAR data types are stored with trailing spaces. While filtering them using equality operator you need not provide trailing spaces.
SELECT Id, EName, Designation FROM Employee WHERE Designation = 'PM'

-- CHAR With trailing spaces, trailing spaces will be ignored | in mysql it will wont work:
SELECT Id, EName, Designation FROM Employee WHERE Designation = 'PM  '

-- Leading spaces are not ignored for CHAR data type:
SELECT Id, EName, Designation FROM Employee WHERE Designation = ' PM'

-- NOTE: for VARCHAR trailing spaces are not ignored..


--- LIKE Oprator:

-- Start pattern:
SELECT ID, ENAME FROM Employee WHERE ENAME LIKE 'E%'

-- end pattern:
SELECT ID, ENAME FROM Employee WHERE ENAME LIKE '%r'

-- anywhere pattern:
SELECT ID, ENAME FROM Employee WHERE ENAME LIKE '%m%'

-- dates end pattern:
SELECT ID, ENAME, DOJ FROM Employee WHERE DOJ LIKE '202%'

-- fixed pattern:
SELECT ID, ENAME, DOJ FROM Employee WHERE DOJ LIKE '____-__-__'

-- mixed pattern: 
SELECT ID, ENAME FROM Employee WHERE ENAME LIKE '_a%' -- second character must be 'a'


-- Order of query execution: from  join  where  group by  having  select  distinct  order by

--- UPDATE Command:

-- Update statement is used to modify existing rows in a single table in a relational database

-- 1.without where clause:
UPDATE Employee SET salary = salary * 1.10;

-- 2.single column:
UPDATE Employee SET salary = salary * 1.20 WHERE ID = 2;

-- 3.multiple column update:
UPDATE Employee SET salary = salary * 1.3, bonus = salary * 0.30 WHERE ID = 1;

-- 4.The UPDATE statement fails if the same column is updated multiple times in the same statement:
UPDATE Employee SET SALARY = 100, SALARY = 200 WHERE ID = 1

-- 5.(multiple column in one where statement) there is no limit to filter conditions that can be provided in the WHERE clause:
UPDATE Employee SET salary = salary * 1.40 WHERE designation = 'SE' OR dept = 'ETA';

-- 6. incorrect systex:
UPDATE TABLE Employee SET salary = salary * 2;

--- some violation when we update the table:
UPDATE Employee SET ENAME = NULL WHERE ID = 1 -- not null violation, ename set to be not NULL

-- note: we can update the primary key.however there can be voilation of the primary key if the key is exist.computer

UPDATE Employee SET DEPT = 'ILI' WHERE ID = 1 -- check constrint voilation, dept not in the specified list of department

-- there can alos be unique key violation
-- foreign key violation (child table, parent table)



-- ===================================================================================================================================

--- DELETE COMMAND and TRUNCATE COMMAND:

-- DELETE statement is used to delete records from a single table in a relational database:


-- filter single row:
DELETE FROM Employee WHERE ID = 5;

-- filter multiple row:
DELETE FROM Employee WHERE Dept ='ETA' and Manager = 2;

-- forign key violation:
DELETE FROM Computer WHERE COMPID=1001;

-- without where clause: (will delete all records like truncate)
DELETE FROM Employee;


