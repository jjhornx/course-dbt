PART 1:

What is our overall conversion rate? 62.5 percent

```
WITH sessions_agg AS (
    SELECT
        SUM(checkout_total) AS sessions_with_purchase,
        COUNT(session_id) AS total_sessions
    FROM dbt_jesse_h.event_type_aggs
)

SELECT ROUND(
        sessions_with_purchase::DECIMAL / total_sessions, 3
    ) AS conversion_rate

FROM sessions_agg
```

What is our conversion rate by product?

I don't know.

