
-- sum revenue,profit and profit margin
SELECT
SUM (sales) AS total_revenue_$,
    SUM(profit) AS total_profit_$,
    ROUND(SUM(profit) / SUM(sales) * 100, 3) AS profit_margin_pct
FROM order_item


-- Profit by Category
SELECT DISTINCT Category ,SUM (Profit) AS Total_Profit,SUM(Sales) AS Total_revenue
FROM Products p
Join Order_Item oi
ON p.Product_ID=oi.Product_ID
GROUP BY Category
ORDER BY Category desc

-- Sales Trend by Year/MONTH
SELECT
    MONTH(o.order_date) AS order_month,
    ROUND(AVG (sales), 2) AS Avarage_revenue,
    ROUND(AVG (profit), 2) AS Avarage_profit
FROM orders o
JOIN order_item oi
    ON o.order_id = oi.order_id
GROUP BY MONTH(o.order_date)
ORDER BY Avarage_profit DESC;

-- Sales Trend by Year
SELECT
    YEAR(o.order_date) AS order_year,
    ROUND(SUM(oi.sales), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM orders o
JOIN Order_Item oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY order_year;

SELECT  Region, SUM (Profit) AS Total_Profit,
SUM (Sales) as Total_Revenue,
ROUND ((SUM(Profit)/SUM (Sales))*100,1) AS Margin_Profit
FROM Order_Item oi
JOIN Orders o ON oi.Order_ID=o.Order_ID
JOIN Customers c ON o.Customer_ID=c.Customer_ID
GROUP BY Region
ORDER BY Total_Profit DESC

-- Top Product Sub-Categories
SELECT 
    p.Sub_Category,
    SUM(oi.Sales) AS total_revenue,
    SUM(oi.profit) AS total_profit,
    ROUND(SUM(oi.profit) / SUM(oi.sales) * 100, 2) AS profit_margin_pct
FROM Order_item oi
JOIN Products p
    ON oi.Product_ID = p.Product_ID
GROUP BY p.sub_category
ORDER BY profit_margin_pct DESC
 
 --Product Category Profitability
 SELECT
    p.category,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    CASE
        WHEN SUM(oi.profit) >= 100000 THEN 'High Profit'
        WHEN SUM(oi.profit) >= 50000 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS profit_level
FROM order_item oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;
