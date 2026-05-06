

# 📊 End-to-End Telco Churn Analytics Pipeline (DBT + PostgreSQL + Tableau)

## 🔍 Project Overview

This project demonstrates a complete end-to-end analytics engineering workflow for analyzing customer churn in a telecom business.

The pipeline covers data ingestion, transformation, data modeling, and visualization to generate actionable business insights. It is designed to reflect real-world analytics engineering practices using dbt, PostgreSQL, and Tableau.

---

## 🎯 Objectives

* Build a scalable data pipeline for churn analysis
* Transform raw data into analytics-ready datasets
* Design fact and dimension tables for reporting
* Enable business users to analyze churn and revenue trends
* Deliver insights through an interactive dashboard

---

## 📁 Dataset

* Telco Customer Churn dataset (sourced from Kaggle)
* Includes customer demographics, services, billing, and churn status

### Key Fields Used:

* Customer ID
* Tenure
* Monthly Charges
* Contract Type
* Payment Method
* Churn Status

---

## 🏗️ Data Pipeline Overview

This project follows a modern analytics engineering workflow:

**Raw Data → PostgreSQL → dbt (Staging → Marts) → Tableau Dashboard**

### Key Steps:

1. Data Cleaning & Validation in PostgreSQL  
2. Data Transformation using dbt  
3. Data Modeling (Star Schema: Facts & Dimensions)  
4. Dashboard Creation in Tableau  

---

## 🧠 Data Modeling

A star schema design was implemented to support efficient analytical queries.

### ⭐ Staging Model
WITH source AS (

SELECT *
FROM public.raw_telco_churn

)

SELECT

"customerID" AS customer_id,
gender,
"SeniorCitizen" AS senior_citizen,
"Partner" AS partner,
"Dependents" AS dependents,
"tenure",
"PhoneService" AS phone_service,
"MultipleLines" AS multiple_lines,
"InternetService" AS internet_service,
"OnlineSecurity" AS online_security,
"OnlineBackup" AS online_backup,
"DeviceProtection" AS device_protection,
"TechSupport" AS tech_support,
"StreamingTV" AS streaming_tv,
"StreamingMovies" AS streaming_movies,
"Contract" AS contract,
"PaperlessBilling" AS paperless_billing,
"PaymentMethod" AS payment_method,
"MonthlyCharges" AS monthly_charges,
"TotalCharges" AS total_charges,

-- -- Fix numeric issue (very important)
-- CASE
-- WHEN "TotalCharges" = '' THEN NULL
-- ELSE CAST("TotalCharges" AS NUMERIC)
-- END AS total_charges,

"Churn" AS churn

FROM source
### ⭐ Fact Table
* `fact_churn`
  * customer_id
  * churn_flag
  * monthly_charges
  * tenure
  * total charges
  * estimated revenue

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

### ⭐ Key perfomance Indicators

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

### ⭐ Dimension Tables
* `dim_customer`
* `dim_contract`
* `dim_services`

This structure improves query performance and simplifies business reporting.

---

## ✅ Data Quality & Validation

Data quality checks were implemented using dbt tests:

* No null values in primary keys
* Valid churn values (Yes/No)
* Consistent relationships between fact and dimension tables

---

## 📊 Key Outcomes

* Customers with **month-to-month contracts** show the highest churn rate  
* **Long-tenure customers** are significantly less likely to churn  
* Customers with **higher monthly charges** tend to churn more  
* Certain services show **high churn but also high revenue contribution**  

---

## 📊 Dashboard Features

* Churn rate analysis by customer segments  
* Revenue breakdown by contract type  
* Customer distribution by tenure  
* Interactive filters (contract type, services, tenure)  
* KPI summary:
  * Total Customers
  * Churn Rate
  * Total Revenue
  * Average Monthly Charges

---

## 🛠 Tools & Technologies

* **PostgreSQL** – Data storage and preprocessing  
* **dbt (Data Build Tool)** – Data transformation and modeling  
* **SQL** – Data manipulation and transformation logic  
* **Tableau** – Data visualization and dashboarding  

---

## 🔗 Interactive Dashboard

View the live dashboard on Tableau Public:  
https://public.tableau.com/views/Telco_Churn_17779261794740/ExecutiveChurnSummary?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

---

## 💡 Business Recommendations

* Encourage customers to move to **long-term contracts**  
* Target **high-value customers at risk of churn**  
* Improve retention strategies for **high-churn services**  
* Provide incentives for **new customers in early tenure stages**  

---

## 🚀 Skills Demonstrated

* Analytics Engineering (dbt workflow)  
* Data Modeling (Star Schema Design)  
* SQL Development  
* Data Quality & Testing  
* Data Visualization & Storytelling  
* Business Insight Generation  
