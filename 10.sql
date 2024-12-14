WITH fiscal_2021_sales AS (
    SELECT
        dp.division,
        fsm.product_code,
        dp.product,
        SUM(fsm.sold_quantity) AS total_sold_quantity
    FROM
        fact_sales_monthly fsm
    INNER JOIN
        dim_product dp
        ON fsm.product_code = dp.product_code
    WHERE
        DATE(fsm.date) BETWEEN '2020-09-01' AND '2021-08-31' -- Fiscal year 2021
    GROUP BY
        dp.division, fsm.product_code, dp.product
),
ranked_products AS (
    SELECT
        division,
        product_code,
        product,
        total_sold_quantity,
        RANK() OVER (PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order
    FROM
        fiscal_2021_sales
)
SELECT
    division,
    product_code,
    product,
    total_sold_quantity,
    rank_order
FROM
    ranked_products
WHERE
    rank_order <= 3
ORDER BY
    division, rank_order;
