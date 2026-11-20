USE RetailSalesInventory;

-- =============================================
-- INVENTORY ANALYSIS
-- =============================================

-- =============================================
-- 1. OVERALL INVENTORY
-- =============================================

SELECT
    SUM(i.Stock_On_Hand) AS Total_Stock,
    SUM(i.Stock_On_Hand * p.Product_Cost) AS Inventory_Value
FROM Inventory i
JOIN Products p
    ON i.Product_ID = p.Product_ID;

-- =============================================
-- 2. INVENTORY BY STORE
-- =============================================

SELECT
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    SUM(i.Stock_On_Hand) AS Total_Stock,
    SUM(i.Stock_On_Hand * p.Product_Cost) AS Inventory_Value
FROM Inventory i
JOIN Products p
    ON i.Product_ID = p.Product_ID
JOIN Stores st
    ON i.Store_ID = st.Store_ID
GROUP BY
    st.Store_ID,
    st.Store_Name,
    st.Store_City
ORDER BY
    Inventory_Value DESC;

-- =============================================
-- 3. INVENTORY BY PRODUCT
-- =============================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(i.Stock_On_Hand) AS Total_Stock,
    SUM(i.Stock_On_Hand * p.Product_Cost) AS Inventory_Value
FROM Inventory i
JOIN Products p
    ON i.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category
ORDER BY
    Inventory_Value DESC;

-- =============================================
-- 4. LOW-STOCK PRODUCTS
-- =============================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Store_ID,
    i.Stock_On_Hand,
    p.Product_Cost,
    i.Stock_On_Hand * p.Product_Cost AS Inventory_Value
FROM Inventory i
JOIN Products p
    ON i.Product_ID = p.Product_ID
WHERE i.Stock_On_Hand <= 10
ORDER BY
    i.Stock_On_Hand ASC;

-- =============================================
-- 5. OUT-OF-STOCK PRODUCTS
-- =============================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Stock_On_Hand
FROM Inventory i
JOIN Products p
    ON i.Product_ID = p.Product_ID
JOIN Stores st
    ON i.Store_ID = st.Store_ID
WHERE i.Stock_On_Hand = 0
ORDER BY
    p.Product_Category,
    p.Product_Name;

-- =============================================
-- 6. INVENTORY STATUS CLASSIFICATION
-- =============================================

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
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

ORDER BY
    i.Stock_On_Hand ASC;

-- =============================================
-- 7. INVENTORY STATUS SUMMARY
-- =============================================

SELECT
    CASE
        WHEN Stock_On_Hand = 0 THEN 'Out of Stock'
        WHEN Stock_On_Hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS Inventory_Status,

    COUNT(*) AS Number_of_Records,
    SUM(Stock_On_Hand) AS Total_Units

FROM Inventory

GROUP BY
    CASE
        WHEN Stock_On_Hand = 0 THEN 'Out of Stock'
        WHEN Stock_On_Hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END

ORDER BY
    Total_Units ASC;

-- =============================================
-- 8. INVENTORY STATUS BY STORE
-- =============================================

SELECT
    st.Store_ID,
    st.Store_Name,
    st.Store_City,

    CASE
        WHEN i.Stock_On_Hand = 0 THEN 'Out of Stock'
        WHEN i.Stock_On_Hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS Inventory_Status,

    COUNT(*) AS Number_of_Products,
    SUM(i.Stock_On_Hand) AS Total_Units

FROM Inventory i

JOIN Stores st
    ON i.Store_ID = st.Store_ID

GROUP BY
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    CASE
        WHEN i.Stock_On_Hand = 0 THEN 'Out of Stock'
        WHEN i.Stock_On_Hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END

ORDER BY
    st.Store_ID,
    Inventory_Status;

-- =============================================
-- 9. STOCK RECONCILIATION
-- =============================================

SELECT
    i.Store_ID,
    st.Store_Name,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS Units_Sold,
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
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

ORDER BY
    Units_Sold DESC;

-- =============================================
-- 10. HIGH-SALES, LOW-STOCK PRODUCTS
-- =============================================

SELECT
    i.Store_ID,
    st.Store_Name,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS Units_Sold,
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
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

HAVING
    SUM(s.Units) > 100
    AND i.Stock_On_Hand <= 10

ORDER BY
    Units_Sold DESC;

-- =============================================
-- 11. INVENTORY VALUE BY PRODUCT CATEGORY
-- =============================================

SELECT
    p.Product_Category,
    SUM(i.Stock_On_Hand) AS Total_Stock,
    SUM(i.Stock_On_Hand * p.Product_Cost) AS Inventory_Value
FROM Inventory i
JOIN Products p
    ON i.Product_ID = p.Product_ID
GROUP BY
    p.Product_Category
ORDER BY
    Inventory_Value DESC;