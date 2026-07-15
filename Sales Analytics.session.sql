-- USE sales_analytics;

-- Query 1

SELECT
	ROUND(SUM(Sales),2) AS Total_Sales
FROM sales ; 

-- Query 2 

SELECT 
	ROUND(SUM(Profit),2) AS Total_Profit 
FROM sales ; 

-- Query 3 

SELECT 
	COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM sales ; 

-- Query 4

SELECT 	
	ROUND (
		SUM(Sales) / 
        COUNT(DISTINCT `Order ID`) ,
        2)
        AS Average_Order_Value 
FROM sales ; 

-- Query 5

SELECT
	Region , 
    ROUND(SUM(Sales),2) AS Total_Sales , 
    ROUND(SUM(Profit),2) AS Total_Profit 
FROM sales
GROUP BY Region
ORDER BY Total_Sales DESC ; 

-- Query 6

SELECT 
	Category , 
    ROUND(SUM(Sales) , 2 ) AS Total_Sales , 
    ROUND(SUM(Profit) , 2 ) AS Total_Profit 
FROM sales 
GROUP BY Category 
ORDER BY Total_Sales DESC ; 

-- Query 7 

SELECT 
	`Customer Name` , 
    ROUND(SUM(Sales),2) AS Sales 
FROM sales 
GROUP BY `Customer Name`
ORDER BY Sales DESC 
LIMIT 10 ; 

-- Query 8

SELECT 
	`Product Name` ,
    ROUND(SUM(Sales) , 2 ) AS Sales
FROM sales
GROUP BY `Product Name`
ORDER BY Sales DESC 
LIMIT 10 ; 

-- Query 9 

SELECT 
	Year , 
    `Month Name` , 
    ROUND(SUM(Sales) , 2 ) AS Total_Sales 
FROM sales 
GROUP BY 
	Year , 
    Month , 
    `Month Name`
ORDER BY 
	Year , 
    Month ; 

-- Query 10

SELECT 
	`Product Name` , 
    ROUND(SUM(Profit),2) AS Total_Profit 
FROM sales 
GROUP BY `Product Name` 
HAVING SUM(Profit) < 0 
ORDER BY Total_Profit ; 

-- Query 10

SELECT 
	ROUND(AVG(`Shipping Days`) , 2 ) AS Avg_Shipping_Days 
FROM sales ; 

-- Query 11

SELECT 
	Segment , 
    ROUND(SUM(Sales), 2 ) AS Sales , 
    ROUND(SUM(Profit), 2) AS Profit 
FROM sales
GROUP BY Segment
ORDER BY Sales DESC ; 
























