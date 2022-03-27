{{
    config(
        materialized = 'table'
    )
}}

WITH user_order_facts AS ( SELECT * FROM {{ ref('stg_orders')}} )

SELECT
    user_guid,
    order_guid,
    i.product_id,
    i.quantity,
    promo_guid,
    p.discount,
    created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_guid,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc
FROM
    user_order_facts
LEFT JOIN {{ ref('stg_order_items') }} AS i ON order_guid = i.order_id
LEFT JOIN {{ ref('stg_promos') }} AS p ON promo_guid = p.promo_id

