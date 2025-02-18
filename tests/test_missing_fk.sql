SELECT f.customer_key
FROM {{ ref('fact_orders') }} f
LEFT JOIN {{ ref('dim_customers') }} c ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL
