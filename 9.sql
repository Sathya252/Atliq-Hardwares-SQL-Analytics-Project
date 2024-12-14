WITH fiscal_2021_sales AS (
    SELECT
        dim_customer.channel,
        (fgp.gross_price * fsm.sold_quantity) / 1000000 AS gross_sales_mln
    FROM
        fact_sales_monthly fsm
    INNER JOIN
        fact_gross_price fgp
        ON fsm.product_code = fgp.product_code
    INNER JOIN
        dim_customer
        ON fsm.customer_code = dim_customer.customer_code
    WHERE
        DATE(fsm.date) BETWEEN '2020-09-01' AND '2021-08-31' -- Fiscal year 2021
),
channel_sales AS (
    SELECT
        channel,
        SUM(gross_sales_mln) AS total_gross_sales_mln
    FROM
        fiscal_2021_sales
    GROUP BY
        channel
),
final_report AS (
    SELECT
        channel,
        total_gross_sales_mln,
        ROUND(
            (total_gross_sales_mln / SUM(total_gross_sales_mln) OVER()) * 100,
            2
        ) AS percentage
    FROM
        channel_sales
)
SELECT
    channel,
    total_gross_sales_mln,
    percentage
FROM
    final_report
ORDER BY
    total_gross_sales_mln DESC
LIMIT 1;
