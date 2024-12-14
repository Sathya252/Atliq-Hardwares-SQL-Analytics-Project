SELECT 
    MONTH(fsm.date) AS Month, 
    YEAR(fsm.date) AS Year, 
    ROUND(SUM(fgp.gross_price * fsm.sold_quantity), 2) AS Gross_Sales_Amount
FROM 
    fact_sales_monthly fsm
JOIN 
    dim_customer dc 
    ON fsm.customer_code = dc.customer_code
JOIN 
    fact_gross_price fgp 
    ON fsm.product_code = fgp.product_code
WHERE 
    dc.customer = 'Atliq Exclusive'
GROUP BY 
    YEAR(fsm.date), MONTH(fsm.date)
ORDER BY 
    Year, Month;
