SELECT
    EXTRACT(DOW FROM invoice_date) AS day_of_week,
    COUNT(DISTINCT invoice_no) AS transac_num,
    SUM(unit_price * quantity) AS revenue

FROM
    online_retail

WHERE
    invoice_no NOT LIKE 'C%'

GROUP BY
    day_of_week

ORDER BY
    day_of_week,
    revenue DESC,
    transac_num DESC;