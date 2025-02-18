{{ config(materialized='view') }}  -- this can be 'table' or 'incremental', but I have considered view, incremental is well suited when data is large

select 
    manufacturer,
    airplane_model,
    max_seats,
    max_weight,
    max_distance,
    engine_type
from {{ ref('aeroplane_model') }}
