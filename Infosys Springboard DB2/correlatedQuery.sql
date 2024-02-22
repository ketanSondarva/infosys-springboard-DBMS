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
