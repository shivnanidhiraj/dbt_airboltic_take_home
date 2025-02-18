{{ config(materialized='view') }}

with raw_customer_group as (
    select
        id as group_id,
        type as group_type,
        name as group_name,
        registrynumber
    from {{ source('postgres', 'customer_group') }}
)

select
    group_id,
    group_type,
    group_name,
    registrynumber
from raw_customer_group
