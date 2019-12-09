--find the total sales ($$) and number of orders per month in the database (northwind).
-- don't worry about months with no sales.


-- Query 1
SELECT EXTRACT(YEAR FROM OrderDate) AS year, 
    EXTRACT(MONTH FROM OrderDate) AS month, 
    COUNT(DISTINCT OrderId) AS total_orders, 
    SUM((UnitPrice * Quantity)*(1-Discount)) AS total_sales
FROM Orders INNER JOIN OrderDetails USING(OrderID)
GROUP BY year, month
ORDER BY year, month



--- Answer 1

 year | month | total_orders | total_sales
------+-------+--------------+-------------
 2014 |     7 |           22 |   28169.095
 2014 |     8 |           25 |   25485.275
 2014 |     9 |           23 |     26381.4
 2014 |    10 |           26 |   37515.725
 2014 |    11 |           25 |   45600.045
 2014 |    12 |           31 |    45239.63
 2015 |     1 |           33 |    61258.07
 2015 |     2 |           29 |   38483.635
 2015 |     3 |           30 |    38547.22
 2015 |     4 |           31 |  53032.9525
 2015 |     5 |           32 |    53781.29
 2015 |     6 |           30 |  36362.8025
 2015 |     7 |           33 |  51020.8575
 2015 |     8 |           33 |    47287.67
 2015 |     9 |           37 |  55629.2425
 2015 |    10 |           38 |   66749.226
 2015 |    11 |           34 |   43533.809
 2015 |    12 |           48 |  71398.4285
 2016 |     1 |           55 |  94222.1105
 2016 |     2 |           54 |  99415.2875
 2016 |     3 |           73 |  104854.155
 2016 |     4 |           74 | 124052.3025
 2016 |     5 |           14 |  18333.6305
(23 rows)


-- Which month has the highest average sales ($$) over every year of the database?
--(hint you can either start from scratch or make use of the previous answer)

-- Query 2

WITH totals_month_year AS (
    SELECT EXTRACT(YEAR FROM OrderDate) AS year, 
    EXTRACT(MONTH FROM OrderDate) AS month, 
    COUNT(DISTINCT OrderId) AS total_orders, 
    SUM((UnitPrice * Quantity)*(1-Discount)) AS total_sales
    FROM Orders INNER JOIN OrderDetails USING(OrderID)
    GROUP BY year, month
    ORDER BY year, month)

SELECT month, SUM(total_sales) AS total_sales
FROM totals_month_year
GROUP BY month
ORDER BY total_sales DESC;

-- Answer 2

month | total_sales
-------+-------------
     4 |  177085.255
     1 | 155480.1805
     3 |  143401.375
     2 | 137898.9225
    12 | 116638.0585
    10 |  104264.951
    11 |   89133.854
     9 |  82010.6425
     7 |  79189.9525
     8 |   72772.945
     5 |  72114.9205
     6 |  36362.8025
(12 rows)