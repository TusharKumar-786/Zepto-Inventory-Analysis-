# 🛒 Zepto Product Analysis — SQL Project

A **PostgreSQL-based data analysis project** on Zepto's product catalog. This project explores pricing, discounts, stock availability, and category-level insights using real-world style retail data.

---

## 📁 Project Structure

```
Zepto-Inventory-Analysis-
│
├── zepto_analysis.sql.sql     # All SQL queries (exploration + insights + analytics)
├── zepto_v2.csv
└── README.md

```

---

## 🗄️ Database Setup

**Database:** `zepto_db`  
**Table:** `zepto`

```sql
CREATE TABLE zepto (
    category              VARCHAR(120),
    name                  VARCHAR(150) NOT NULL,
    mrp                   NUMERIC(8,2),
    discountPercent       NUMERIC(5,2),
    availableQuantity     INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms           INTEGER,
    outOfStock            BOOLEAN,
    quantity              INTEGER
);
```

---

## 🔍 Key Analysis Questions

### 1. 🏷️ Which categories offer the highest average discount?

```sql
SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC;
```

> **Insight:** Identifies which product categories have the most aggressive discounting strategy — useful for understanding Zepto's pricing priorities.

---

### 2. 💰 Which categories generate the highest total sales value?

```sql
SELECT
    category,
    SUM(discountedSellingPrice) AS total_sales
FROM zepto
GROUP BY category
ORDER BY total_sales DESC;
```

> **Insight:** Reveals the top revenue-contributing categories based on discounted selling price — key for business prioritization.

---

### 3. 📦 What is the out-of-stock percentage per category?

```sql
SELECT
    category,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE outOfStock = TRUE) / COUNT(*),
        2
    ) AS out_of_stock_pct
FROM zepto
GROUP BY category
ORDER BY out_of_stock_pct DESC;
```

> **Insight:** Pinpoints supply chain issues. Categories with high OOS % indicate fulfillment challenges or high demand products.

---

### 4. 🏆 What are the top 10 most expensive products?

```sql
SELECT
    name,
    mrp
FROM zepto
ORDER BY mrp DESC
LIMIT 10;
```

> **Insight:** Highlights Zepto's premium product range — helpful for understanding the high-end catalog positioning.

---

### 5. ⚠️ Are there any pricing anomalies (selling price > MRP)?

```sql
SELECT *
FROM zepto
WHERE mrp < discountedSellingPrice;
```

> **Insight:** Data quality check — any product where the selling price exceeds MRP is a billing/data error that needs correction.

---

## 📊 Final Category Summary

```sql
SELECT
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(discountedSellingPrice), 2) AS avg_price,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY total_products DESC;
```

---

## 🛠️ Tech Stack

| Tool | Usage |
|------|-------|
| PostgreSQL | Database & Query Engine |
| pgAdmin / psql | Query Execution |
| SQL (Window Functions, CTEs) | Advanced Analysis |

---

## 🚀 How to Run

1. Open **pgAdmin** or **psql**
2. Create a database: `CREATE DATABASE zepto_db;`
3. Import your dataset into the `zepto` table
4. Run `zepto_analysis_sql.sql` query by query

---

## 👤 Author

**Tushar**  
B.Tech CSE | Rayat Bahra University  
📌 Data Science & SQL Enthusiast

---


