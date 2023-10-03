-- 1. How many customers do we have each day? Are there any peak hours?
SELECT
    DATE(date) AS order_date,
    COUNT(DISTINCT order_id) AS total_customers,
    EXTRACT(HOUR FROM time) AS hour_of_day
FROM Orders
GROUP BY order_date, hour_of_day
ORDER BY total_customers DESC;

-- 2. How many pizzas are typically in an order? Do we have any bestsellers?
-- Average number of pizzas per order
SELECT AVG(quantity) AS avg_pizzas_per_order
FROM Order_Details;

-- Bestselling pizzas
SELECT pizza_id, SUM(quantity) AS total_sold
FROM Order_Details
GROUP BY pizza_id
ORDER BY total_sold DESC
LIMIT 5;  -- Change the limit as needed to see more top sellers

-- 3. How much money did we make this year in each month? Can we identify any seasonality in the sales?
SELECT
    MONTHNAME(date) AS month,
    SUM(Price * quantity) AS revenue
FROM Orders
JOIN Order_Details ON Orders.order_id = Order_Details.order_id
JOIN Pizzas ON Order_Details.pizza_id = Pizzas.pizza_id
-- WHERE YEAR(date) = YEAR(CURDATE())  -- Replace with the desired year
GROUP BY month
ORDER BY revenue DESC;

-- 4. Are there any pizzas we should take off the menu, or any promotions we could leverage?
SELECT pizza_id, SUM(quantity) AS total_sold
FROM Order_Details
GROUP BY pizza_id
ORDER BY total_sold
; 

-- 5. What is the average order value for each pizza category (e.g., Vegetarian, Non-Vegetarian, etc.)?
SELECT PT.Category, AVG(P.Price * OD.quantity) AS avg_order_value
FROM Pizzas P
JOIN Order_Details OD ON P.pizza_id = OD.pizza_id
JOIN Pizza_Types PT ON P.pizza_type_id = PT.pizza_type_id
GROUP BY PT.Category
ORDER BY avg_order_value DESC;

-- 6. Are there any trends in sales based on the day of the week?
 
SELECT
    DAYNAME(date) AS day_of_week,
    SUM(Price * quantity) AS total_sales
FROM Orders
JOIN Order_Details ON Orders.order_id = Order_Details.order_id
JOIN Pizzas ON Order_Details.pizza_id = Pizzas.pizza_id
GROUP BY day_of_week
ORDER BY total_sales DESC;



