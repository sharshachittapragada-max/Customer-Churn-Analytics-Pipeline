SELECT DISTINCT
    customer_id,
    phone_service,
    internet_service,
    online_backup,
    online_security,
    device_protection,
    tech_support,
    streaming_tv,
    streaming_movies

FROM {{ ref('stg_telco_churn') }}