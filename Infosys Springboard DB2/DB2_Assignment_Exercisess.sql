


-- Database structure : table exists
-- Salesman (Sid, Sname, Location)
-- Product (Prodid, Pdesc, Price, Category, Discount)
-- Sale (Saleid, Sid, Sldate, Amount)
-- Saledetail (Saleid, Prodid, Quantity) 

-- 1.Display the product id, category, description and price for those products whose price is maximum in each category:

select prodid, category, pdesc, price from 
product p1 where price = (select max(price) from product p2 where p1.category = p2.category)


-- 2.Display the names of salesmen who have not made any sales:

-- query require joining, but we can also perform correlated subquery: it will be faster than join
select sname from salesman sm where not exists (select 1 from sale s where sm.sid = s.sid);

-- from above query: Display the salesman who have made sales:
select sname from salesman sm where exists (select 1 from sale s where sm.sid = s.sid);


-- 3. Display the names of salesmen who have made at least 1 sale in the month of Jun 2015:

SELECT sname 
FROM salesman sm 
WHERE EXISTS (
    SELECT 1 
    FROM sale s 
    WHERE sm.sid = s.sid 
        AND ( 
            (EXTRACT(MONTH FROM sldate) = 6) 
            AND (EXTRACT(YEAR FROM sldate) = 2015)
        )
);