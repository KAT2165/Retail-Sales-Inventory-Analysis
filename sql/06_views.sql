USE RetailSalesInventory;
GO

-- =============================================
-- SQL REPORTING VIEWS
-- =============================================

-- =============================================
-- 1. SALES SUMMARY VIEW
-- =============================================

CREATE VIEW vw_SalesSummary AS

SELECT
    s.Sale_ID,
    s.Date,
    s.Store_ID,
    st.Store_Name,
    st.Store_City,
    s.Product_ID,
    p.Product_Name,
    p.Product_Category,
    s.Units,

    s.Units * p.Product_Price AS Revenue,

    s.Units * p.Product_Cost AS Cost,

    s.Units * (p.Product_Price - p.Product_Cost) AS Profit

FROM Sales s

JOIN Products p
    ON s.Product_ID = p.Product_ID

JOIN Stores st
    ON s.Store_ID = st.Store_ID;
GO

-- =============================================
-- 2. INVENTORY STATUS VIEW
-- =============================================

CREATE VIEW vw_InventoryStatus AS

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,

    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    i.Stock_On_Hand,
    p.Product_Cost,

    i.Stock_On_Hand * p.Product_Cost AS Inventory_Value,

    CASE
        WHEN i.Stock_On_Hand = 0 THEN 'Out of Stock'
        WHEN i.Stock_On_Hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS Inventory_Status

FROM Inventory i

JOIN Products p
    ON i.Product_ID = p.Product_ID

JOIN Stores st
    ON i.Store_ID = st.Store_ID;
GO

-- =============================================
-- 3. SALES VS INVENTORY VIEW
-- =============================================

CREATE VIEW vw_SalesInventory AS

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,

    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    ISNULL(SUM(s.Units), 0) AS Units_Sold,

    i.Stock_On_Hand,

    CASE
        WHEN i.Stock_On_Hand = 0 THEN 'Out of Stock'
        WHEN i.Stock_On_Hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS Inventory_Status

FROM Inventory i

JOIN Products p
    ON i.Product_ID = p.Product_ID

JOIN Stores st
    ON i.Store_ID = st.Store_ID

LEFT JOIN Sales s
    ON i.Store_ID = s.Store_ID
    AND i.Product_ID = s.Product_ID

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand;

GO

-- =============================================
-- STEP 9.4: MONTHLY SALES TREND VIEW
-- =============================================

CREATE VIEW vw_MonthlySalesTrend AS

SELECT
    DATEFROMPARTS(YEAR(s.[Date]), MONTH(s.[Date]), 1) AS SalesMonth,
    SUM(s.Units) AS Units_Sold,
    SUM(s.Units * p.Product_Price) AS Revenue,
    SUM(s.Units * p.Product_Cost) AS Cost,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS Profit

FROM Sales s

JOIN Products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    DATEFROMPARTS(YEAR(s.[Date]), MONTH(s.[Date]), 1);
GO