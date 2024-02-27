

-- Single Row Aggregate Function: Display the details of all employees whose salary is greater than or equal to average salary of the employees in their own department:

SELECT Id, EName, DEPT, Salary FROM Employee E1 
WHERE Salary >= (SELECT AVG(Salary) FROM Employee E2 WHERE E1.DEPT = E2.DEPT);

-- Single row: Display the details of all employees whose salary is greater than their manager’s salary:

SELECT Id, EName, DEPT, Salary FROM Employee E WHERE Salary > (SELECT Salary FROM Employee M WHERE E.Manager = M.ID);


-- Equivalent join solution: Display the details of all employees whose salary is greater than their manager's salary:

SELECT E.Id, E.EName, E.DEPT, E.Salary FROM Employee E JOIN Employee M ON E.Manager = M.Id AND E.Salary > M.Salary;

-- Exists:  EXISTS keyword is used to check presence of rows in the subquery. 
---         The main query returns the row only if at least one row exists in the subquery. 
---         EXISTS clause follows short circuit logic i.e. the query calculation is terminated as soon as criteria is met. 
---         As a result it is generally faster than equivalent join statements.

SELECT CompId, Make, Model FROM Computer C WHERE EXISTS (SELECT 1 FROM Employee E WHERE E.CompId = C.CompId);


-- Not Exists:  NOT EXISTS is opposite of EXISTS i.e. it is used to check absence of rows in the subquery. 
---             The main query returns the row only if at least no row exists in the subquery. 
---             It also uses short circuit logic and is hence faster.

SELECT CompId, Make, Model FROM Computer C WHERE NOT EXISTS (SELECT 1 FROM Employee E WHERE E.CompId = C.CompId);


-- EXERCISE 63:

SELECT
    Prodid,
    Category,
    Pdesc AS PDESC,
    Price
FROM
    Product
WHERE
    (Category, Price) IN (
        SELECT
            Category,
            MAX(Price)
        FROM
            Product
        GROUP BY
            Category
);


-- EXERCISE 64:

SELECT
    Sname
FROM
    Salesman s
LEFT JOIN
    Sale sa ON s.Sid = sa.Sid
WHERE
    sa.Sid IS NULL;

-- EXERCISE 65:

SELECT DISTINCT
    Sname
FROM
    Salesman s
JOIN
    Sale sa ON s.Sid = sa.Sid
WHERE
    EXTRACT(MONTH FROM Sldate) = 6
    AND EXTRACT(YEAR FROM Sldate) = 2015;


-- EXERCISE 66:

SELECT DISTINCT
    s.Sid,
    s.Sname,
    s.Location
FROM
    Salesman s
JOIN
    Sale sa ON s.Sid = sa.Sid
JOIN
    Saledetail sd ON sa.Saleid = sd.Saleid
JOIN
    Product p ON sd.Prodid = p.Prodid
JOIN
    (
        SELECT
            s.Location,
            s.Sid,
            SUM((p.Price * (1 - p.Discount / 100)) * sd.Quantity) AS TotalSales
        FROM
            Salesman s
        JOIN
            Sale sa ON s.Sid = sa.Sid
        JOIN
            Saledetail sd ON sa.Saleid = sd.Saleid
        JOIN
            Product p ON sd.Prodid = p.Prodid
        GROUP BY
            s.Location,
            s.Sid
    ) SalesAmountPerSalesman ON s.Sid = SalesAmountPerSalesman.Sid
JOIN
    (
        SELECT
            s.Location,
            AVG(SalesAmountPerSalesman.TotalSales) AS AvgTotalSales
        FROM
            Salesman s
        JOIN
            (
                SELECT
                    s.Location,
                    s.Sid,
                    SUM((p.Price * (1 - p.Discount / 100)) * sd.Quantity) AS TotalSales
                FROM
                    Salesman s
                JOIN
                    Sale sa ON s.Sid = sa.Sid
                JOIN
                    Saledetail sd ON sa.Saleid = sd.Saleid
                JOIN
                    Product p ON sd.Prodid = p.Prodid
                GROUP BY
                    s.Location,
                    s.Sid
            ) SalesAmountPerSalesman ON s.Sid = SalesAmountPerSalesman.Sid
        GROUP BY
            s.Location
    ) AvgSalesAmountPerLocation ON s.Location = AvgSalesAmountPerLocation.Location
WHERE
    SalesAmountPerSalesman.TotalSales > AvgSalesAmountPerLocation.AvgTotalSales;
