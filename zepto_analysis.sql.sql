drop table if exists zepto;

CREATE TABLE zepto (
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
-- =========================
-- DATA EXPLORATION
-- =========================

-- 1. Count total number of products
SELECT COUNT(*)
FROM zepto;

-- 2. Show unique categories
SELECT DISTINCT category
FROM zepto;

-- 3. Top 10 highest MRP products
SELECT
    name,
    mrp
FROM zepto
ORDER BY mrp DESC
LIMIT 10;

-- 4. Products containing Milk
SELECT
    name,
    category
FROM zepto
WHERE name ILIKE '%Milk%';

-- =========================
-- BUSINESS INSIGHTS
-- =========================

-- 5. Count products category wise
SELECT
    category,
    COUNT(*) AS total_products
FROM zepto
GROUP BY category
ORDER BY total_products DESC;

-- 6. Highest average discount category
SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC;

-- 7. Top categories by sales value
SELECT
    category,
    SUM(discountedSellingPrice) AS total_sales
FROM zepto
GROUP BY category
ORDER BY total_sales DESC;

-- 8. Out-of-stock percentage
SELECT
    category,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE outOfStock = TRUE
        ) / COUNT(*),
        2
    ) AS out_of_stock_pct
FROM zepto
GROUP BY category
ORDER BY out_of_stock_pct DESC;

-- =========================
-- ADVANCED POSTGRESQL
-- =========================

-- 9. CTE average discount
WITH category_discount AS (
    SELECT
        category,
        AVG(discountPercent) AS avg_discount
    FROM zepto
    GROUP BY category
)

SELECT *
FROM category_discount;

-- 10. Rank products by price
SELECT
    name,
    category,
    discountedSellingPrice,
    RANK() OVER (
        PARTITION BY category
        ORDER BY discountedSellingPrice DESC
    ) AS price_rank
FROM zepto;

-- 11. Row number inside category
SELECT
    name,
    category,
    ROW_NUMBER() OVER (
        PARTITION BY category
        ORDER BY discountedSellingPrice DESC
    ) AS row_num
FROM zepto;

-- =========================
-- DATA QUALITY
-- =========================

-- 12. Detect pricing issues
SELECT
    *
FROM zepto
WHERE mrp < discountedSellingPrice;

-- =========================
-- FINAL ANALYTICS
-- =========================

-- 13. Final category analytics summary
SELECT
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(discountedSellingPrice), 2) AS avg_price,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY total_products DESC;






