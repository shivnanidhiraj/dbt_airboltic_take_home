{{ config(materialized='view') }}

with raw_customers as (
    select
        customerid,
        name,
        customergroupid,
        email,
        phonenumber
    from {{ source('postgres', 'customers') }}
)

select
    customerid,
    name,
    customergroupid,
    email,
    phonenumber
from raw_customers
