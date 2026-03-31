Superstore Sales Analysis using SQL

Project Overview

This project analyzes retail sales performance using SQL and the Superstore dataset.  
The objective is to transform raw transactional data into a structured relational database and perform business analysis to generate actionable insights.

All financial values are expressed in USD ($).

Business Problem
Retail companies generate large volumes of transactional data but often struggle to extract meaningful insights.  
This project addresses key questions:

- What are the overall revenue, profit, and profit margin?
- Which product categories generate the most revenue and profit?
- How have sales evolved over time?
- Which customers contribute the most to total sales?
- Which regions are the most profitable?
- Which product sub-categories drive the most revenue?

Dataset
The Superstore dataset contains transactional sales data:

- Order information
- Customer information
- Product information
- Sales metrics (sales, quantity, discount, profit)

Database Design
The dataset was normalized into four relational tables:

Customers
| Column         | Description                 |
|----------------|----------------------------|
| customer_id    | Unique customer identifier |
| customer_name  | Customer name              |
| segment        | Customer segment           |
| country        | Country                    |
| city           | City                       |
| state          | State                      |
| postal_code    | Postal code                |
| region         | Geographic region          |

### Orders
| Column       | Description             |
|-------------|------------------------|
| order_id     | Unique order identifier|
| order_date   | Date the order was placed|
| ship_date    | Shipping date          |
| ship_mode    | Shipping method        |
| customer_id  | Customer reference     |

Products
| Column        | Description              |
|---------------|--------------------------|
| product_id    | Unique product identifier|
| category      | Product category         |
| sub_category  | Product sub-category     |
| product_name  | Product name             |

Order_Items
| Column   | Description            |
|----------|-----------------------|
| row_id   | Unique row identifier |
| order_id | Order reference       |
| product_id | Product reference    |
| sales    | Sales amount          |
| quantity | Quantity sold         |
| discount | Discount applied      |
| profit   | Profit generated      |

## SQL Analysis
Analytical queries were performed to answer business questions.  
See `Documentation/analysis_description.md` for detailed queries and explanations.

### Key Insights
- Technology generates the highest revenue and profit.
- Sales increased over the years.
- West region contributes most to revenue and profit.
- A few customers contribute disproportionately to total sales.
- Some product sub-categories drive the majority of revenue.
- Certain high-revenue products (e.g., Tables) are not profitable.

### Recommendations
- Focus marketing and inventory on high-performing product categories.
- Develop retention strategies for high-value customers.
- Monitor regional performance to identify inefficiencies.
- Manage discounts to maintain healthy profit margins.

Tools Used
- MySQL / MySQL Workbench
- SQL (SELECT, JOIN, GROUP BY, CASE, aggregation functions)
- GitHub for version control

Files in This Repository
- `Data/Superstore_Raw_Data.csv` — original dataset
- `SQL-Scripts/superstore_analysis.sql` — SQL queries for data modeling and analysis
- `Documentation/superstore_database_schema.PNG` — EER diagram
- `Documentation/analysis_description.md` — analytical query descriptions and results

Future Improvements
- Build a Power BI dashboard connected to the SQL database
- Use Python (Pandas / Matplotlib) for advanced analysis

 Author
Edwin Owino — Economics graduate, University of Nairobi | Aspiring Data Analyst
