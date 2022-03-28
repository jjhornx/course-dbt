{{
  config(
    materialized='table'
  )
}}

with o_i as (SELECT * from  {{ ref('stg_order_items') }} )

SELECT
  o_i.order_id,
  o_i.product_id,
  p.name
FROM
  o_i
  LEFT JOIN {{ ref('stg_products') }} p ON o_i.product_id = p.product_guid