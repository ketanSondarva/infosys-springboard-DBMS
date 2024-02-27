

-- CROSS Join is also referred to as Cartesian Product. 
-- A CROSS join with m rows in table A and n rows in table B will always produce m * n rows. 
-- Essentially it combines each row from the first table with each row of the second table. 
-- A cross join is rarely used as it mostly produces lot of meaningless data. However it is useful to understand the concept of other joins. 
-- Let us understand this join using Employee and Computer tables.

SELECT E.ID, E.ENAME, E.COMPID AS E_COMPID, C.COMPID, C.Model
FROM Employee E CROSS JOIN Computer C

