Q: How many users do we have? 

"select
  count(user_id) as total_user_count
from
  dbt_jesse_h.stg_users;"

A:  130 users

Q: On average, how many orders do we receive per hour?

"select 
  round(
    avg(dh.order_count), 
    2
  ) as avg_order_count 
from 
  (
    select 
      date_trunc('hour', created_at) as date_hour, 
      count(order_id) as order_count 
    from 
      dbt_jesse_h.stg_orders 
    group by 
      date_hour
  ) as dh;"

  A: 7.52 orders per hour


Q: On average, how long does an order take from being placed to being delivered?

"SELECT
  avg(age(o.delivered_at, e.created_at)) as avg_time_to_deliver
FROM 
  dbt_jesse_h.stg_orders as o 
  LEFT JOIN (
    SELECT
      order_id,
      event_type, 
      created_at 
    FROM 
      dbt_jesse_h.stg_events 
    WHERE 
      event_type = 'checkout'
  ) as e ON o.order_id = e.order_id 
WHERE 
  delivered_at IS NOT NULL;"

  A:  3 days 21:24:14.819672

Q: How many users have only made one purchase? Two purchases? Three+ purchases?

"select 
  SUM(
    CASE WHEN pc.purchase_count = 1 then 1 else 0 end
  ) as total_single_purchase, 
  SUM(
    CASE WHEN pc.purchase_count = 2 then 1 else 0 end
  ) as total_double_purchase, 
  SUM(
    CASE WHEN pc.purchase_count > 2 then 1 else 0 end
  ) as total_tripleplus_purchase 
FROM 
  (
    SELECT 
      user_id, 
      count(order_id) as purchase_count 
    FROM 
      dbt_jesse_h.stg_orders 
    GROUP BY 
      user_id 
  ) AS pc;"


A: 25, 28, 71 respectively.


Q: On average, how many unique sessions do we have per hour?

"SELECT 
  round(
    avg(sph.distinct_count), 
    2
  ) as unique_sessions_per_hour 
FROM 
  (
    SELECT 
      date_trunc('hour', created_at) as datehour, 
      count(
        DISTINCT(session_id)
      ) AS distinct_count 
    FROM 
      dbt_jesse_h.stg_events 
    GROUP BY 
      datehour
  ) AS sph
"

A: 16.33 unique sessions per hour