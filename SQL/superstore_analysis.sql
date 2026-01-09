-- Project: Business Performance, Profitability & Customer Analysis
-- Dataset: Sample - Superstore
-- Database: superstore_db
-- Description:
-- SQL-based business analysis to evaluate sales, profit,
-- regional performance, product profitability, discount impact,
-- customer behavior, and time-based trends.

-- DATABASE CONTEXT AND DATA VERIFICATION

USE superstore_db;
-- This will use that particular database

SELECT COUNT(*) AS total_rows FROM superstore;

-- BUSINESS KPI'S LIKE TOTAL SALES,TOTAL PROFIT,TOTAL ORDERS
SELECT SUM(Sales) as total_sales, Sum(Profit) AS total_profit, COUNT(DISTINCT `Order ID`) as total_orders FROM superstore;

-- PROFIT MARGIN ANALYSIS
SELECT ROUND(SUM(Profit) / SUM(Sales), 4) AS overall_profit_margin FROM superstore;
    
-- REGION WISE PERFORMANCE ANALYSIS
SELECT
    Region,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales), 4) AS profit_margin
FROM superstore
GROUP BY Region
ORDER BY total_profit DESC;

-- CATEGORY WISE PERFORMANCE

SELECT Category, SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,ROUND(SUM(Profit) / SUM(Sales), 4) AS profit_margin FROM superstore GROUP BY Category ORDER BY total_profit DESC;

-- LOSS MAKING SUB CATEGORIES
SELECT Sub_Category,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit
FROM superstore
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY total_profit;

-- DISCOUNT IMPACT ANALYSIS

SELECT
    Discount,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- CUSTOMER BEHAVIOUR ANALYSIS

SELECT
    CASE
        WHEN `Customer Order Count` = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(DISTINCT `Customer ID`) AS customer_count
FROM superstore
GROUP BY customer_type;

-- TIME BASED PERFORMANCE ANALYSIS

SELECT
    `Order Year`,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Order Year`
ORDER BY `Order Year`;

-- MONTHLY SALES TREND 

SELECT
    `Order Year`,
    `Order Month`,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Order Year`, `Order Month`
ORDER BY `Order Year`, `Order Month`;
