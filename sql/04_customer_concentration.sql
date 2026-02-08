/* =====================================================
   QUESTION 5.1
   Customer Revenue & Profit
   ===================================================== */

WITH customer_perf AS (
    SELECT
        o.customer_id,
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
    GROUP BY o.customer_id
)
SELECT
    customer_id,
    total_revenue,
    total_profit,
    CAST(
        ROUND(
            total_profit * 100.0 / NULLIF(total_revenue, 0),
            2)AS DECIMAL (10,2)
        ) AS profit_margin_pct
    FROM customer_perf
    ORDER BY total_revenue DESC;

    /* =====================================================
   QUESTION 5.2
   Customer Revenue Concentration (Pareto)
   ===================================================== */

WITH customer_perf AS (
    SELECT
        o.customer_id,
        SUM(o.sales_amount) AS total_revenue
    FROM order_clean o
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
    GROUP BY o.customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_revenue,
        SUM(total_revenue) OVER () AS overall_revenue,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS customer_rank
    FROM customer_perf
)
SELECT
    customer_id,
    customer_rank,
    total_revenue,
    CAST(
        ROUND(
            cumulative_revenue * 100.0 / overall_revenue,
            2) AS DECIMAL(10,2)
        ) AS cumulative_revenue_pct
    FROM ranked_customers
    ORDER BY customer_rank;



    /* =====================================================
   QUESTION 5.3
   Top 20 Percent Customer Contribution
   FINAL OUTPUT
   ===================================================== */

WITH customer_perf AS (
    SELECT
        o.customer_id,
        SUM(o.sales_amount) AS total_revenue
    FROM order_clean o
    WHERE
        o.invalid_quantity_flag = 0
        AND o.invalid_product_flag = 0
        AND o.invalid_customers_flag = 0
    GROUP BY o.customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_revenue,
        NTILE(5) OVER (ORDER BY total_revenue DESC) AS revenue_bucket
    FROM customer_perf
)
SELECT
    revenue_bucket,
    COUNT(customer_id) AS customer_count,
    SUM(total_revenue) AS bucket_revenue,
    CAST(
        ROUND(
            SUM(total_revenue) * 100.0 / SUM(SUM(total_revenue)) OVER (),
            2) AS DECIMAL (10,2)
        ) AS revenue_pct
    FROM ranked_customers
    GROUP BY revenue_bucket
    ORDER BY revenue_bucket;


/* =====================================================
   QUESTION 5.4 (FIXED)
   High-Revenue but Low-Profit Customers
   ===================================================== */

WITH customer_perf AS (
    SELECT
        o.customer_id,
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
    GROUP BY o.customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_revenue,
        total_profit,
        NTILE(5) OVER (ORDER BY total_revenue DESC) AS revenue_bucket
    FROM customer_perf
)
SELECT
    customer_id,
    total_revenue,
    total_profit,
    CAST(
        ROUND(
            total_profit * 100.0 / NULLIF(total_revenue, 0),
            2) AS DECIMAL (10,2)
        ) AS profit_margin_pct
    FROM ranked_customers
    WHERE revenue_bucket = 1   -- top 20% customers
      AND total_profit <= 0
    ORDER BY total_revenue DESC;
