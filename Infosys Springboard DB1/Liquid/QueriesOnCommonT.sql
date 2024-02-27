

-- Write a query to display Product Id, Product Description and Category of those products whose category name is electronics. 
--   Do case insensitive comparison.

select prodid, pdesc, category from product where LOWER(category) = 'electronics';

-- Write a query to display the product id, first five characters of product description and category of those products:

select prodid, SUBSTR(pdesc, 1, 5) PDESC_FIVE, category from product;

-- Write a query to display the number of sales that were made in the last 40 months:

SELECT COUNT(*) sale_count FROM sale WHERE sldate >= DATE_SUB(NOW(), INTERVAL 40 MONTH); -- here count(*) is used to count the number of rows in resutant relation

-- Write a query to display the product description and discount for all the products. 
--- Display the value 'No Description' if description is not having any value i.e. NULL.

SELECT COALESCE(pdesc, 'No Description') pdesc, discount from product;
