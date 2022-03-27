{{
    config(
        materialized = 'table'
    )
}}

WITH int_product_events AS ( SELECT * FROM {{ ref('stg_events')}} )

SELECT
    product_guid,
    COUNT(
        CASE
            WHEN event_type = 'page_view' AND product_guid IS NOT NULL THEN 1
        END
    ) AS page_views,
    COUNT(
        CASE
            WHEN event_type = 'add_to_cart' AND product_guid IS NOT NULL THEN 1
        END
    ) AS cart_adds
FROM int_product_events WHERE product_guid IS NOT NULL
GROUP BY 1
