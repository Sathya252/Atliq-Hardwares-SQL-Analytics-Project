WITH product_count_2020 AS (
    SELECT 
        dp.segment,
        COUNT(DISTINCT fsm.product_code) AS product_count_2020
    FROM fact_sales_monthly fsm
    JOIN dim_product dp 
        ON fsm.product_code = dp.product_code
    WHERE fsm.fiscal_year = 2020
    GROUP BY dp.segment
),
product_count_2021 AS (
    SELECT 
        dp.segment,
        COUNT(DISTINCT fsm.product_code) AS product_count_2021
    FROM fact_sales_monthly fsm
    JOIN dim_product dp 
        ON fsm.product_code = dp.product_code
    WHERE fsm.fiscal_year = 2021
    GROUP BY dp.segment
)
SELECT 
    p2020.segment,
    p2020.product_count_2020,
    p2021.product_count_2021,
    (p2021.product_count_2021 - p2020.product_count_2020) AS difference
FROM product_count_2020 p2020
JOIN product_count_2021 p2021 
    ON p2020.segment = p2021.segment
ORDER BY difference DESC;
