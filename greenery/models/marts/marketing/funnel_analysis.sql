
{{
     config(
        materialized = 'table'
    )
}}

WITH daily_session AS (
    SELECT DISTINCT
        session_id AS s_id,
        date_trunc('day', created_at) AS daydate
    FROM {{ ref('stg_events') }}
),

step_one AS (SELECT
        daily_session.daydate,
        count(
            CASE
                WHEN
                    page_view_total > 0 OR add_to_cart_total > 0 OR checkout_total > 0 THEN session_id
            END
        ) AS session_count
    FROM {{ ref('event_type_aggs') }} e
    LEFT JOIN
        daily_session ON
            e.session_id = daily_session.s_id
    GROUP BY 1
),

step_two AS (SELECT
    daily_session.daydate,
    count(
        CASE
            WHEN add_to_cart_total > 0 OR checkout_total > 0 THEN session_id
        END
    ) AS session_count
    FROM {{ ref('event_type_aggs') }} e
    LEFT JOIN
        daily_session ON
            e.session_id = daily_session.s_id
    GROUP BY 1
),

step_three AS (SELECT
    daily_session.daydate,
    count(CASE WHEN checkout_total > 0 THEN session_id END) AS session_count
    FROM {{ ref('event_type_aggs') }} e
    LEFT JOIN
        daily_session ON
            e.session_id = daily_session.s_id
    GROUP BY 1
),

steps AS (
    SELECT
        daydate,
        'Step 1' AS step,
        session_count
    FROM step_one GROUP BY 1, 2, 3
    UNION DISTINCT
    SELECT
        daydate,
        'Step 2' AS step,
        session_count
    FROM step_two GROUP BY 1, 2, 3
    UNION DISTINCT
    SELECT
        daydate,
        'Step 3' AS step,
        session_count
    FROM step_three GROUP BY 1, 2, 3

    ORDER BY daydate ASC, step ASC
)

SELECT
    daydate,
    step,
    session_count,
    lag(session_count, 1) OVER ( PARTITION BY daydate),
    round(
        (
            1.0 - session_count::NUMERIC / lag(
                session_count, 1
            ) OVER (PARTITION BY daydate)
        ),
        2
    ) AS drop_off
FROM steps
