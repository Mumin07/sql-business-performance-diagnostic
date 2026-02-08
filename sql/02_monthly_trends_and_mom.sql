/* =====================================================
   QUESTION 2
   Monthly Revenue & Profit Trend
   FINAL OUTPUT
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.order_date,
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
        AND o.missing_date_flag = 0
),
monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month,
        SUM(sales_amount) AS monthly_revenue,
        SUM(
            CASE
                WHEN invalid_cost_flag = 'FALSE'
                THEN sales_amount - (quantity * unit_cost)
                ELSE 0
            END
        ) AS monthly_profit
    FROM base_sales
    GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
)
SELECT
    month,
    monthly_revenue,
    monthly_profit
FROM monthly_sales
ORDER BY month;


/* =====================================================
   QUESTION 2 (CONTINUED)
   Month-over-Month Revenue & Profit Growth
   FINAL OUTPUT
   ===================================================== */

WITH base_sales AS (
    SELECT
        o.order_date,
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
        AND o.missing_date_flag = 0
),
monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month,
        SUM(sales_amount) AS monthly_revenue,
        SUM(
            CASE
                WHEN invalid_cost_flag = 'FALSE'
                THEN sales_amount - (quantity * unit_cost)
                ELSE 0
            END
        ) AS monthly_profit
    FROM base_sales
    GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
)
SELECT
    month,

    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(monthly_profit, 2) AS monthly_profit,

   CAST(
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) * 100.0
        / NULLIF(LAG(monthly_revenue) OVER (ORDER BY month), 0),
        2
    ) AS DECIMAL(10,2)
) AS revenue_mom_pct,

CAST(
    ROUND(
        (monthly_profit - LAG(monthly_profit) OVER (ORDER BY month)) * 100.0
        / NULLIF(LAG(monthly_profit) OVER (ORDER BY month), 0),
        2
    ) AS DECIMAL(10,2)
) AS profit_mom_pct


FROM monthly_sales
ORDER BY month;
