

-- Database structure
-- Salesman (Sid, Sname, Location)
-- Product (Prodid, Pdesc, Price, Category, Discount)
-- Sale (Saleid, Sid, Sldate, Amount)
-- Saledetail (Saleid, Prodid, Quantity) 



-- 1. Display the sale id and sale date of sales made by salesmen working from London:

select s.saleid, s.sldate 
from salesman sm inner join sale s on s.sid = sm.sid where sm.location = 'London';


-- 2. Display the salesmen id, salesmen name and location of those salesmen who are co-located:

SELECT s1.Sid, s1.Sname, s1.Location
FROM Salesman s1
INNER JOIN Salesman s2 ON s1.Location = s2.Location
WHERE s1.Sid <> s2.Sid
ORDER BY s1.Location, s1.Sid;


-- 3.Display salesmen name and sale id of their sales. Consider SaleId as NULL if a Salesman has not made any sale:

SELECT sm.sname, s.saleid 
FROM Salesman sm 
LEFT OUTER JOIN Sale s 
ON s.sid = sm.sid; 

-- 4.Display the salesmen id, salesmen name, total sale amount and total discount by salesman who have made sales. 
-----Display the result in descending order of total sale amount and total discount.The sales amount for one sale can be calculated from price and quantity. 
-----The discount for one sale can be calculated from price, quantity and discount.

select sm.sid, sm.sname, sum(p.price * sd.quantity) TAMOUNT, sum((p.price * sd.quantity) * (p.discount / 100)) TDISCOUNT from salesman sm
inner join sale s on s.sid = sm.sid
inner join saledetail sd on sd.saleid = s.saleid
inner join product p on p.prodid = sd.prodid
group by sm.sid, sm.sname
order by TAMOUNT desc, TDISCOUNT desc;


-- 5.For a given Sale Id display all products sold and id and name of salesman who made the sale:

select sd.saleid, sd.prodid, sm.sid, sm.sname from saledetail sd inner join sale s on s.saleid = sd.saleid
inner join salesman sm on sm.sid = s.sid;
-- NOTE: you can refer to: imp stuff > special join 3 table img


-- 6. Display the salesmen id, salesmen name, total sale amount and total discount by salesman who have made sales. 
--- The total sale amount and total discount should appear as 0(Zero) for those Salesmen who were not able to make any sale.
--- The sales amount for one sale can be calculated from price and quantity and discount.

select sm.sid, sm.sname, coalesce(sum(sd.quantity * p.price), 0) TAMOUNT , coalesce(sum((sd.quantity * p.price) * (p.discount/100)), 0) TDISCOUNT from salesman sm left outer join sale s on sm.sid = s.sid
left outer join saledetail sd on sd.saleid = s.saleid
left outer join product p on p.prodid = sd.prodid
group by sm.sid, sm.sname;


-- 7. Display location, category and the total quantity sold location and category wise:

select sm.location, p.category, sum(sd.quantity) QUANTITY_SOLD from salesman sm inner join sale s on s.sid = sm.sid
inner join saledetail sd on sd.saleid = s.saleid
inner join product p on p.prodid = sd.prodid
group by sm.location, p.category;


select * from salesman;
select * from sale;
select * from saledetail;
select * from product;

