--If a customer is 55 or above they qualify for the senior citizen discount. Check which customers qualify.
--Assume the current date 1/1/2023. Return all of the Customer IDs who qualify for the senior citizen discount in ascending order.

SELECT customer_id
FROM customers
WHERE TIMESTAMPDIFF(YEAR, birth_date, '2023-01-01') >= 55
ORDER BY customer_id ASC


--Popularity is defined by number of actions (likes, comments, shares, etc.) divided by the number impressions the post received * 100.
--If the post receives a score higher than 1 it was very popular. Return all the post IDs and their popularity 
--where the score is 1 or greater. Order popularity from highest to lowest.

SELECT post_id, (actions/impressions)*100 as popularity
FROM linkedin_posts
HAVING popularity > 1
ORDER BY popularity DESC

--If our company hits its yearly targets, every employee receives a salary increase depending on what level you are in the company.
--Give each Employee who is a level 1 a 10% increase, level 2 a 15% increase, and level 3 a 200% increase.

SELECT *, 
  CASE
    WHEN pay_level = 1 THEN salary * 1.1
    WHEN pay_level = 2 THEN salary * 1.15
    WHEN pay_level = 3 THEN salary * 3 -- OR x * (1 + 2) with the 2 beeing the %
    ELSE salary
  END AS new_salary
FROM employees


--We need to identify people who may fall into that category. Write a query to find the people who spent a higher than average amount of time on social media.
--Provide just their first names alphabetically so we can reach out to them individually.

SELECT users.first_name 
FROM user_time
LEFT JOIN users ON user_time.user_id = users.user_id
WHERE user_time.media_time_minutes > (
  SELECT AVG(media_time_minutes)
  FROM user_time
)
ORDER BY users.first_name ASC


--She sometimes gives away a bike for free for a charity event and if she does she leaves the price of the bike as blank, but marks it sold.
--Write a query to show her the average sale price of bikes for only bikes that were sold, and not donated.
--Round answer to 2 decimal places.

SELECT ROUND(AVG(bike_price),2) as avg_price_bikes_sold
FROM inventory
WHERE bike_sold = 'Y' AND bike_price IS NOT NULL

--Write a query to determine how many direct reports each Manager has. Note: Managers will have "Manager" in their title.
--Report the Manager ID, Manager Title, and the number of direct reports in your output.

SELECT tb2.employee_id, tb2.position, COUNT(tb1.managers_id) AS direct_reports
FROM direct_reports AS tb1
LEFT JOIN direct_reports AS tb2 ON tb1.managers_id = tb2.employee_id
WHERE tb2.position LIKE '%Manager%'
GROUP BY tb2.position

--But which region spends the most money on fast food?
--Write a query to determine which region spends the most amount of money on fast food.

SELECT region
FROM food_regions
GROUP BY region
ORDER BY SUM(fast_food_millions) DESC
LIMIT 1


--Kroger's is a very popular grocery chain in the US. They offer a membership card in exchange for a 
--discount on select items. Customers can still shop at Krogers without the card.
--Write a query to find the percentage of customers who shop at Kroger's who also have a Kroger's membership card. 
--Round to 2 decimal places.

SELECT ROUND(
        (COUNT(CASE WHEN has_member_card = 'Y' THEN kroger_id END) 
        / COUNT(kroger_id)*100),
        2
    ) AS percentage_of_card_customers
FROM customers


--Write a query to determine the percentage of employees that were laid off from each company.
--Output should include the company and the percentage (to 2 decimal places) of laid off employees.

Order by company name alphabetically.
SELECT company, ROUND(((employees_fired/company_size)*100),2) as Percentage_Laid_Off
FROM tech_layoffs
ORDER BY company


--Write a query to separate the ID and First Name into two separate columns.
--Each ID is 5 characters long.

SELECT LEFT(id,5) AS ID,
  SUBSTRING(id, 6) AS First_Name
FROM bad_data

--Here you are given a table that contains a customer ID and their full name.
--Return the customer ID with only the first name of each customer

SELECT customer_id,
  SUBSTRING(full_name, 1, POSITION(' ' IN full_name)) AS First_Name
FROM customers