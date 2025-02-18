-- tests/test_flight_duration_non_negative.sql
SELECT trip_key, flight_duration_hours
FROM {{ ref('dim_trip') }}
WHERE flight_duration_hours < 0
