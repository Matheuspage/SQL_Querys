--Tesla just provided their quarterly sales for their major vehicles.
--Determine which Tesla Model has made the most profit.
--Include all columns with the "profit" column at the end.

SELECT *, 
(car_price-production_cost) * cars_sold as profit
FROM tesla_models 
GROUP BY tesla_model
ORDER BY profit DESC
LIMIT 1


--If a patient is over the age of 50, cholesterol level of 240 or over, and weight 200 or greater, 
--then they are at high risk of having a heart attack.As Cholesterol level is the largest indicator, 
--order the output by Cholesterol from Highest to Lowest so he can reach out to them first.

-- THREE CONDITIONS (age, cholesterol and weight)
-- ORDER BY cholesterol
SELECT *
FROM patients 
WHERE age > 50 
  AND cholesterol >= 240 
  AND weight  >= 200
ORDER BY cholesterol DESC


--A Computer store is offering a 25% discount for all new customers over the age of 65 or customers that spend 
--more than $200 on their first purchase. Write a query to see how many customers received that discount.

-- TWO CONDITIONS (age and total_purchase)
SELECT COUNT(DISTINCT(customer_id))
FROM customers
WHERE age > 65 OR total_purchase > 200


--Write a query that returns all of the stores whose average yearly revenue is greater than one million dollars.
--Output the store ID and average revenue. Round the average to 2 decimal places.

--OUTPUT store_id and avg_revenue, ROUND 2 DECIMAL, average yearly revenue is greater than one million dollars.
-- ORDER BY ID
SELECT store_id, ROUND(AVG(revenue),2) as average_revenue
FROM stores
GROUP BY store_id
HAVING average_revenue > 1000000
ORDER BY store_id


--Write a Query to return bakery items that contain the word "Chocolate".

-- Chocolate in any part of the string
SELECT  *
FROM bakery_items
WHERE product_name LIKE "%Chocolate%"


--A video is considered low quality if the like percentage of the video (number of likes divided by the total number of votes) 
--is less than 55%. Return the result table ordered by ID in ascending order.

-- COLUMN WITH LIKE % AND ORDER BY
SELECT video_id
FROM youtube_videos
WHERE (thumbs_up/(thumbs_up + thumbs_down))*100 < 55
ORDER BY video_id ASC


--They figure the younger employees need their jobs more as they are growing families so they decide 
--to let go of their 3 oldest employees. Write a query to identify the ids of the three oldest employees. 
--Order output from oldest to youngest.

SELECT employee_id	
FROM employees 
ORDER BY birth_date ASC
LIMIT 3


--Below we have 2 tables, bread and meats
--Output every possible combination of bread and meats to help Yan in his endeavors.
--Order by the bread and then meat alphabetically. This is what Yan prefers.

SELECT bt.bread_name, mt.meat_name
FROM bread_table as bt
CROSS JOIN meat_table as mt
ORDER BY bt.bread_name, mt.meat_name


--After about 10,000 miles, Electric bike batteries begin to degrade and need to be replaced.
--Write a query to determine the amount of bikes that currently need to be replaced.

SELECT COUNT(bike_id) as bikes
FROM bikes
WHERE miles > 10000


--If a car has any critical issues it will fail inspection or if it has more than 3 minor issues it will also fail.
--Write a query to identify all of the cars that passed inspection.
--Output should include the owner name and vehicle name. Order by the owner name alphabetically.

SELECT owner_name, vehicle
FROM inspections
WHERE critical_issues = 0 AND minor_issues <=3
ORDER BY owner_name


--Return all the candidate IDs that have problem solving skills, SQL experience, knows Python or R, and has domain knowledge.
--Order output on IDs from smallest to largest.

SELECT candidate_id 
FROM candidates
WHERE problem_solving = 'X'
      AND sql_experience = 'X'
      AND domain_knowledge = 'X'
      AND (python = 'X' OR r_programming = 'X')
ORDER BY candidate_id


--Using the sales table, calculate how much money they have lost on their rotisserie chickens this year. 
--Round to the nearest whole number.

SELECT ROUND(SUM(lost_revenue_millions),0) AS lost_revenue_millions
FROM sales