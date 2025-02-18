SELECT order_id
FROM {{ ref('fact_orders') }}
GROUP BY order_id
HAVING COUNT(*) > 1
