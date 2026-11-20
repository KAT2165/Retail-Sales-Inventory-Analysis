# 🛍️ Retail Sales and Inventory Management Analysis

## 📌 Project Overview

This project uses Python, SQL Server, and Power BI to analyze retail sales and inventory data, turning raw data into actionable insights on sales performance, profitability, store operations, and inventory risk.

## 🎯 Business Problem

Retail managers often struggle to balance maximizing sales with maintaining healthy inventory levels. This dashboard addresses critical questions:

Which product categories drive the most revenue vs. the most profit?

Which stores are top performers, and which are lagging?

Where are the inventory risks (low stock/out of stock) located?

## 🛠️ Tech Stack & Tools

Python (Pandas, NumPy): For data cleaning, handling missing values, and feature engineering (calculating Profit Margins and Stock Status).

SQL Server: For data extraction, aggregation, and validation of core business metrics.

Power BI: For data modeling (star schema), DAX measure, and interactive dashboard design.


## 📊 Dataset

- **Source:** [Maven Analytics – Mexico Toy Sales Dataset](https://mavenanalytics.io/data-playground)
- **Date range:** January 2022 – September 2023 *(based on the sales records; verify against the imported dataset before publishing).*
- **Size:** 4 CSV files containing Products, Stores, Sales and Inventory data. Exact row and column counts to be confirmed from the source files.
- **Key fields:**
  - **Products:** Product_ID, Product_Name, Product_Category, Product_Cost, Product_Price
  - **Stores:** Store_ID, Store_Name, Store_City, Store_Location, Store_Open_Date
  - **Sales:** Sale_ID, Date, Store_ID, Product_ID, Units
  - **Inventory:** Store_ID, Product_ID, Stock_On_Hand

### Data Preparation

Data profiling and preparation were performed using Python (Pandas) before importing the cleaned datasets into SQL Server.

Preparation included:

- Inspected dataset dimensions, column data types, missing values and duplicate records.
- Checked primary-key fields and potential duplicate identifiers.
- Standardised whitespace in text columns, including product names, categories, store names, cities and locations.
- Converted sales dates and store opening dates into appropriate datetime formats.
- Checked numerical fields and data types to support accurate calculations.
- Exported the prepared datasets as separate CSV files for SQL Server import.
- Performed SQL data-quality checks for missing identifiers, duplicate keys, invalid numerical values and referential integrity.

### Analytical Assumptions and Limitations

- Revenue = Units Sold × Product Price.
- Cost of Goods Sold = Units Sold × Product Cost.
- Gross Profit = Revenue − Cost of Goods Sold.
- Gross Profit Margin = Gross Profit ÷ Revenue.
- Low stock is defined as 10 units or fewer.
- High sales are defined as more than 100 units sold.
- Inventory analysis reflects the available stock-on-hand snapshot, not historical stock movements.
- The dataset does not provide purchase orders, replenishment history, returns or stock movement records; therefore, true inventory reconciliation and historical stock-out analysis are outside the scope of this project.

## 🔄 Methodology / Workflow

1. Imported raw retail sales and inventory data.
2. Cleaned and prepared the data in Python, including missing value handling and feature engineering for profit margin and stock status.
3. Used SQL Server to extract, aggregate, and validate core business metrics.
4. Built a Power BI star schema data model and created DAX measures.
5. Designed interactive dashboards for overview, sales performance, and inventory analysis.
6. Documented business insights and recommendations.

🖥️ Dashboard Preview

### Overview

<img width="1148" height="650" alt="Retail Sales and Inventory Dashboard" src="https://github.com/user-attachments/assets/03c91e12-2e68-4fb0-a894-aada1060bf32" />

Overview: High-level KPIs and monthly trends

### Sales Performance

<img width="1136" height="650" alt="Sales Perfomance Dashboard" src="https://github.com/user-attachments/assets/f8f1cdb3-f30f-4d93-a17b-29d37e6da46c" />

Sales Performance: Deep dive into category profitability and store performance.

### Inventory Analysis

<img width="1146" height="592" alt="Inventory Analysis Dashboard" src="https://github.com/user-attachments/assets/6046ccc2-3b92-4cc0-a15a-94fb6c3b3589" />

Inventory Analysis: Monitoring stock availability and replenishment needs.

### Insights & Recommendations

<img width="1100" height="618" alt="Business Insights and Recommendation" src="https://github.com/user-attachments/assets/7c87b73c-7886-4e7f-89ae-4a8a9001806a" />

Insights & Recommendations: Actionable business takeaways.

## 💡 Key Results / Insights

- **Category Performance:** Toys generated the highest overall revenue ($5.09M) and gross profit ($1.08M) with a 21.19% margin. However, Electronics achieved the highest gross profit margin at 44.57%.
- **Store performance:** Maven Toys Ciudad de Mexico 2 was the top-performing store, generating approximately $550K in revenue and $170K in gross profit (30.91% gross margin).
- **Sales Trends:** Revenue peaked in April 2022 ($681,073) and again in March 2023 ($883,516). During this same timeframe, profit increased from $180,089 to $231,909.
- **Inventory Management:** Inventory risks are highly localized. Low-stock records (10 units or fewer) were highest at Maven Toys Ciudad de Mexico 1 and Saltillo 1 (13 records each). Out-of-stock records were highest at La Paz 1 and Mexicali 2 (5 records each). Guadalajara 1 had the lowest total stock on hand (367 units).

## ✅ Recommendations

- Investigate High-Margin Categories: Investigate the pricing and product mix for Electronics to understand its high margin, while continuing to grow Toy sales without sacrificing overall profitability.
- Replicate Top Store Success: Investigate the product mix, sales patterns, and inventory practices at Maven Toys Ciudad de Mexico 2 to identify strategies that can be replicated across other stores.
- Leverage Seasonal Trends: Investigate the factors behind the March 2023 peak (e.g., product demand, promotions, seasonality) and use these historical trends to support future sales, staffing, and inventory planning.
- Prioritize Inventory Replenishment: Prioritize product-level stock reviews at stores with low or zero inventory (especially La Paz 1, Mexicali 2, Saltillo 1, and Ciudad de Mexico 1). Align replenishment decisions with sales demand to reduce potential stock shortages.

