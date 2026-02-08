/* =====================================================
   QUESTION 4.1
   Revenue & Profit by Region
   FINAL OUTPUT
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.sales_amount,
        o.quantity,
        p.unit_cost,
        p.invalid_cost_flag,
        c.region
    FROM order_clean o
    JOIN product_clean p
        ON o.product_id = p.product_id
    JOIN customer_clean c
        ON o.customer_id = c.customer_id
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
)
SELECT
    region,
    SUM(sales_amount) AS total_revenue,
    SUM(
        CASE
            WHEN invalid_cost_flag = 'FALSE'
            THEN sales_amount - (quantity * unit_cost)
            ELSE 0
        END
    ) AS total_profit,
   CAST(
       ROUND(
            SUM(
                CASE
                    WHEN invalid_cost_flag = 'FALSE'
                    THEN sales_amount - (quantity * unit_cost)
                    ELSE 0
                END
            ) * 100.0 / NULLIF(SUM(sales_amount), 0),
            2) AS DECIMAL (10,2)
        ) AS profit_margin_pct
    FROM base_sales
    GROUP BY region
    ORDER BY total_revenue DESC;


    /* =====================================================
   QUESTION 4.2
   Revenue & Profit by Customer Segment
   FINAL OUTPUT
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.sales_amount,
        o.quantity,
        p.unit_cost,
        p.invalid_cost_flag,
        c.segment
    FROM order_clean o
    JOIN product_clean p
        ON o.product_id = p.product_id
    JOIN customer_clean c
        ON o.customer_id = c.customer_id
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
)
SELECT
    segment,
    SUM(sales_amount) AS total_revenue,
    SUM(
        CASE
            WHEN invalid_cost_flag = 'FALSE'
            THEN sales_amount - (quantity * unit_cost)
            ELSE 0
        END
    ) AS total_profit,
    CAST(
        ROUND(
            SUM(
                CASE
                    WHEN invalid_cost_flag = 'FALSE'
                    THEN sales_amount - (quantity * unit_cost)
                    ELSE 0
                END
            ) * 100.0 / NULLIF(SUM(sales_amount), 0),
            2) AS DECIMAL (10,2) 
        ) AS profit_margin_pct
    FROM base_sales
    GROUP BY segment
    ORDER BY total_revenue DESC;

    /* =====================================================
   QUESTION 4.3
   Region x Segment Performance Matrix
   FINAL OUTPUT
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.sales_amount,
        o.quantity,
        p.unit_cost,
        p.invalid_cost_flag,
        c.region,
        c.segment
    FROM order_clean o
    JOIN product_clean p
        ON o.product_id = p.product_id
    JOIN customer_clean c
        ON o.customer_id = c.customer_id
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
)
SELECT
    region,
    segment,
    SUM(sales_amount) AS total_revenue,
    SUM(
        CASE
            WHEN invalid_cost_flag = 'FALSE'
            THEN sales_amount - (quantity * unit_cost)
            ELSE 0
        END
    ) AS total_profit,
    CAST(
        ROUND(
            SUM(
                CASE
                    WHEN invalid_cost_flag = 'FALSE'
                    THEN sales_amount - (quantity * unit_cost)
                    ELSE 0
                END
            ) * 100.0 / NULLIF(SUM(sales_amount), 0),
            2) AS DECIMAL (10,2) 
    ) AS profit_margin_pct
FROM base_sales
GROUP BY region, segment
ORDER BY region, total_revenue DESC;
