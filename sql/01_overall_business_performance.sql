/* =====================================================
   QUESTION 1
   Overall Revenue & Profit
   FINAL OUTPUT (Power BI / Reporting)
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.order_id,
        o.quantity,
        o.sales_amount,
        p.unit_cost,
        p.invalid_cost_flag
    FROM order_clean o
    JOIN product_clean p
        ON o.product_id = p.product_id
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
)
SELECT
    SUM(sales_amount) AS total_revenue,
    SUM(
        CASE
            WHEN invalid_cost_flag = 'FALSE'
            THEN sales_amount - (quantity * unit_cost)
            ELSE 0
        END
    ) AS total_profit
FROM base_sales;
