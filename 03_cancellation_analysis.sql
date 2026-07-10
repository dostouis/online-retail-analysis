SELECT
    stock_code,
    description,
    COUNT(invoice_no) AS transaction_cancelled

FROM
    online_retail

WHERE
    invoice_no LIKE 'C%'

GROUP BY
    stock_code,
    description

ORDER BY
    transaction_cancelled DESC

LIMIT 10;