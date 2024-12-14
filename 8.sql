WITH sales_with_quarters AS (
    SELECT
        CASE
            WHEN MONTH(date) IN (9, 10, 11) THEN CONCAT('Q1 ', YEAR(date) + 1) -- Sep-Nov belong to Q1 of the next fiscal year
            WHEN MONTH(date) IN (12, 1, 2) THEN CONCAT('Q2 ', YEAR(date) + 1) -- Dec-Feb belong to Q2 of the next fiscal year
            WHEN MONTH(date) IN (3, 4, 5) THEN CONCAT('Q3 ', YEAR(date))      -- Mar-May belong to Q3 of the current fiscal year
            WHEN MONTH(date) IN (6, 7, 8) THEN CONCAT('Q4 ', YEAR(date))      -- Jun-Aug belong to Q4 of the current fiscal year
        END AS Quarter,
        sold_quantity
    FROM
        fact_sales_monthly
    WHERE
        YEAR(date) = 2020 -- Filter for the year 2020
)
SELECT
    Quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM
    sales_with_quarters
GROUP BY
    Quarter
ORDER BY
    total_sold_quantity DESC;
