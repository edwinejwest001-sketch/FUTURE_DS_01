# SQL Analysis Description

This file documents the main SQL queries used in the **Superstore Sales Analysis using SQL** project.
The objective of these queries is to answer key business questions related to revenue, profit, customers, products, and regional performance.

    ---

## Analysis 1: Overall Business Performance

### Business Question
What are the total revenue, total profit, and overall profit margin?
    
-- sum revenue,profit and profit margin
    
SELECT
SUM (sales) AS total_revenue_$,
    SUM(profit) AS total_profit_$,
    ROUND(SUM(profit) / SUM(sales) * 100, 3) AS profit_margin_pct
FROM order_item
    
 ### Result  
|total_revenue | total_profit | profit_margin_pct|
|2296919.39 | 286828.62 | 12.488%|
    
   ### Insight
The business generated over $2.3M in sales with an overall profitability of around 12.49%. 

 ## Analysis 2 : Revenue and Profit by Product Category

### Business Question
Which product categories generate the most revenue and profit? 
-- Profit by Category
    
SELECT DISTINCT Category ,SUM (Profit) AS Total_Profit,SUM(Sales) AS Total_revenue
FROM Products p
Join Order_Item oi
ON p.Product_ID=oi.Product_ID
GROUP BY Category
ORDER BY Category desc
    
| Category | Total_Profit | Total_revenue 
|Technology | 145455.35 | 836154.04|
|Office Supplies |	122490.08 |	719046.93
|Furniture |	18883.19 |	741718.42| 
    
   ### Insights
- Technology products generate the highest overall profit.
- Office Supplies also show strong profitability.
- Furniture generates revenue but significantly lower profit, suggesting potential margin issues in this category.

---
 
# Analysis 3: Sales Trend by Month

# Analysis : Sales Trend by Year

### Business Question
How have sales and profits evolved over time?

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

| Order Year | Total Revenue | Total Profit |
|------|------|-----|
|2014	|483966.11	|49555.93|
|2015	|470532.43	|61618.43|
|2016	|609205.74	|81794.95|
|2017	|733215.11	|93859.31|
    
### Insights
- Sales increased consistently between 2015 and 2017, suggesting strong business growth over time.
- After showing a downward trend (2014 to 2015), both revenue and profit show an upward trend across the years.
    
## Analysis 4: Regional Sales Performance

### Business Question
Which regions generate the most revenue and profit?

SELECT  Region, SUM (Profit) AS Total_Profit,
SUM (Sales) as Total_Revenue,
ROUND ((SUM(Profit)/SUM (Sales))*100,1) AS Margin_Profit
FROM Order_Item oi
JOIN Orders o ON oi.Order_ID=o.Order_ID
JOIN Customers c ON o.Customer_ID=c.Customer_ID
GROUP BY Region
ORDER BY Total_Profit DESC
    
### Result
| Region | Revenue | Profit | Profit Margin |
|------|------|------|------|
|Central|	246132.09|	1953098.52|	12.600000%|
|East|	28934.73|	282745.01|	10.200000%|
|South|	9375.03|	50487.75|	18.600000%|
|West|	2386.77|	10588.11|	22.500000%|
    
 ### Insights
- The West and East regions generate the highest revenue and profit.
- The Central region shows the lowest profit margin, indicating potential inefficiencies or higher operational costs.
       
## Analysis 5: Top Product Sub-Categories
### Business Question
What are the top 5 product sub-categories by revenue and profit?

-- Top 5 Products by Sub-Categories
SELECT TOP 5
    p.Sub_Category,
    SUM(oi.Sales) AS total_revenue,
    SUM(oi.profit) AS total_profit,
    ROUND(SUM(oi.profit) / SUM(oi.sales) * 100, 2) AS profit_margin_pct
FROM Order_item oi
JOIN Products p
    ON oi.Product_ID = p.Product_ID
GROUP BY p.sub_category
ORDER BY profit_margin_pct DESC
    
| Sub Category | Total Revenue | Total Profit | Profit Margin |
|Phones | 330007.10 | 44516.04 | 13.490000|
|Chairs | 328167.72	| 26602.18	| 8.110000|
|Storage | 223843.59	| 21278.96	| 9.510000|
|Tables	| 206965.58	| -17305.58	| -8.360000|
|Binders | 203412.71	| 30221.42	| 14.860000|

    ### Insights

- Tables produce high revenue but negative profit Margin, suggesting heavy discounting or high operational costs.
- Binders show strong profitability despite lower revenue compared to some other sub-categories.

    ### Business Question
How can product categories be classified by profit level?

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

### Result
| Category | Total Profit | Profit Level |
|------|------|-----|
|Technology | 145455.35	| High Profit|
|Office Supplies	122490.08 |	High Profit|
|Furniture |	18883.19 |	Low Profit|


### Insight
- Technology and Office Supplies show a high level of profitability.

---

## Key Takeaways

- Revenue alone does not always reflect business success.
- Profitability analysis reveals that some high-selling products and regions contribute less to overall profit.

---

## Analytical Approach

The analysis followed a structured process:

1. Build a normalized relational database from the raw dataset.
2. Validate the data using record counts and integrity checks.
3. Perform SQL analysis to answer business questions related to:
   - revenue performance
   - product profitability
   - regional performance
   - customer contribution
4. Interpret the results to extract business insights and recommendations.

# Data Modeling Adjustment

## Business Issue Identified
During the early regional analysis, the regional distribution appeared unrealistic.

## Reason

Geographic attributes such as region, city, and state were initially modeled at the customers level, but in this dataset these attributes are more reliable at the order level.

## Adjustment Made

The geographic fields were added to the orders table and updated from the raw staging table.

## SQL Update Logic 
```sql

ALTER TABLE orders
ADD country VARCHAR(100),
ADD city VARCHAR(100),
ADD state VARCHAR(100),
ADD postal_code VARCHAR(20),
ADD region VARCHAR(50);

UPDATE orders o
JOIN (
    SELECT
        order_id,
        MAX(country) AS country,
        MAX(city) AS city,
        MAX(state) AS state,
        MAX(postal_code) AS postal_code,
        MAX(region) AS region
    FROM superstore_raw
    GROUP BY order_id
) r
ON o.order_id = r.order_id
SET
    o.country = r.country,
    o.city = r.city,
    o.state = r.state,
    o.postal_code = r.postal_code,
    o.region = r.region;

```

## Result
This adjustment produced more realistic regional results and improved the quality of the regional analysis.
