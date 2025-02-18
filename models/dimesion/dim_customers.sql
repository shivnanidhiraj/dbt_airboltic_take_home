{{ config(materialized='view') }}

with base as (
    select
        c.customerid,
        c.name,
        c.email,
        c.phonenumber,
        -- I have joined this with stg_customer_group in order to flatten group attributes
        cg.group_id,
        cg.group_type,
        cg.group_name,
        cg.registrynumber
    from {{ ref('stg_customers') }} c
    left join {{ ref('stg_customer_group') }} cg
        on c.customergroupid = cg.group_id
),

deduplicated as (
    select distinct *
    from base
),

final as (
    select
        -- I have used surrogate keys from the macros which I've developed to generate a unique key and show the usage of macros
        {{ generate_surrogate_key(["customerid"]) }} as customer_key,
        customerid as customer_id,
        name as customer_name,
        email,
        phonenumber,
        group_id as customer_group_id,
        group_type as customer_group_type,
        group_name as customer_group_name,
        registrynumber
    from deduplicated
)

select * from final

