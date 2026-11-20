USE RetailSalesInventory;

-- =============================================
-- SALES ANALYSIS
-- =============================================

-- 1. Overall sales performance

SELECT
    SUM(s.Units) AS Total_Units_Sold,
    SUM(s.Units * p.Product_Price) AS Total_Revenue,
    SUM(s.Units * p.Product_Cost) AS Total_Cost,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Total_Profit
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID;

-- 2. Sales performance by product category

SELECT
    p.Product_Category,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Revenue DESC;

-- =============================================
-- 3. TOP 10 PRODUCTS BY REVENUE
-- =============================================

SELECT TOP 10
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category
ORDER BY Revenue DESC;

-- =============================================
-- 4. SALES PERFORMANCE BY STORE
-- =============================================

SELECT
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
JOIN Stores st
    ON s.Store_ID = st.Store_ID
GROUP BY
    st.Store_ID,
    st.Store_Name,
    st.Store_City
ORDER BY Revenue DESC;

-- =============================================
-- 5. MONTHLY SALES PERFORMANCE
-- =============================================

SELECT
    YEAR(s.Date) AS Sales_Year,
    MONTH(s.Date) AS Sales_Month,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
GROUP BY
    YEAR(s.Date),
    MONTH(s.Date)
ORDER BY
    Sales_Year,
    Sales_Month;

-- =============================================
-- 6. SALES PERFORMANCE BY CITY
-- =============================================

SELECT
    st.Store_City,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
JOIN Stores st
    ON s.Store_ID = st.Store_ID
GROUP BY
    st.Store_City
ORDER BY
    Revenue DESC;

-- =============================================
-- 7. PROFIT MARGIN BY PRODUCT CATEGORY
-- =============================================

SELECT
    p.Product_Category,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * p.Product_Cost) AS Cost,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit,
    ROUND(
        SUM(s.Units * (p.Product_Price - p.Product_Cost))
        / NULLIF(SUM(s.Units * p.Product_Price), 0) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_Category
ORDER BY
    Profit_Margin_Percent DESC;

-- =============================================
-- 8. SALES PERFORMANCE BY PRODUCT
-- =============================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * p.Product_Cost) AS Cost,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit,
    ROUND(
        SUM(s.Units * (p.Product_Price - p.Product_Cost))
        / NULLIF(SUM(s.Units * p.Product_Price), 0) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Sales s
JOIN Products p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category
ORDER BY
    Revenue DESC;

