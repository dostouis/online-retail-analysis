-- 1. Check total rows
-- Found: 541,909 total rows
SELECT COUNT(*) AS total_rows
FROM online_retail;

-- 2. Check missing CustomerIDs
-- Found: 135,080 rows missing CustomerID (24.9% of data)
-- Decision: Exclude from customer analysis, keep for revenue analysis
SELECT COUNT(*) AS missing_customer_id
FROM online_retail
WHERE customer_id IS NULL;

-- 3. Check cancellations
-- Found: 9,288 cancelled transactions (1.7% of data)
-- Decision: Exclude from all sales and revenue analysis
SELECT COUNT(*) AS total_cancellations
FROM online_retail
WHERE invoice_no LIKE 'C%';

-- 4. Revenue impact of cancellations
-- Found: Revenue with cancellations = £9,747,747.93
--        Revenue without cancellations = £10,644,560.42
--        Difference = £896,812.49 (cancellations reduced revenue by £896,812.49)
SELECT SUM(unit_price * quantity) AS revenue_with_cancellations
FROM online_retail;

SELECT SUM(unit_price * quantity) AS revenue_without_cancellations
FROM online_retail
WHERE invoice_no NOT LIKE 'C%';

-- 5. Check zero or negative prices
-- Found: 2,517 rows with zero or negative unit price
-- Decision: Exclude from revenue calculations
SELECT COUNT(*) AS zero_negative_prices
FROM online_retail
WHERE unit_price <= 0;

-- 6. Check negative quantities
-- Found: 10,624 rows with negative quantities (returns/cancellations)
-- Decision: Already handled by excluding 'C%' invoices
SELECT COUNT(*) AS negative_quantities
FROM online_retail
WHERE quantity < 0;