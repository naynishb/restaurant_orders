SELECT *
FROM restaurant_db.menu_items;

SELECT *
FROM restaurant_db.order_details;

-- View the menu_items table and write a query to find the number of items on the menu
SELECT count(*)
FROM restaurant_db.menu_items;

-- What are the least and most expensive items on the menu?
SELECT *
FROM restaurant_db.menu_items
ORDER BY price
LIMIT 1;

SELECT *
FROM restaurant_db.menu_items
ORDER BY price desc
LIMIT 1;

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?

SELECT COUNT(*)
FROM restaurant_db.menu_items
WHERE CATEGORY = "ITALIAN";

SELECT *
FROM restaurant_db.menu_items
WHERE CATEGORY = "ITALIAN"
ORDER BY PRICE ASC
LIMIT 1;



SELECT *
FROM restaurant_db.menu_items
WHERE CATEGORY = "ITALIAN"
ORDER BY PRICE DESC
LIMIT 1;

-- How many dishes are in each category? What is the average dish price within each category?


SELECT CATEGORY,count(*)
FROM restaurant_db.menu_items
GROUP BY CATEGORY;



SELECT CATEGORY,ROUND(avg(PRICE),2)
FROM restaurant_db.menu_items
GROUP BY CATEGORY;



-- View the order_details table. What is the date range of the table?

SELECT *
FROM restaurant_db.order_details;

SELECT MIN(order_date),MAX(order_date)
FROM restaurant_db.order_details;

-- How many orders were made within this date range? How many items were ordered within this date range?

SELECT COUNT(DISTINCT ORDER_ID)
FROM restaurant_db.order_details;

SELECT COUNT(*)
FROM restaurant_db.order_details;

-- Which orders had the most number of items?

SELECT ORDER_ID,COUNT(*) AS nUM_ITEMS
FROM restaurant_db.order_details
GROUP BY order_id
ORDER BY nUM_ITEMS DESC
LIMIT 10;




-- How many orders had more than 12 items?
SELECT COUNT(*)
FROM (SELECT ORDER_ID,COUNT(item_id) AS nUM_ITEMS
FROM restaurant_db.order_details
GROUP BY order_id
HAVING nUM_ITEMS > 12) num_orders;


-- Combine the menu_items and order_details tables into a single table

SELECT *
FROM restaurant_db.order_details OD LEFT JOIN restaurant_db.menu_items MENU 
	ON OD.item_id=MENU.menu_item_id;

-- What were the least and most ordered items? What categories were they in?

SELECT item_name,COUNT(order_details_id) NUM_PURCH,CATEGORY
FROM restaurant_db.order_details OD LEFT JOIN restaurant_db.menu_items MENU 
	ON OD.item_id=MENU.menu_item_id
GROUP BY item_name,category
ORDER BY NUM_PURCH
LIMIT 1;


SELECT item_name,COUNT(order_details_id) NUM_PURCH,CATEGORY
FROM restaurant_db.order_details OD LEFT JOIN restaurant_db.menu_items MENU 
	ON OD.item_id=MENU.menu_item_id
GROUP BY item_name,category
ORDER BY NUM_PURCH DESC
LIMIT 1;

-- What were the top 5 orders that spent the most money?
SELECT order_id,SUM(PRICE) AS TOTAL_SPENT
FROM restaurant_db.order_details OD LEFT JOIN restaurant_db.menu_items MENU 
	ON OD.item_id=MENU.menu_item_id
GROUP BY order_id
ORDER BY TOTAL_SPENT DESC
LIMIT 5;



-- View the details of the highest spend order. Which specific items were purchased?

SELECT category,COUNT(item_id)
FROM restaurant_db.order_details OD LEFT JOIN restaurant_db.menu_items MENU 
	ON OD.item_id=MENU.menu_item_id
WHERE order_id=440
GROUP BY category;


-- BONUS: View the details of the top 5 highest spend orders
SELECT category,COUNT(item_id),order_id
FROM restaurant_db.order_details OD LEFT JOIN restaurant_db.menu_items MENU 
	ON OD.item_id=MENU.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY category,order_id;





