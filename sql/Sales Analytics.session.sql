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

-- Query 11

SELECT 
	ROUND(AVG(`Shipping Days`) , 2 ) AS Avg_Shipping_Days 
FROM sales ; 

-- Query 12

SELECT 
	Segment , 
    ROUND(SUM(Sales), 2 ) AS Sales , 
    ROUND(SUM(Profit), 2) AS Profit 
FROM sales
GROUP BY Segment
ORDER BY Sales DESC ; 

-- Advanced SQL 


-- Query 13

WITH customer_sales AS (
SELECT	
	Region , 
    `Customer Name` , 
    ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY Region , `Customer Name`
)
SELECT *
FROM ( 
	SELECT * , 
		DENSE_RANK() OVER(
        PARTITION BY Region 
        ORDER BY Total_Sales DESC
        ) AS Customer_Rank 
	FROM customer_sales
) ranked
WHERE Customer_Rank <= 5 ;

-- Query 14

WITH monthly_sales AS (
	SELECT 
		Year , 
        Month , 
        ROUND(SUM(Sales),2) AS Sales 
	FROM sales 
    GROUP BY Year , Month 
)
SELECT 
	Year , 
    Month ,
	ROUND(
		SUM(Sales) OVER (
		PARTITION BY Year 
		ORDER BY month
    ) ,
    2 ) AS Running_Total
FROM monthly_sales ; 
    
-- Query 15

SELECT 
	`Product Name` , 
    ROUND(SUM(Profit),2) AS Profit , 
    
    CASE 
		WHEN SUM(Profit) < 0 THEN 'Loss' 
        WHEN SUM(Profit) < 500 THEN 'Low Profit'
        WHEN SUM(Profit) < 5000 THEN  'Medium Profit'
        ELSE 'High Profit'
	END AS Profit_Category 

FROM sales
GROUP BY `Product Name`
ORDER BY Profit DESC 
LIMIT 100; 

-- Query 16

SELECT 
	`Product Name` , 
    ROUND(SUM(Profit),2) AS Profit 
FROM sales
GROUP BY `Product Name` 
ORDER BY Profit DESC 
LIMIT 10 ; 

-- Query 17

SELECT 
	`Product Name` , 
    ROUND(SUM(Profit), 2) AS Profit
FROM sales
GROUP BY `Product Name`
ORDER BY Profit 
LIMIT 10 ; 

-- Query 18

SELECT 
	Segment , 
    COUNT(DISTINCT `Customer ID` ) AS Customers , 
    ROUND(SUM(Sales),2) AS Sales ,
    ROUND(AVG(Sales),2) AS Avg_Order_Value 
FROM sales
GROUP BY Segment ; 

-- Query 19

SELECT 
	Category , 
    ROUND(AVG(Discount)*100 , 2 ) AS Avg_Discount_Percentage 
FROM sales 
GROUP BY Category ;

-- Query 20

SELECT 
	`Product Name` ,
    SUM(Quantity) AS Quantity_Sold 
FROM sales 
GROUP BY `Product Name`
HAVING Quantity_Sold > 
(
	SELECT AVG(total_qty )
    FROM 
    (
		SELECT 
			SUM(Quantity) AS total_qty 
		FROM sales
        GROUP BY `Product Name`
	) t
) 
ORDER BY Quantity_Sold DESC ; 

-- Query 21

SELECT 
	Region , 
    ROUND(SUM(Sales),2) AS Sales , 
    ROUND(
		SUM(Sales) / 
        ( SELECT SUM(Sales) FROM sales ) * 100 , 
        2 
	) AS Sales_Percentage 
FROM sales 
GROUP BY Region  ;

-- Query 22

WITH yearly_sales AS
(	
	SELECT 
		Year , 
        SUM(Sales) AS Sales 
        FROM sales 
        GROUP BY Year 
)
SELECT 
	Year , 
    Sales , 
    LAG(Sales) OVER(ORDER BY Year) AS Previous_Year , 
    ROUND(
		(Sales-LAG(Sales) OVER (ORDER BY Year)) / 
		LAG(Sales) OVER( ORDER BY Year ) * 
		100 ,
    2 ) AS YoY_Growth
FROM yearly_sales ;
    
-- Query 23
        
WITH product_sales AS
(
	SELECT
		Category , 
		`Product Name` , 
		SUM(Sales) AS Sales 
    FROM sales
    GROUP BY Category , `Product Name` 
)

SELECT * 
FROM 
	( 
		SELECT * , 
        ROW_NUMBER() OVER (
			PARTITION BY Category 
            ORDER BY Sales DESC 
		) AS rn 
	FROM product_sales
    ) t
WHERE rn <= 3 ; 

-- Query 24

SELECT 
	`Order ID` , 
    `Product Name` , 
    Discount , 
    ROUND(Profit,2)  
FROM Sales 

WHERE 
	Discount >= 0.3 
    AND 
    Profit < 0 
ORDER BY ROUND(Profit,2) 
LIMIT 100 ; 
      






















