{{ config(materialized='view') }}

with raw_trip as (
    select
        tripid,
        origincity,
        destinationcity,
        airplaneid,
        starttimestamp,
        endtimestamp
    from {{ source('postgres', 'trip') }}
)

select
    tripid,
    origincity,
    destinationcity,
    airplaneid,
    starttimestamp,
    endtimestamp
from raw_trip
