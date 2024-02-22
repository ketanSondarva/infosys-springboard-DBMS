-- Active: 1708238809852@@127.0.0.1@3306@infosyssb

SELECT * FROM Employee;


-- 1. equality:

SELECT ID, ENAME, DESIGNATION, SALARY,
CASE DESIGNATION
    WHEN 'SE' THEN SALARY * 1.2
    WHEN 'SSE' THEN SALARY * 1.1
    ELSE SALARY * 1.05
END New_Salary
FROM Employee;


-- 2.expression:

SELECT ENAME, DESIGNATION, BONUS,
CASE 
    WHEN DESIGNATION = 'SE' THEN BONUS + 500
    WHEN DESIGNATION = 'SSE' THEN BONUS + 1000
    WHEN DESIGNATION = 'PM' THEN BONUS + 2000 
    ELSE BONUS
END AS New_Bonus
FROM Employee;

-- 3.incorrect usage: Any comparison operator can be used to compare the conditions and any logical operators can be used to combine the conditions.

SELECT Id, EName, Designation, Salary, 
CASE Designation 
    WHEN Designation = 'SE' THEN Salary * 1.2 
    WHEN Designation = 'SSE' THEN Salary * 1.1 
    ELSE Salary * 1.05 
END New_Salary 
FROM Employee;

SELECT Id, EName, Designation, Salary, 
CASE Designation 
    WHEN 'SE' OR 'SSE' THEN Salary * 1.2 
    WHEN 'PM' THEN Salary * 1.1 
    ELSE Salary * 1.05 
END New_Salary 
FROM Employee;

-- 4.multiple conditions:

SELECT Id, EName, Designation, Salary, 
CASE 
    WHEN Designation = 'SE' OR Designation = 'SSE' THEN Salary * 1.2
    WHEN Designation = 'PM' AND Salary >= 75000 THEN 'No hike' 
    ELSE Salary * 1.05 
END New_Salary 
FROM Employee;


