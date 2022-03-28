{{
     config(
        materialized = 'table'
    )
}}

WITH orders AS (SELECT * FROM {{ ref('stg_events')}} )

SELECT
    session_id
    {{event_types_aggs('event_type')}}
FROM orders
GROUP BY 1
