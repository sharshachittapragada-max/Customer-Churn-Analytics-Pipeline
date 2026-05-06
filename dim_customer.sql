SELECT DISTINCT
    customer_id,
    gender,
    senior_citizen,
    partner,
    dependents,
    tenure

FROM {{ ref('stg_telco_churn') }}