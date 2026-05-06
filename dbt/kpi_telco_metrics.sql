WITH base AS (

    SELECT *
    FROM {{ ref('fct_telco_churn') }}

)

SELECT

    COUNT(*) AS total_customers,

    SUM(churn_flag) AS churn_customers,

    ROUND(
        SUM(churn_flag)::numeric / COUNT(*) ,
        4

    ) AS churn_rate,

    ROUND(
        AVG(monthly_charges)::numeric,
        2
    ) AS avg_monthly_revenue,

    Round(
        SUM(estimated_revenue)::numeric,
        2
    ) AS total_estimated_revenue

FROM base