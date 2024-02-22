-- CA - 40:

SELECT DISTINCT Itemtype,
    CASE
        WHEN Price BETWEEN 0 AND 499 THEN 'Cheap'
        WHEN Price BETWEEN 500 AND 1999 THEN 'Affordable'
        WHEN Price BETWEEN 2000 AND 4999 THEN 'Expensive'
        ELSE 'Very Expensive'
    END AS Classification
FROM Item
ORDER BY ItemType, Classification;

-- CA - 42:

SELECT Orderid, ROUND(MONTHS_BETWEEN(Pymtdate, Orderdate), 2) AS "No of Months"
FROM Orders
WHERE MONTHS_BETWEEN(Pymtdate, Orderdate) > 0.1
AND Amountpaid > 0;

-- CA - 43:

SELECT Empid,
       Salary AS "Current Salary",
       ROUND(Salary * 1.20, 2) AS "New Salary",
       ROUND(Salary * 0.20, 2) AS "Incremented Amount"
FROM Empdetails
WHERE Designation = 'Manager';

-- CA - 44:

SELECT Itemcode
FROM Item
WHERE ABS(Qtyonhand - Reorderlevel) > 50;

-- EXCERCISE - 31:

SELECT Prodid,
       Pdesc,
       Price AS "Old_Price",
       ROUND(Price * 0.775, 2) AS "New_Price"
FROM Product 
WHERE Category = 'Sports';

-- EXCERCISE - 32:

SELECT Saleid,
       ROUND(MONTHS_BETWEEN(SYSDATE, Sldate), 1) AS MONTH_AGED
FROM Sale;

-- EXCERCISE - 33:

SELECT ROUND(AVG(Price), 2) AS "Avg",
       MIN(Price) AS "Min",
       MAX(Price) AS "Max",
       COUNT(*) AS "Total"
FROM Product;

-- EXCERCISE - 34:

SELECT Sname || ' is from ' || Location AS RESULT
FROM Salesman;

-- EXCERCISE - 35:

SELECT TO_CHAR(TO_DATE('Jan/10/2015', 'Mon/DD/YYYY'), 'Month') AS MONTH,
       TO_NUMBER(REPLACE('2,50,000', ',', '')) AS Amount
FROM dual;

-- EXCERCISE - 36:

SELECT Prodid, Pdesc, Price
FROM Products
ORDER BY Price DESC, Prodid DESC;

-- EXCERCISE - 37:

SELECT Prodid, Pdesc, Price
FROM Product
ORDER BY Pdesc ASC;

-- ASSIGNMENT - 51:

SELECT Empid, 
       Empname, 
       Salary, 
       CASE 
           WHEN Designation = 'Administrator' THEN ROUND(Salary * 1.10, 2)  -- 10% increase for Administrators
           WHEN Designation = 'Manager' THEN ROUND(Salary * 1.05, 2)  -- 5% increase for Managers
           WHEN Designation = 'Billing Staff' THEN ROUND(Salary * 1.20, 2)  -- 20% increase for Billing Staff
           WHEN Designation = 'Security' THEN ROUND(Salary * 1.25, 2)  -- 25% increase for Security
           ELSE ROUND(Salary * 1.02, 2)  -- No increase for other roles
       END AS IncreasedSalary
FROM Empdetails;

-- ASSIGNMENT - 52:

SELECT Empid,
       Salary,
       CASE 
           WHEN Salary < 2500 THEN 'Class 3'
           WHEN Salary BETWEEN 2500 AND 5000 THEN 'Class 2'
           ELSE 'Class 1'
       END AS SALGRADE
FROM Empdetails;

-- ASSIGNMENT - 53:

SELECT Itemcode,
       Price AS "Old Price",
       ROUND(Price * 0.745, 2) AS "New Price"
FROM Item
WHERE Itemtype = 'FMCG';

-- ASSIGNMENT - 54:

SELECT Empid, Empname, Worksin
FROM Empdetails
WHERE LOWER(Designation) LIKE '%billing%'
   OR LOWER(Designation) LIKE '%cashier%';

-- ASSIGNMENT - 8:

SELECT Orderid, Status, 
       CASE 
           WHEN Amountpaid > 0 THEN Pymtmode
           ELSE 'Payment yet not done'
       END AS Pymtmode
FROM Orders;

-- ASSIGNMENT - 56:

SELECT Descr
FROM Item
WHERE LENGTH(Descr) > 15;

-- ASSIGNMENT - 57:

SELECT REGEXP_REPLACE(SUBSTR(Roid, REGEXP_INSTR(Roid, '[0-9]')), '[^0-9]', '') AS NUMERICROID
FROM Retailoutlet;

-- ASSIGNMENT - 58:

SELECT TO_CHAR(SYSDATE, 'Mon/DD/YYYY Day') AS Current_Date
FROM dual;


-- ASSIGNMENT - 9:

SELECT
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN Amountpaid > 0 THEN 1 ELSE 0 END) AS OrdersWithPayment
FROM
    Orders;


-- ASSIGNMENT - 60:

SELECT 
    Orderid,
    ABS(TRUNC(Pymtdate) - TRUNC(Orderdate)) AS NOOFDAYS
FROM 
    Orders;


-- ASSIGNMENT - 61:

SELECT COUNT(DISTINCT Itemtype) FROM Item


-- ASSIGNMENT - 10:

SELECT 
    MAX(Salary) AS MAXSAL,
    MIN(Salary) AS MINSAL,
    SUM(Salary) AS TOTALSAL,
    AVG(Salary) AS AVGSAL
FROM 
    Empdetails;

-- ASSIGNMET - 64:

SELECT COUNT(DISTINCT Itemcode) AS NOOFITEMS
FROM Item;

-- ASSIGNMENT - 65:

SELECT 
    Orderid,
    MONTHS_BETWEEN(Orderdate, Pymtdate) AS 	"No of Months"
FROM 
    Orders;


-- ASSIGNMENT - 66:

SELECT 
    SUM(Quotedprice) AS TotalPrice
FROM 
    Quotation
WHERE 
    Qstatus = 'Accepted'
    AND EXTRACT(MONTH FROM Qdate) = 6;






