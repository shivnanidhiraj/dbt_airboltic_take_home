{{ config(materialized='view') }}

with base as (
    select
        a.airplaneid,
        a.airplanemodel,
        a.manufacturer
    from {{ ref('stg_aeroplane') }} a
),

deduplicated as (
    select distinct *
    from base
),

-- I am joining this with parsed plane model data
model_attrs as (
    select
        d.*,
        m.max_seats,
        m.max_weight,
        m.max_distance,
        m.engine_type
    from deduplicated d
    left join {{ ref('stg_aeroplane_model') }} m
      on  lower(d.manufacturer)   = lower(m.manufacturer)
      and lower(d.airplanemodel)  = lower(m.airplane_model)
),

final as (
    select
        {{ generate_surrogate_key(["airplaneid"]) }} as airplane_key,
        airplaneid as airplane_id,
        airplanemodel,
        manufacturer,
        max_seats,
        max_weight,
        max_distance,
        engine_type
    from model_attrs
)

select * from final
