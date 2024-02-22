-- EXCERCISE - 40:

SELECT Sid, Sname, Location
FROM Salesman
WHERE Sname LIKE '%e%' AND Location LIKE '%o%'
UNION ALL
-- Salesmen whose name contains 'a' and location contains 'a'
SELECT Sid, Sname, Location
FROM Salesman
WHERE Sname LIKE '%a%' AND Location LIKE '%a%';

-- EXCERCISE - 41:

SELECT PRODID, PDESC, CATEGORY, DISCOUNT
FROM Product
WHERE DISCOUNT < 10
UNION ALL
SELECT PRODID, PDESC, CATEGORY, DISCOUNT
FROM Product
WHERE CATEGORY = 'Sports';

-- EXCERCISE - 42:

SELECT PRODID, PDESC, CATEGORY, DISCOUNT
FROM Product
WHERE DISCOUNT < 10 OR CATEGORY = 'Sports';

-- EXCERCISE - 43:



-- EXERCISE - 44:
SELECT e.id, e.ename, e.dept, e.compid, c.make from employee e inner join computer c on e.compid = c.compid



-- EXERCISE - 15:

select sm.sid, sm.sname, sm.location from salesman sm inner join salesman smm on sm.location = smm.location where sm.sid <> smm.sid;

-- 49:
select sm.sname, s.saleid from salesman sm left outer join sale s on sm.sid = s.sid

-- 50:

select sm.sid, sm.sname, SUM(p.price * sd.quantity) as "TAMOUNT", SUM((p.price * sd.quantity) * p.discount/100) AS "TDISCOUNT" 
from salesman sm inner join sale s on sm.sid = s.sid 
inner join saledetail sd on s.saleid = sd.saleid 
inner join product p on sd.prodid = p.prodid group by sm.sid, sm.sname 
order by SUM(p.price * sd.quantity) desc, SUM((p.price * sd.quantity) * p.discount/100) desc;

-- 51:
select s.saleid, p.prodid, sm.sid, sm.sname 
from salesman sm inner join sale s on sm.sid = s.sid inner join saledetail sd on sd.saleid = s.saleid 
inner join product p on sd.prodid = p.prodid

-- 17:

select sm.sid, sm.sname, NVL(SUM(p.price * sd.quantity), 0) AS "TAMOUNT" 
NVL(SUM((p.price * sd.quantity) * p.discount / 100), 0) AS "TDISCOUNT" from salesman sm 
left outer join sale s on sm.sid = s.sid 
left outer join saledetail sd on s.saleid = sd.saleid 
left outer join product p on sd.prodid = p.prodid group by sm.sid, sm.sname


-- 54:
select e.ename, e.dept, NVL(c.model, 'Not allocated') as "MODEL" from employee e left outer join computer c on c.compid = e.compid 

-- 55:
select e.id, e.ename, e.dept, c.model from employee e full outer join computer c on e.compid = c.compid

-- 56:

SELECT 
    e1.Id AS ID,
    e1.Ename AS ENAME,
    e1.Manager AS MGRID,
    e2.Ename AS MGRNAME,
    c1.Model AS E_MODEL,
    c2.Model AS M_MODEL
FROM 
    Employee e1
JOIN 
    Employee e2 ON e1.Manager = e2.Id
JOIN 
    Computer c1 ON e1.Compid = c1.Compid
JOIN 
    Computer c2 ON e2.Compid = c2.Compid;

-- 57:

SELECT 
    S.Sid AS SID,
    S.Sname AS SNAME
FROM 
    Salesman S
LEFT JOIN 
    Sale SL ON S.Sid = SL.Sid
WHERE 
    SL.Sid IS NULL;


-- 16:

SELECT 
    Prodid AS Product_ID,
    Category,
    Price
FROM 
    Product
WHERE 
    Price IN (
        SELECT Price
        FROM Product
        GROUP BY Price
        HAVING COUNT(*) > 1
    );


-- AS: 78:

SELECT 
    COALESCE(E.Empname, 'No Manager') AS EMPNAME,
    I.Category,
    SUM(R.Qtyavailable) AS TOTALQUANTITY
FROM 
    Retailoutlet RO
LEFT JOIN 
    Empdetails E ON RO.Managerid = E.Empid
LEFT JOIN 
    Retailstock R ON RO.Roid = R.Roid
LEFT JOIN 
    Item I ON R.Itemcode = I.Itemcode
GROUP BY 
    COALESCE(E.Empname, 'No Manager'), I.Category;


-- AS 80:
SELECT 
    I.Itemcode,
    I.Descr,
    COALESCE(PB.Billamount, 0) AS Billamount,
    COALESCE(PB.Custid, 0) AS Custid
FROM 
    Item I
LEFT JOIN 
    Purchasebill PB ON I.Itemcode = PB.Itemcode
WHERE 
    I.Itemtype = 'FMCG';

-- AS 16:

SELECT 
    I.Itemcode,
    I.Descr,
    COALESCE(TO_CHAR(RS.Qtyavailable), 'N.A.') AS Qtyavailable
FROM 
    Item I
LEFT JOIN 
    Retailstock RS ON I.Itemcode = RS.Itemcode AND RS.Roid = 'R1001';


-- AS 82:

-- AS 19:

SELECT 
    ED.Empname,
    ED.Designation,
    ED.Emailid
FROM 
    Empdetails ED
JOIN 
    Retailoutlet RO ON ED.Worksin = RO.Roid
WHERE 
    RO.Location = (
        SELECT 
            Location
        FROM 
            Retailoutlet
        JOIN 
            Empdetails ON Retailoutlet.Roid = Empdetails.Worksin
        WHERE 
            Empdetails.Empname = 'George'
    )
AND
    ED.Empname != 'George';


-- AS 97:

SELECT 
    I.Itemcode,
    I.Descr AS DESCR,
    RO.Location AS LOCATION,
    RS.Qtyavailable AS QTYAVAILABLE
FROM 
    Item I
INNER JOIN 
    Retailstock RS ON I.Itemcode = RS.Itemcode
INNER JOIN 
    Retailoutlet RO ON RS.Roid = RO.Roid
WHERE 
    I.Itemtype = 'Apparels';


-- AS 98:

SELECT 
    I.Itemcode,
    I.Descr AS DESCR,
    RS.Roid,
    RS.Qtyavailable
FROM 
    Item I
JOIN 
    Retailstock RS ON I.Itemcode = RS.Itemcode;

-- AS 91:

SELECT 
    Custid,
    Custname,
    Custtype
FROM 
    Customer
WHERE 
    Custid <> 2004
    AND Custtype = (
        SELECT 
            Custtype
        FROM 
            Customer
        WHERE 
            Custid = 2004
);

-- AS 82:

SELECT
    ro.Roid,
    ro.Location,
    ed.Empid,
    ed.Empname
FROM
    Retailoutlet ro
LEFT JOIN
    Empdetails ed ON ro.Roid = ed.Worksin;




