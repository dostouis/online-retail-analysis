SELECT
    country,
    SUM(unit_price * quantity) AS revenue,
    COUNT(DISTINCT invoice_no) AS order_count

FROM
    online_retail

WHERE
    invoice_no NOT LIKE 'C%'

GROUP BY
    country

ORDER BY
    revenue ASC;