-- Retail Sales and Inventory Project
-- Create database tables

USE RetailSalesInventory;
-- Products table
CREATE TABLE Products (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Product_Name VARCHAR(100),
    Product_Category VARCHAR(100),
    Product_Cost DECIMAL(10,2),
    Product_Price DECIMAL(10,2)
);
-- Stores table
CREATE TABLE Stores (
    Store_ID VARCHAR(20) PRIMARY KEY,
    Store_Name VARCHAR(100),
    Store_City VARCHAR(100),
    Store_Location VARCHAR(100),
    Store_Open_Date DATE
);
-- Sales table
CREATE TABLE Sales (
    Sale_ID VARCHAR(20) PRIMARY KEY,
    Date DATE,
    Store_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Units INT
);
-- Inventory table
CREATE TABLE Inventory (
    Store_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Stock_On_Hand INT
);

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