# 🛍️ Retail Sales and Inventory Management Analysis

## 📌 Project Overview

This project uses Python, SQL Server, and Power BI to analyze retail sales and inventory data, turning raw data into actionable insights on sales performance, profitability, store operations, and inventory risk.

## 🎯 Business Problem

Retail managers often struggle to balance maximizing sales with maintaining healthy inventory levels. This dashboard addresses critical questions:

Which product categories drive the most revenue vs. the most profit?

Which stores are top performers, and which are lagging?

Where are the inventory risks (low stock/out of stock) located?

## 🛠️ Tech Stack & Tools

*   **Python (Pandas, NumPy):** Profiled missing values and performed data cleaning. 
*   **SQL Server:** Data extraction, aggregation, and data validation (using dedicated data-quality checks). Additionally, implemented core feature engineering—calculating profit margins and classifying stock status through SQL views. Stock status thresholds are defined as: 0 = Out of Stock, 1–10 = Low Stock, and above 10 = In Stock.
*   **Power BI: ** Data modeling, DAX measures (for calculating profit metrics where applicable), and interactive dashboard design.


## 📊 Dataset

- **Source: ** [Maven Analytics – Mexico Toy Sales Dataset](https://mavenanalytics.io/data-playground)
- **Date range:** January 2022 – September 2023 *(based on the sales records; verify against the imported dataset before publishing).*
- **Size:** 4 CSV files containing Products, Stores, Sales and Inventory data. Exact row and column counts to be confirmed from the source files.
- The project utilizes four main tables. Data preparation included profiling missing values and cleaning data in Python before ingesting into SQL Server.

- **Sales:** 829,262 records, 11 columns (Transaction-level sales data)
- **Inventory:** 1,590 records, 4 columns (Current stock levels by store and product)
- **Products:** 35 records, 4 columns (Product hierarchy and cost data)
- **Stores:** 50 records, 5 columns (Store locations and types)

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

### Executive Overview

<img width="1148" height="650" alt="Retail Sales and Inventory Dashboard" src="https://github.com/user-attachments/assets/59392aea-7fcf-4757-a336-dafc9176a57c" />

### Sales Performance

<img width="1136" height="650" alt="Sales Performance Dashboard" src="https://github.com/user-attachments/assets/1ef79b79-576a-47ac-ac57-83a334c7c684" />

### Inventory Analysis

<img width="1146" height="592" alt="Inventory Analysis Dashboard" src="https://github.com/user-attachments/assets/216e2c56-2830-4b46-815d-6c8ee38703e2" />

### Business Insights

<img width="1100" height="618" alt="Business Insights and Recommendations" src="https://github.com/user-attachments/assets/b5b442b5-d65e-4111-b8a6-356a8a6fff5d" />

## 💡 Key Results / Insights

- **Category Performance:** Toys generated the highest overall revenue ($5.09M) and gross profit ($1.08M) with a 21.19% margin. However, Electronics achieved the highest gross profit margin at 44.57%.
- **Store performance:** Maven Toys Ciudad de Mexico 2 was the top-performing store, generating approximately $550K in revenue and $170K in gross profit (30.91% gross margin).
- **Sales Trends:** Revenue peaked in April 2022 ($681,073) and again in March 2023 ($883,516). During this same timeframe, profit increased from $190,099 to $231,909.
- **Inventory Management:** Inventory risks are highly localized. Low-stock records (10 units or fewer) were highest at Maven Toys Ciudad de Mexico 1 and Saltillo 1 (19 records each). Out-of-stock records were highest at La Paz 1 and Mexicali 2 (5 records each). Guadalajara 1 had the lowest total stock on hand (367 units).

## ✅ Recommendations

- Investigate High-Margin Categories: Investigate the pricing and product mix for Electronics to understand its high margin, while continuing to grow Toy sales without sacrificing overall profitability.
- Replicate Top Store Success: Investigate the product mix, sales patterns, and inventory practices at Maven Toys Ciudad de Mexico 2 to identify strategies that can be replicated across other stores.
- Leverage Seasonal Trends: Investigate the factors behind the March 2023 peak (e.g., product demand, promotions, seasonality) and use these historical trends to support future sales, staffing, and inventory planning.
- Prioritize Inventory Replenishment: Prioritize product-level stock reviews at stores with low or zero inventory (especially La Paz 1, Mexicali 2, Saltillo 1, and Ciudad de Mexico 1). Align replenishment decisions with sales demand to reduce potential stock shortages.

## ▶️ How to Reproduce
### Prerequisites
-Python 3.9+
-SQL Server Management Studio (SSMS)
-Power BI Desktop
-Required Python packages (pip install -r requirements.txt)

### Steps
-Clone the repository:

bash
git clone [repository-url]
cd [repository-name]

-Run Python Scripts: Navigate to the notebooks/ folder and run the Jupyter notebooks/scripts to profile missing values and clean the raw datasets.

-Execute SQL Scripts: Open SQL Server Management Studio, import the cleaned data, and run the scripts in the sql/ folder. This will perform data-quality checks and generate the four analytical views (vw_SalesSummary, vw_InventoryStatus, etc.).

-Open the Dashboard: Open the .pbix file located in the powerbi/ folder. Update the data source parameters to connect to your local SQL Server instance, then refresh the data.

## 🚀 Future Improvements
-Add demand forecasting to predict future inventory needs.

-Integrate automated low-stock and replenishment alerts.

-Include real-time or near-real-time inventory data feeds.

-Expand analysis with customer segmentation or market basket analysis.

## 📄 License and Data Attribution
### Project Code
The original code, SQL scripts, analysis workflows and documentation in this repository are licensed under the MIT License.

### Dataset Attribution
This project uses the Mexico Toy Sales dataset provided by Maven Analytics.

The dataset remains the property of its respective owner or rights holder and is subject to its original licensing and usage terms.

This repository does not claim ownership of the original dataset. Please refer to the original dataset source for access, attribution and redistribution requirements.

### Disclaimer
This project was developed for educational and portfolio purposes. The analysis and recommendations are based on the available dataset and should not be interpreted as actual business performance reports from any company.
