WITH unique_products AS (
    SELECT 
        YEAR(s.date) AS sales_year,
        COUNT(DISTINCT product_code) AS unique_products
    FROM fact_sales_monthly s
    WHERE YEAR(s.date) IN (2020, 2021)
    GROUP BY YEAR(s.date)
)
SELECT 
    u2020.unique_products AS unique_products_2020,
    u2021.unique_products AS unique_products_2021,
    ROUND((u2021.unique_products - u2020.unique_products) * 100.0 / u2020.unique_products, 2) AS percentage_chg
FROM 
    (SELECT unique_products FROM unique_products WHERE sales_year= 2020) u2020
CROSS JOIN 
    (SELECT unique_products FROM unique_products WHERE sales_year = 2021) u2021;
