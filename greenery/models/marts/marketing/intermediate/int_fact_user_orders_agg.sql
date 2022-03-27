{{
    config(
        materialized = 'table'
    )
}}

WITH int_fact_user_orders_agg AS ( SELECT * FROM {{ ref('fact_orders')}} )

SELECT
    user_guid,
    COUNT(DISTINCT(order_guid)) AS order_count,
    COUNT(promo_guid) AS promo_count,
    MIN(created_at_utc) AS earliest_order,
    MAX(created_at_utc) AS latest_order,
    SUM(order_total) AS total_order_spend
FROM
    int_fact_user_orders_agg
GROUP BY 1