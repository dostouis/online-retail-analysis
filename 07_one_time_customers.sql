SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS transac_count,
    SUM(unit_price * quantity) AS revenue

FROM
    online_retail

WHERE
    customer_id IS NOT NULL AND
    invoice_no NOT LIKE 'C%'

GROUP BY
    customer_id

HAVING 
    COUNT(DISTINCT invoice_no) = 1

ORDER BY
    revenue DESC

LIMIT 50;