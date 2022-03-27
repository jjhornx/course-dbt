{{
    config(
        materialized = 'table'
    )
}}

WITH stg_users AS ( SELECT * FROM {{ source('tutorial','orders') }} )

SELECT
    order_id AS order_guid,
    user_id AS user_guid,
    promo_id AS promo_guid,
    address_id AS address_guid,
    created_at AS created_at_utc,
    order_cost,
    shipping_cost, 
    order_total,
    tracking_id AS tracking_guid,
    shipping_service,
    estimated_delivery_at AS estimated_delivery_at_utc,
    delivered_at AS delivered_at_utc
FROM
    stg_users
