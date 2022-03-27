{{
    config(
        materialized = 'table'
    )
}}

WITH fact_orders AS ( SELECT * FROM {{ref('stg_orders')}} )

SELECT
    order_guid,
    user_guid,
    promo_guid,
    address_guid,
    created_at_utc,
    order_cost,
    shipping_cost, 
    order_total,
    tracking_guid,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc
FROM
    fact_orders