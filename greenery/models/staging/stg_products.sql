{{
    config(
        materialized = 'table'
    )
}}

WITH stg_products AS ( SELECT * FROM  {{ source('tutorial','products') }} )

SELECT
    product_id AS product_guid,
    name,
    price,
    inventory
FROM
    stg_products