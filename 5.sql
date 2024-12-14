WITH highest_cost AS (
    SELECT 
        product_code,
        MAX(manufacturing_cost) AS manufacturing_cost
    FROM fact_manufacturing_cost
    GROUP BY product_code
),
lowest_cost AS (
    SELECT 
        product_code,
        MIN(manufacturing_cost) AS manufacturing_cost
    FROM fact_manufacturing_cost
    GROUP BY product_code
)
SELECT 
    dp.product_code,
    dp.product,
    fmc.manufacturing_cost
FROM fact_manufacturing_cost fmc
JOIN dim_product dp 
    ON dp.product_code = fmc.product_code
WHERE fmc.manufacturing_cost IN (
    (SELECT MAX(manufacturing_cost) FROM highest_cost),
    (SELECT MIN(manufacturing_cost) FROM lowest_cost)
);
