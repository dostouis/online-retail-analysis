SELECT
    customer_id,
    SUM(unit_price * quantity) AS revenue,
    COUNT(DISTINCT invoice_no) AS order_count

FROM
    online_retail

WHERE
    invoice_no NOT LIKE 'C%' AND
    customer_id IS NOT NULL

GROUP BY
    customer_id

ORDER BY
    revenue DESC,
    order_count DESC

LIMIT 10;