/* =====================================================
   QUESTION 3
   Product Performance & Profitability
   Revenue & Profit by Product
   FINAL OUTPUT
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.product_id,
        o.quantity,
        o.sales_amount,
        p.product_name,
        p.category,
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
    product_id,
    product_name,
    category,
    SUM(sales_amount) AS total_revenue,
    SUM(
        CASE
            WHEN invalid_cost_flag = 'FALSE'
            THEN sales_amount - (quantity * unit_cost)
            ELSE 0
        END
    ) AS total_profit
FROM base_sales
GROUP BY
    product_id,
    product_name,
    category
ORDER BY total_revenue DESC;

/* =====================================================
   QUESTION 3
   Product Margin & Profitability Ranking
   ===================================================== */

WITH product_perf AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(o.sales_amount) AS total_revenue,
        SUM(
            CASE
                WHEN p.invalid_cost_flag = 'FALSE'
                THEN o.sales_amount - (o.quantity * p.unit_cost)
                ELSE 0
            END
        ) AS total_profit
    FROM order_clean o
    JOIN product_clean p
        ON o.product_id = p.product_id
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)
SELECT
    product_id,
    product_name,
    category,
    total_revenue,
    total_profit,
    CAST(ROUND(
        total_profit * 100.0 / NULLIF(total_revenue, 0),
        2) AS DECIMAL (10,2)
    ) AS profit_margin_pct,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM product_perf
ORDER BY total_revenue DESC;
