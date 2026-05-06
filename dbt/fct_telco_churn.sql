Select 
    customer_id,
    tenure,
    monthly_charges,
    total_charges,

    CASE
        WHEN churn = 'Yes' THEN 1
        ELSE 0
    END AS churn_flag,

    (tenure * monthly_charges) AS estimated_revenue

FROM {{ ref('stg_telco_churn') }}