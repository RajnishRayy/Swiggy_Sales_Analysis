-- CREATED DATABASE 
CREATE DATABASE IF NOT EXISTS swiggy_sales;

-- CREATED TABLE AND COLUMNS 
CREATE TABLE IF NOT EXISTS swiggy(
   restaurant_no   INTEGER  NOT NULL 
  ,restaurant_name VARCHAR(50) NOT NULL
  ,city            VARCHAR(9) NOT NULL
  ,address         VARCHAR(204)
  ,rating          NUMERIC(3,1) NOT NULL
  ,cost_per_person INTEGER 
  ,cuisine         VARCHAR(49) NOT NULL
  ,restaurant_link VARCHAR(136) NOT NULL
  ,menu_category   VARCHAR(66)
  ,item            VARCHAR(188)
  ,price           VARCHAR(12) NOT NULL
  ,veg_or_nonveg   VARCHAR(7)
);

-- ------------------------------------QUESTIONS---------------------------------------------
-- 1) HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
SELECT COUNT(DISTINCT(restaurant_name)) AS cnt_restaurant
FROM swiggy
WHERE rating>4.5;

-- 2) WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
SELECT city,
     COUNT(DISTINCT(restaurant_name)) AS cnt_restaurant
FROM swiggy
GROUP BY city
ORDER BY cnt_restaurant DESC
LIMIT 1;

-- 3) HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
SELECT  COUNT(DISTINCT(restaurant_name)) AS cnt_restaurant
FROM swiggy
WHERE restaurant_name LIKE "%PIZZA%";

-- 4) WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
SELECT cuisine,
     COUNT(cuisine) AS cnt
FROM swiggy
GROUP BY cuisine
ORDER BY cnt DESC;

-- 5) WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
SELECT city,
     ROUND(AVG(rating),2) AS avg_rating
FROM swiggy
GROUP BY city;

-- 6) WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?
SELECT restaurant_name, menu_category, 
     MAX(price) AS Highest_price
FROM swiggy
WHERE menu_category = 'Recommended'
GROUP BY restaurant_name, menu_category;

-- 7) FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE.
SELECT DISTINCT(restaurant_name), cost_per_person
FROM swiggy
WHERE menu_category != 'Indian '
ORDER BY cost_per_person DESC
LIMIT 5;

-- 8) FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER. 
SELECT restaurant_name,
	 ROUND(AVG(cost_per_person),2) AS avg_cost
FROM swiggy
GROUP BY restaurant_name
HAVING avg_cost > (select ROUND(AVG(cost_per_person),2) FROM swiggy)
ORDER BY avg_cost DESC;

-- 9) RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES. 
SELECT DISTINCT t1.restaurant_name,t1.city,t2.city
FROM swiggy t1 JOIN swiggy t2 
ON t1.restaurant_name=t2.restaurant_name AND
t1.city<>t2.city;

-- 10) WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?
SELECT DISTINCT restaurant_name,menu_category,
			  COUNT(item) AS cnt
FROM swiggy
WHERE menu_category = "Main Course"
GROUP BY restaurant_name,menu_category
ORDER BY cnt DESC;

-- 11) LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.
SELECT DISTINCT restaurant_name,
             (COUNT(CASE WHEN veg_or_nonveg='Veg' THEN 1 END)*100/
(COUNT(*)))AS vegetarian_percetage
FROM swiggy
GROUP BY restaurant_name
HAVING vegetarian_percetage=100.00
ORDER BY restaurant_name;

-- 12) WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
SELECT restaurant_name,
     ROUND(AVG(price),2) AS avg_price
FROM swiggy
GROUP BY restaurant_name
ORDER BY avg_price;

-- 13) WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
SELECT restaurant_name,
     COUNT(DISTINCT(menu_category)) AS cnt
FROM swiggy
GROUP BY restaurant_name
ORDER BY cnt DESC
LIMIT 5;

-- 14) WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
SELECT DISTINCT restaurant_name,
             (COUNT(CASE WHEN veg_or_nonveg='Non-Veg' THEN 1 END)*100/
(COUNT(*)))AS non_veg_pct
FROM swiggy
GROUP BY restaurant_name
ORDER BY non_veg_pct DESC
LIMIT 1;


