WITH monthly_revenue AS (
    SELECT
        EXTRACT(MONTH FROM invoice_date) AS month,
        SUM(unit_price * quantity) AS revenue

    FROM
        online_retail

    WHERE
        invoice_no NOT LIKE 'C%' AND 
        EXTRACT(YEAR FROM invoice_date) = 2011

    GROUP BY
        month
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS last_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change,
    
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) /
        LAG(revenue) OVER (ORDER BY month) * 100,
    2) AS mom_pct_change

FROM
    monthly_revenue

ORDER BY
    month;