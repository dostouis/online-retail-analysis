# UK Online Retail Sales Analysis

## Project Overview
This project analyzes 541,909 transactions from a UK-based online retailer (2010-2011) to identify top performing products, valuable customers, cancellation patterns, seasonal trends, and market performance by country.

**Tool:** PostgreSQL  
**Dataset:** [Online Retail Dataset (Kaggle)](https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset)  
**Time Period:** December 2010 — December 2011  

---

## Business Problem
As a data analyst, I was tasked with answering 8 key business questions to help the company make better decisions around inventory, marketing, staffing, and customer retention.

---

## Dataset Overview
| Column | Description |
|---|---|
| InvoiceNo | Unique invoice number (prefix 'C' = cancellation) |
| StockCode | Product code |
| Description | Product name |
| Quantity | Quantity per transaction |
| InvoiceDate | Date and time of transaction |
| UnitPrice | Price per unit (£) |
| CustomerID | Unique customer identifier |
| Country | Country of customer |

---

## Data Cleaning
Before analysis, the following data quality issues were identified and handled:

| Issue | Count | Decision |
|---|---|---|
| Missing CustomerIDs | 135,080 (24.9%) | Excluded from customer analysis, kept for revenue |
| Cancellation invoices (prefix 'C') | 9,288 (1.7%) | Excluded from all sales analysis |
| Zero/negative unit prices | 2,517 | Excluded from revenue calculations |
| Negative quantities | 10,624 | Already handled by excluding 'C' invoices |

**Key finding:** Cancellations reduced gross revenue by £896,812.49 — from £10,644,560.42 (clean) to £9,747,747.93 (including cancellations). Always exclude cancellations for accurate revenue reporting.

---

## Analysis & Findings

### 1. Top Performing Products
**Business question:** Which products should we stock more of going into next quarter?

**Finding:** The top performing products by revenue were DOTCOM POSTAGE, REGENCY CAKESTAND 3 TIER, and PAPER CRAFT LITTLE BIRDIE. The top products were dominated by decorative home items and gifting products, suggesting these are the store's core categories and should be prioritized for restocking.

---

### 2. Most Valuable Customers
**Business question:** Who should we target for a loyalty program?

**Finding:** The highest revenue customer (ID: 14646) generated £280,026.02 in total purchases. The top customers show significantly higher spending than average, making them strong candidates for a VIP loyalty program to ensure retention.

---

### 3. Cancellation Analysis
**Business question:** Do we have a product quality issue?

**Finding:** The most cancelled item was Stock Code M (Manual) with 244 cancellations, followed by REGENCY CAKESTAND 3 TIER with 181 cancellations. Notably, the REGENCY CAKESTAND 3 TIER appears in both top revenue AND top cancellations — this warrants a quality investigation as it may be driving returns despite high sales volume.

---

### 4. Monthly Revenue Trend (Month-over-Month)
**Business question:** Which months perform best for campaign planning?

**Finding:** November 2011 was the peak revenue month at £1,509,496.33, with a 30.69% increase from October. December saw a sharp -57.68% drop, likely due to the dataset ending mid-December rather than a true sales decline. The biggest single-month growth was September (+43.63%), suggesting early Q4 campaigns would be most effective.

---

### 5. Customer Segmentation
**Business question:** How do we tier customers for targeted marketing offers?

| Tier | Criteria | Count |
|---|---|---|
| VIP | Revenue > £5,000 | 275 |
| Regular | Revenue £1,000 - £5,000 | 1,393 |
| Low Value | Revenue < £1,000 | 2,671 |

**Finding:** Out of 4,339 total customers, only 275 (6.3%) are VIP — yet these customers likely drive a disproportionate share of total revenue. Retaining VIP customers should be the top marketing priority.

---

### 6. Day of Week Analysis
**Business question:** Which days need more staffing?

**Finding:** Thursday was the busiest day with 4,689 orders and £2,203,161 in revenue. Weekdays consistently outperformed weekends, with Sunday being the least active day. This strongly suggests a B2B customer base operating on business hours — staffing should be concentrated Monday through Friday, peaking on Thursday.

---

### 7. One-Time Customers
**Business question:** Who should we target for a win-back campaign?

**Finding:** 1,494 customers (34.4% of total customers) made only a single purchase. This represents a significant win-back opportunity — a targeted re-engagement campaign for these customers could meaningfully increase repeat purchase rates and overall revenue.

---

### 8. Country Performance
**Business question:** Which markets are over/underperforming?

**Finding:** The United Kingdom dominates revenue as expected (UK-based retailer). Saudi Arabia was the most underperforming market with only £145.92 in revenue from a single order. Several countries show low revenue despite multiple orders, suggesting pricing or product-market fit issues in those regions.

---

## Key Insights
- **Cancellations matter:** Ignoring cancellation invoices inflates gross revenue by £896,812.49 — always clean your data before reporting
- **November is peak season:** Revenue peaked in November at £1.5M — holiday campaigns should launch in September/October to capture the Q4 surge
- **VIP customers are rare but critical:** Only 6.3% of customers are VIP, but they likely drive the majority of revenue — retention is more valuable than acquisition
- **Thursday is king:** 4,689 orders on Thursdays vs 2,207 on Sundays — this is a weekday B2B business
- **1 in 3 customers never comes back:** 34.4% of customers only bought once — a win-back campaign is a high-priority opportunity

---

## What I Learned
- Ignoring cancellations (invoices prefixed with 'C') inflates gross revenue metrics — always investigate data quality before analysis
- 24.9% of rows had missing CustomerIDs, requiring careful handling to avoid skewing customer-level analysis
- Translating vague business questions ("who are our best customers?") into structured SQL queries requires defining metrics clearly first (revenue? order count? frequency?)
- `LAG()` window functions are powerful for trend analysis — calculating month-over-month percentage change reveals business seasonality that simple totals hide
- CTEs make complex queries readable and maintainable — especially when reusing aggregated results across multiple calculations

---

## SQL Concepts Used
- `JOIN` — linking fact and dimension tables
- `GROUP BY` + aggregate functions (`SUM`, `COUNT`, `AVG`)
- `HAVING` — filtering aggregated results
- `CASE WHEN` — customer segmentation/categorization
- Subqueries — filtering against calculated averages
- CTEs (Common Table Expressions) — organizing complex multi-step queries
- Window Functions — `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`
- `UNION ALL` — combining result sets
- Date functions — `EXTRACT()` for month/quarter/year/DOW analysis
