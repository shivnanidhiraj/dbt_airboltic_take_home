{{ config(materialized='view') }}

with raw_aeroplane as (
    select
        airplaneid,
        airplanemodel,
        manufacturer
    from {{ source('postgres', 'aeroplane') }}
)

select
    airplaneid,
    airplanemodel,
    manufacturer
from raw_aeroplane
