SELECT *, 
(car_price-production_cost) * cars_sold as profit
FROM tesla_models 
GROUP BY tesla_model
ORDER BY profit DESC
LIMIT 1