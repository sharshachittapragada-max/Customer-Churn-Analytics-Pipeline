SELECT DISTINCT
    customer_id,
    contract,
    payment_method,
    paperless_billing

FROM {{ ref('stg_telco_churn') }}