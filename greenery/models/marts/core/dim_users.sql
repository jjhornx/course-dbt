{{
    config(
        materialized = 'table'
    )
}}

WITH dim_users AS ( SELECT * FROM {{ ref('stg_users')}} )

SELECT
    user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at_utc,
    updated_at_utc,
    address_guid
FROM
    dim_users