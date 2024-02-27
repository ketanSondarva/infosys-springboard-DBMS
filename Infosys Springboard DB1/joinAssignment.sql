

-- Dept (Deptno, Dname, Loc)
-- Emp (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno)
-- Vehicle (Vehicleid, Vehiclename)
-- Empvehicle (Empno, Vehicleid) 

-- 1. For each employee, identify the vehicle owned by them. Display ename and vehiclename for the same. Display name of employees even if they don't own any vehicle.

select e.ename, v.vehiclename from emp e left outer join empvehicle ev on e.empno = ev.empno
left outer join vehicle v on ev.vehicleid = v.vehicleid;


-- Database structure
-- Item (Itemcode, Itemtype, Descr, Price, Reorderlevel, Qtyonhand, Category)
-- Quotation (Quotationid, Sname, Itemcode, Quotedprice, Qdate, Qstatus)
-- Orders (Orderid, Quotationid, Qtyordered, Orderdate, Status, Pymtdate, Delivereddate, Amountpaid, Pymtmode)
-- Retailoutlet (Roid, Location, Managerid)
-- Empdetails (Empid, Empname, Designation, Emailid, Contactno, Worksin, Salary)
-- Retailstock (Roid, Itemcode, Unitprice, Qtyavailable)
-- Customer (Custid, Custtype, Custname, Gender, Spouse, Emailid, Address)
-- Purchasebill (Billid, Roid, Itemcode, Custid, Billamount, Billdate, Quantity) 

-- 1. Display retailoutlet location and customer type wise total quantity of items sold where customer's gender is Male and item type is Apparels or Computer:

select ro.location, c.custtype, sum(pb.quantity) TOTALQUANTITY from retailoutlet ro inner join purchasebill pb on pb.roid = ro.roid
inner join customer c on c.custid = pb.custid
inner join item i on pb.itemcode = i.itemcode
where c.gender = 'M' and (i.itemtype = 'Apparels' or i.itemtype = 'Computer') -- use parentheses, otherwise output will be different
group by ro.location, c.custtype;

-- 2. Display itemcode, descr, billamount and custid for all items of type 'FMCG'. Display billamount and custid as zero if item is not sold:

select i.itemcode, i.descr, coalesce(pb.billamount, 0) BILLAMOUNT, coalesce(pb.custid, 0) CUSTID 
from purchasebill pb right outer join item i on pb.itemcode = i.itemcode where itemtype = 'FMCG';

-- 3. For each item, identify the stock availability in the retail outlet R1001. Display itemcode, desc and qtyavailable for the same. If there is no stock available for an item, display 'N.A.' for its quantity on available:

select i.itemcode, i.descr, coalesce(to_char(rs.qtyavailable) 'N.A.') qtyavailable -- note that: to_char() wont work for mysql
from item i left outer join retailstock rs on i.itemcode = rs.itemcode and rs.roid = 'R1001';

-- 4. Display the customer id and customer name of those customers who are co-located. Do not display the duplicate records/rows:

select c.custid, c.custname from customer c inner join customer cs on c.address = cs.address where c.custid <> cs.custid;

