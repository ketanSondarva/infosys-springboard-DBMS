
-- Database structure -- tables not available
-- Item (Itemcode, Itemtype, Descr, Price, Reorderlevel, Qtyonhand, Category)
-- Quotation (Quotationid, Sname, Itemcode, Quotedprice, Qdate, Qstatus)
-- Orders (Orderid, Quotationid, Qtyordered, Orderdate, Status, Pymtdate, Delivereddate, Amountpaid, Pymtmode)
-- Retailoutlet (Roid, Location, Managerid)
-- Empdetails (Empid, Empname, Designation, Emailid, Contactno, Worksin, Salary)
-- Retailstock (Roid, Itemcode, Unitprice, Qtyavailable)
-- Customer (Custtype, Custname, Gender, Spouse, Emailid, Address, Custid)
-- Purchasebill (Billid, Roid, Itemcode, Custid, Billamount, Billdate, Quantity) 


-- 1. Identify the items which are purchased by customers of retail outlets. Display itemcode, itemtype, descr and category of those items. Display unique rows:

select itemcode, itemtype, descr, category 
from item where itemcode IN (select itemcode from purchasebill)

-- 2. Identify the item details that have the least quoted price with the quotation status as 'Rejected'. Display itemcode, itemtype, descr and category of those items:

select itemcode, itemtype, descr, category from item where itemcode in 
(select itemcode from quotation where Quotedprice = (select min(Quotedprice) from quotation) and Qstatus = 'Rejected')

-- or:

SELECT DISTINCT
    i.Itemcode,
    i.Itemtype,
    i.Descr,
    i.Category
FROM 
    Item i
JOIN 
    Quotation q ON i.Itemcode = q.Itemcode
WHERE 
    q.Quotedprice = (
        SELECT 
            MIN(Quotedprice) 
        FROM 
            Quotation 
        WHERE 
            Qstatus = 'Rejected'
    )
AND
    q.Qstatus = 'Rejected';


-- 3. The management would like to know the details of the items which has maximum quoted price amongst the quotations that have status as 'Closed' or 'Rejected'. Display itemcode and descr of those items:

SELECT 
    i.Itemcode,
    i.Descr
FROM 
    Item i
JOIN 
    (
        SELECT 
            Itemcode,
            MAX(Quotedprice) AS MaxQuotedPrice
        FROM 
            Quotation
        WHERE 
            Qstatus IN ('Closed', 'Rejected')
        GROUP BY 
            Itemcode
    ) q ON i.Itemcode = q.Itemcode
WHERE 
    q.MaxQuotedPrice = (
        SELECT 
            MAX(Quotedprice)
        FROM 
            Quotation
        WHERE 
            Qstatus IN ('Closed', 'Rejected')
    );


-- 4. Identify the item having second highest price. Display itemcode, descr and price of those items:

SELECT itemcode, descr, price
FROM (
    SELECT itemcode, descr, price,
           DENSE_RANK() OVER (ORDER BY price DESC) AS rn
    FROM item
) ranked_items
WHERE rn = 2;

-- for myqsl:

SELECT itemcode, descr, price
FROM (
    SELECT itemcode, descr, price,
           (SELECT COUNT(DISTINCT price) FROM item i2 WHERE i2.price > i1.price) AS rank
    FROM item i1
) ranked_items
WHERE rank = 1;


-- 5. Display the ename and job of the employees who own vehicle:

select ename, job from emp where empno in (select empno from empvehicle)

-- 6. Display the name of the employee who is drawing maximum salary:

select ename from emp where sal = (select max(sal) from emp)

-- 7. Identify the vehicle which is purchased by the maximum number of employees. Display empno and ename of the employees who have purchased the identified vehicles:

select empno, ename from emp where empno in 
(select empno from empvehicle where vehicleid in 
(select vehicleid from empvehicle group by vehicleid having count(empno) = 
(select max(empcount) from (select vehicleid, count(empno) as empcount from empvehicle group by vehicleid) 
)))


-- 8. Display the itemcode, descr and qdate for those items which are quoted below the maximum quoted price on the same day:

SELECT q1.Itemcode, i.Descr, q1.Qdate
FROM Quotation q1
INNER JOIN Item i ON q1.Itemcode = i.Itemcode
WHERE q1.Quotedprice < (
    SELECT MAX(q2.Quotedprice)
    FROM Quotation q2
    WHERE TRUNC(q1.Qdate) = TRUNC(q2.Qdate)
    GROUP BY TRUNC(q2.Qdate)
);


-- 9. Identify purchase bills in which the bill amount is less than or equal to the average bill amount of all the items purchased in the same retail outlet. Display billid and itemcode for the same:

select billid, itemcode from purchasebill pb1 where billamount <= (select avg(billamount) from purchasebill pb2 where pb1.roid = pb2.roid)


-- 10. Identify the supplier who has submitted the quotation for an item with the quoted price, 
--      less than the maximum quoted price submitted by all other suppliers, 
--      for the same item.Display sname, itemcode and item description for the identified supplier. 
--      Do not display duplicate records:

SELECT DISTINCT q.Sname, q.Itemcode, i.Descr
FROM Quotation q
INNER JOIN (
    SELECT Itemcode, MAX(Quotedprice) AS MaxQuotedPrice
    FROM Quotation
    GROUP BY Itemcode
) maxq ON q.Itemcode = maxq.Itemcode AND q.Quotedprice < maxq.MaxQuotedPrice
INNER JOIN Item i ON q.Itemcode = i.Itemcode
WHERE (q.sname != 'Shop Zilla' or q.itemcode != 'I1012') GROUP BY q.Sname, q.Itemcode, i.Descr;


-- 10. The payroll department requires the details of those employees who are getting the highest salary in each designation. 
--     Display empid, empname, designation and salary as per the given requirement.

SELECT empid, empname, designation, salary 
FROM empdetails ed1 
WHERE salary IN (
    SELECT MAX(salary) 
    FROM empdetails ed2 
    GROUP BY designation 
    HAVING ed1.designation = ed2.designation
);


-- 11.Display the customer id and customer name of those customers who have not purchased at all from any retail outlet. (Use Exists/Not Exists)

select custid, custname from customer c where not exists 
(select 1 from purchasebill p where c.custid = p.custid)

-- 12. Display the customer id and customer name of those customers who have purchased at least once from any retail outlet:

select custid, custname from customer c where exists (select 1 from purchasebill p where c.custid = p.custid)

-- Database structure:
-- Dept (Deptno, Dname, Loc)
-- Emp (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno)
-- Vehicle (Vehicleid, Vehiclename)
-- Empvehicle (Empno, Vehicleid) 


-- 13. Display the empno and ename of all those employees whose salary is greater than the average salary of all employees working in their departments:

select empno, ename from emp e1 where sal > (select avg(sal) from emp e2 group by deptno having e1.deptno = e2.deptno)

-- 14. Remove vehicle allocation from employees who have highest salary in their departments:

delete from empvehicle where empno in 
(select empno from emp e1 where sal = (select max(sal) from emp e2 group by deptno having e1.deptno = e2.deptno))

-- 15. Update the salary of employees with their department's average salary:

update emp e1 set sal = (select avg(sal) from emp e2 group by deptno having e1.deptno = e2.deptno)