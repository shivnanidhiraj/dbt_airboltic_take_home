{{ config(materialized='view') }}

with base as (
    select
        t.tripid,
        t.origincity,
        t.destinationcity,
        t.airplaneid,
        t.starttimestamp,
        t.endtimestamp
    from {{ ref('stg_trip') }} t
),

deduplicated as (
    select distinct *
    from base
),

joined as (
    select
        d.*,
        a.airplane_key
    from deduplicated d
    left join {{ ref('dim_aeroplane') }} a
        on d.airplaneid = a.airplane_id
),

final as (
    select
        {{ generate_surrogate_key(["tripid"]) }} as trip_key,
        tripid as trip_id,
        origincity,
        destinationcity,
        airplane_key,
        starttimestamp as trip_start_ts,
        endtimestamp   as trip_end_ts,
        EXTRACT(EPOCH FROM (endtimestamp - starttimestamp))/3600 
            as flight_duration_hours -- I have stored the flight duration in trip dimension
    from joined
)

select * from final
