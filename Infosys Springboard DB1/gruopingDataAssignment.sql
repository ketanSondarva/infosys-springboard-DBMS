

-- 1. Display the month and number of quotations received in each month:

SELECT TO_CHAR(QDATE, 'Month') AS Month, COUNT(*) AS NumQuotations
FROM Quotation
GROUP BY TO_CHAR(QDATE, 'Month');


-- 2. Display the location and total number of Salesmen in each location:

select location, count(sname) NUMBER_SMAN from salesman group by location

-- 3. Display categories that have more than 1 product: 

select category from product group by category having count(prodid) > 1;


-- 4. Retrieve the itemcode and average of quantity available in retail outlets where the average of quantity available is less than 75:

select itemcode, avg(Qtyavailable) "Average Quantity" from retailstock group by itemcode having avg(Qtyavailable) < 75;

-- 5. Display pymtmode, and total number of payments for those payments which were paid before the year 2015 and total number of payments should be more than 1:

SELECT Pymtmode, COUNT(*) AS PYMTCOUNT
FROM Orders
WHERE EXTRACT(YEAR FROM Pymtdate) < 2015
GROUP BY Pymtmode
HAVING COUNT(*) > 1;

-- 6. Retrieve the Supplier Name for those quotations whose average quoted price for all quotations quoted by him is more than 500 and the quotation status is closed. Also display average quoted price:

select sname, avg(quotedprice) "Average quoted price" from quotation where qstatus = 'Closed' group by sname having avg(quotedprice) > 500;


-- 7 Retrieve the itemtype, category of item, and average price rounded to two decimal places of FMCG, Computer type items. The average price must be less than 2000:

select itemtype, category, round(avg(price),2) "Average item price" from item where itemtype = 'FMCG' OR itemtype = 'Computer' group by itemtype, category having avg(price) < 2000;


-- 8. Identify the average salary of the jobs 'MANAGER' and 'ANALYST'. Display job, average salary if the identified average salary is more than 1500:

select job, avg(sal) "Average Salary" from emp where job = 'MANAGER' or job = 'ANALYST' group by job having avg(sal) > 1500

-- 9. Display the job, deptno and average salary of employees belonging to department 10 or 20 and their salary is more than 2000 and average salary is more than 2500:

SELECT Job, Deptno, AVG(Sal) AS AVGSALARY
FROM Emp
WHERE Deptno IN (10, 20)
  AND Sal > 2000
GROUP BY Job, Deptno
HAVING AVG(Sal) > 2500;

-- 10. Retrieve the name of supplier who has quoted greater than 1000 and the quotation status is closed and average of quoted price is less than 4500. Also display average quoted price:

select sname, avg(Quotedprice) "Average quoted price" from quotation where Quotedprice > 1000 and Qstatus = 'Closed' group by sname having avg(Quotedprice) < 4500;

-- 11. Display name and salary of the employees, who are drawing salary more than 2000. Along with that display the department names in which they are working:

select e.ename, e.sal, d.dname from emp e 
inner join dept d on 
e.deptno = d.deptno where e.sal > 2000;

-- 12. Display the name of employees and their department names whose job designation is 'MANAGER': 

select e.ename, d.dname from emp e 
inner join dept d on 
e.deptno = d.deptno where e.job = 'MANAGER';

-- 13. List the department names that have more than one employee drawing salary more than 1500, working under it:

select d.dname from emp e 
inner join dept d on 
e.deptno = d.deptno
where e.sal > 1500
group by d.dname having count(e.empno) > 1;

-- 14. Display itemcode , item description and supplier name for all items for which quotations have been received from suppliers:

select i.itemcode, i.descr, q.sname from item i inner join quotation q on i.itemcode = q.itemcode;


-- 15. Display the custid and custname of those customers who are also employees. An employee and customer are considered same if their name and email id match:

select c.custid "Customer Id", c.custname "Customer Name" from customer c inner join empdetails e on lower(c.custname) = lower(substr(e.emailid, 1, length(c.custname)))


-- 16. The Manager of EasyShop would like to know details of those items for which quotations have been accepted. Display itemcode, item description, category and quotedprice for the same:

select i.itemcode, i.descr, i.category, q.quotedprice from item i inner join quotation q on i.itemcode = q.itemcode where qstatus = 'Accepted';


-- 17. The management of EasyShop would like to know the retail outlet ids and the details like description, type and retail unit price of items whose retail unit price is more than 1500:

select r.roid, i.descr, i.itemtype, r.unitprice from retailstock r
inner join item i on i.itemcode = r.itemcode
where  r.unitprice > 1500

-- 18. Display itemcode, supplier name and total quantity for the ordered items, whose total quantity ordered is greater than or equal to 100:

select q.itemcode, q.sname, sum(o.qtyordered) TOTALQUANTITY from quotation q 
inner join orders o on q.quotationid = o.quotationid 
group by q.itemcode, q.sname having sum(o.qtyordered) >= 100;

-- 19. The management wants the item code and description of the items whose item price matches with the quotation price for more than one quotation:

select i.itemcode, i.descr from item i 
inner join quotation q on q.itemcode = i.itemcode
where i.price = q.quotedprice
group by i.itemcode, i.descr having count(*) > 1;

-- 20. EasyShop management wants to know sname and quotationid pertaining to the quotation of those orders, where there is a difference of less than or equal to 5 days between the delivered date and order date. Display unique rows:

select distinct q.Quotationid, q.Sname
from Quotation q
join Orders o on q.Quotationid = o.Quotationid
where o.Delivereddate - o.Orderdate <= 5;

-- 21. Display custname and billamount for those customers who have shopped for more than 5000:

select c.custname, p.billamount from customer c inner join purchasebill p on c.custid = p.custid where p.billamount > 5000


-- 22. Retrieve the retailoutlet and the number of items stocked for that outlet:

select roid, count(itemcode) "Number of items" from retailstock group by roid;

