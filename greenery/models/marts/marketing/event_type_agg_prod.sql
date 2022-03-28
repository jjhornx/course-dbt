{{
     config(
        materialized = 'table'
    )
}}

WITH orders AS (SELECT * FROM {{ ref('stg_events')}} )

SELECT
    product_guid,
    COUNT(DISTINCT(session_id)) as session_ct
    {{event_types_aggs('event_type')}}
FROM orders
GROUP BY 1
