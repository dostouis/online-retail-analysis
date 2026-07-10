SELECT
    stock_code,
    description,
    COUNT(DISTINCT invoice_no) AS order_count,
    SUM(unit_price * quantity) AS revenue

FROM
    online_retail

WHERE
    invoice_no NOT LIKE 'C%' AND
    description IS NOT NULL

GROUP BY
    stock_code,
    description

ORDER BY
    revenue DESC,
    order_count DESC

LIMIT 10;