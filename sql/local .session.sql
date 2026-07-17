-- Advanced Queries 

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
      