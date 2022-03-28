{{
    config(
        materialized = 'table'
    )
}}

WITH page_views AS ( SELECT * FROM {{ ref('stg_events') }} )

SELECT 
    pv.event_id,
    pv.session_id,
    pv.user_id,
    pv.page_url,
    pv.created_at,
    pv.product_guid,
    dp.name,
    dp.price
FROM page_views pv
LEFT JOIN {{ ref('dim_products')}} dp ON pv.product_guid = dp.product_guid
WHERE event_type = 'page_view'
