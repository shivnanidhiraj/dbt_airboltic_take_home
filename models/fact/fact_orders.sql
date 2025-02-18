{{ config(materialized='view') }}

with base_orders as (
    select
        o.orderid,
        o.customerid,
        o.tripid,
        o.price,
        o.seatno,
        o.status
    from {{ ref('stg_order') }} o
),

joined as (
    select
        b.*,
        c.customer_key,
        t.trip_key
    from base_orders b
    left join {{ ref('dim_customers') }} c
      on b.customerid = c.customer_id
    left join {{ ref('dim_trip') }} t
      on b.tripid = t.trip_id
),

final as (
    select
        {{ generate_surrogate_key(['orderid']) }} as fact_order_key,
        orderid as order_id,
        customer_key,
        trip_key,
        price,
        seatno,
        status
    from joined
)

select * from final
