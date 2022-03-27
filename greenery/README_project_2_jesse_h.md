What is our user repeat rate?

***sql
WITH repeatcounts AS (
    SELECT
        COUNT( CASE WHEN order_count > 1 THEN 1 END) AS users_above_1,
        COUNT( DISTINCT user_guid) AS total_users
    FROM dbt_jesse_h.int_fact_user_orders_agg
)

SELECT ROUND(users_above_1::DECIMAL / total_users, 3) AS repeat_rate

FROM repeatcounts
***

Explain the marts models you added. Why did you organize the models in the way you did?

-I can't honestly say. I'm not sure why we are building the marts, and I don't know what kind of reporting an end user will require. I usually start with requirements from the user and then author datasets with the data I have or generate new datasets from requests to vendors. I don't have a frame of reference for website data or sales data. Over time after some familiariy with the source system, business rules, and user expectations I can anticipate analytical needs.