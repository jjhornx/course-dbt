{{
    config(
        materialized = 'table'
    )
}}

WITH stg_users AS ( SELECT * FROM {{ source('tutorial', 'users')}} )

SELECT
    user_id as user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at AS created_at_utc,
    updated_at AS updated_at_utc,
    address_id as address_guid
FROM
    stg_users