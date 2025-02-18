{{ config(materialized='view') }}

with raw_order as (
    select
        orderid,
        customerid,
        tripid,
        price,
        seatno,
        status
    from {{ source('postgres', 'order') }}
)

select
    orderid,
    customerid,
    tripid,
    price,
    seatno,
    status
from raw_order
