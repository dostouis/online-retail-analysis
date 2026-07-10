WITH customer_tier AS (
    SELECT
        customer_id,
        SUM(unit_price * quantity) AS revenue,
        COUNT(DISTINCT invoice_no) AS transaction_count

    FROM
        online_retail
    
    WHERE
        invoice_no NOT LIKE 'C%' AND
        customer_id IS NOT NULL

    GROUP BY
        customer_id
)

SELECT
    customer_id,
    revenue,
    transaction_count,
    CASE
        WHEN revenue > 5000 THEN 'VIP'
        WHEN revenue BETWEEN 1000 AND 5000 THEN 'Regular'
        ELSE 'Low Value'
    END AS customer_type

FROM
    customer_tier

ORDER BY
    revenue DESC;