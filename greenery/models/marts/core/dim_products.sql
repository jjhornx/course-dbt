{{
    config(
        materialized = 'table'
    )
}}

WITH dim_products AS ( SELECT * FROM {{ ref('stg_products')}} )

SELECT
    product_guid,
    name,
    price
FROM
    dim_products