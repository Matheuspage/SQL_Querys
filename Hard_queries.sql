--Write a query to find all dates with higher temperatures compared to the previous dates (yesterday).
--Order dates in ascending order.

WITH tb1 AS (
SELECT *, 
  LAG(temperature) OVER (ORDER BY date) AS previous_temp
FROM temperatures
) 
SELECT date 
FROM tb1
WHERE (temperature - previous_temp) > 0


--Write a query to report the difference between the number of Cakes and Pies sold each day.
--Output should include the date sold, the difference between cakes and pies, and which one sold more (cake or pie). 
--The difference should be a positive number. Return the result table ordered by Date_Sold.

WITH tb1 AS (
SELECT
    date_sold,
    SUM(CASE WHEN product = 'Cake' THEN amount_sold ELSE 0 END) AS Cake_sold,
    SUM(CASE WHEN product = 'Pie' THEN amount_sold ELSE 0 END) AS Pie_sold,
    SUM(CASE WHEN product = 'Cake' THEN amount_sold ELSE 0 END) -
    SUM(CASE WHEN product = 'Pie' THEN amount_sold ELSE 0 END) AS difference
FROM desserts
GROUP BY date_sold
ORDER BY date_sold
)
SELECT date_sold, 
  ABS(difference) AS difference,
  CASE WHEN difference > 0 THEN 'Cake' ELSE 'Pie' END AS sold_more
FROM tb1


--Write a query to select the 3rd transaction for each customer that received that discount. Output the customer id, transaction id, amount, 
--and the amount after the discount as "discounted_amount". Order output on customer ID in ascending order.
--Note: Transaction IDs occur sequentially. The lowest transaction ID is the earliest ID.

WITH tb1 AS (
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY customer_id, transaction_id ASC
    ) AS contador
FROM purchases
)
SELECT customer_id,
  transaction_id,
  amount,
  amount * 0.67 AS discounted_amount
FROM tb1
WHERE contador = 3