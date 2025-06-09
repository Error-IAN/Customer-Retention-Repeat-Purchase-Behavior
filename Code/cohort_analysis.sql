WITH cohort_base AS (
  SELECT 
    Customer_Name,
    MIN(DATE_TRUNC(DATE(Date), MONTH)) AS cohort_month
  FROM `retail_transaction.chohort_analysis`
  GROUP BY Customer_Name
),

transaction_with_cohort AS (
  SELECT 
    t.Customer_Name,
    DATE_TRUNC(DATE(t.Date), MONTH) AS txn_month,
    c.cohort_month
  FROM `retail_transaction.chohort_analysis` t
  JOIN cohort_base c ON t.Customer_Name = c.Customer_Name
),

cohort_tracking AS (
  SELECT 
    cohort_month,
    txn_month,
    DATE_DIFF(DATE(txn_month), DATE(cohort_month), MONTH) AS cohort_age,
    COUNT(DISTINCT Customer_Name) AS active_users,
    ROUND(
      COUNT(DISTINCT Customer_Name) * 100.0 
      / SUM(COUNT(DISTINCT Customer_Name)) OVER (), 2
    ) AS active_percent
  FROM transaction_with_cohort
  GROUP BY cohort_month, txn_month
)

SELECT * 
FROM cohort_tracking
ORDER BY cohort_month, cohort_age;
