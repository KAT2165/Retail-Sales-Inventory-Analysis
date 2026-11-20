USE RetailSalesInventory;
GO

-- 1. Copy data from clean tables to original tables
INSERT INTO Products SELECT * FROM products_clean;
INSERT INTO Stores SELECT * FROM stores_clean;
INSERT INTO Sales SELECT * FROM sales_clean;
INSERT INTO Inventory SELECT * FROM inventory_clean;

-- 2. Drop the temporary '_clean' tables
DROP TABLE products_clean;
DROP TABLE stores_clean;
DROP TABLE sales_clean;
DROP TABLE inventory_clean;
GO

-- Check number of records in each table

SELECT COUNT(*) AS Product_Count
FROM Products;

SELECT COUNT(*) AS Store_Count
FROM Stores;

SELECT COUNT(*) AS Sales_Count
FROM Sales;

SELECT COUNT(*) AS Inventory_Count
FROM Inventory;

-- Check sample records

SELECT TOP 5 *
FROM Products;

SELECT TOP 5 *
FROM Stores;

SELECT TOP 5 *
FROM Sales;

SELECT TOP 5 *
FROM Inventory;

-- =============================================
-- DATA QUALITY CHECKS
-- =============================================

-- 1. Check for missing Product_IDs
SELECT COUNT(*) AS Missing_Product_IDs
FROM Products
WHERE Product_ID IS NULL;

-- 2. Check for missing Store_IDs
SELECT COUNT(*) AS Missing_Store_IDs
FROM Stores
WHERE Store_ID IS NULL;

-- 3. Check for missing Sales IDs
SELECT COUNT(*) AS Missing_Sale_IDs
FROM Sales
WHERE Sale_ID IS NULL;

-- 4. Check for missing Inventory Store IDs
SELECT COUNT(*) AS Missing_Inventory_Store_IDs
FROM Inventory
WHERE Store_ID IS NULL;

-- =============================================
-- 2. CHECK FOR DUPLICATES
-- =============================================

-- Check duplicate Product IDs
SELECT
    Product_ID,
    COUNT(*) AS Duplicate_Count
FROM Products
GROUP BY Product_ID
HAVING COUNT(*) > 1;

-- Check duplicate Store IDs
SELECT
    Store_ID,
    COUNT(*) AS Duplicate_Count
FROM Stores
GROUP BY Store_ID
HAVING COUNT(*) > 1;

-- Check duplicate Sale IDs
SELECT
    Sale_ID,
    COUNT(*) AS Duplicate_Count
FROM Sales
GROUP BY Sale_ID
HAVING COUNT(*) > 1;

-- Check duplicate Inventory combinations
SELECT
    Store_ID,
    Product_ID,
    COUNT(*) AS Duplicate_Count
FROM Inventory
GROUP BY Store_ID, Product_ID
HAVING COUNT(*) > 1;

-- =============================================
-- 3. CHECK FOR NEGATIVE VALUES
-- =============================================

-- Negative product costs
SELECT COUNT(*) AS Negative_Product_Costs
FROM Products
WHERE Product_Cost < 0;

-- Negative product prices
SELECT COUNT(*) AS Negative_Product_Prices
FROM Products
WHERE Product_Price < 0;

-- Negative sales units
SELECT COUNT(*) AS Negative_Sales_Units
FROM Sales
WHERE Units < 0;

-- Negative inventory
SELECT COUNT(*) AS Negative_Stock
FROM Inventory
WHERE Stock_On_Hand < 0;

-- =============================================
-- 4. CHECK FOR ZERO VALUES
-- =============================================

SELECT COUNT(*) AS Zero_Sales_Units
FROM Sales
WHERE Units = 0;

SELECT COUNT(*) AS Zero_Stock
FROM Inventory
WHERE Stock_On_Hand = 0;

SELECT COUNT(*) AS Zero_Product_Cost
FROM Products
WHERE Product_Cost = 0;

SELECT COUNT(*) AS Zero_Product_Price
FROM Products
WHERE Product_Price = 0;

-- =============================================
-- 5. REFERENTIAL INTEGRITY
-- =============================================

-- Check sales with Product IDs that do not exist
SELECT
    s.Product_ID
FROM Sales s
LEFT JOIN Products p
    ON s.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;

-- Check sales with Store IDs that do not exist
SELECT
    s.Store_ID
FROM Sales s
LEFT JOIN Stores st
    ON s.Store_ID = st.Store_ID
WHERE st.Store_ID IS NULL;

-- Check inventory with Product IDs that do not exist
SELECT
    i.Product_ID
FROM Inventory i
LEFT JOIN Products p
    ON i.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;

-- Check inventory with Store IDs that do not exist
SELECT
    i.Store_ID
FROM Inventory i
LEFT JOIN Stores st
    ON i.Store_ID = st.Store_ID
WHERE st.Store_ID IS NULL;