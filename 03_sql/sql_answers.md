# SQL Answers

## Q1
### Query
```sql
-- Q1
SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status
ORDER BY transaction_count DESC;
```
### Result Summary
    status  count
  captured     19
chargeback      4
    failed      7

## Q2
### Query
```sql
SELECT merchant_name, SUM(amount_usd) AS captured_gmv_usd
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY captured_gmv_usd DESC;
```
### Result Summary
merchant_name  amount_usd
  Beta Stores     33431.0
   Alpha Mart     29984.5
Delta Travels     10300.0
  City Pharma      8640.0

## Q3
### Query
```sql
SELECT merchant_name, SUM(amount_usd) AS captured_gmv_usd
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY captured_gmv_usd DESC
LIMIT 10;
```
### Result Summary
merchant_name  amount_usd
  Beta Stores     33431.0
   Alpha Mart     29984.5
Delta Travels     10300.0
  City Pharma      8640.0

## Q4
### Query
```sql
SELECT transaction_date, SUM(amount_usd) AS total_gmv_usd, SUM(CASE WHEN status = 'captured' THEN 1 ELSE 0 END) AS successful_transactions
FROM cleaned_transactions
GROUP BY transaction_date
ORDER BY transaction_date;
```
### Result Summary
transaction_date  total_gmv_usd  successful_transactions
      2026-03-01        26382.0                        5
      2026-03-02        25049.0                        3
      2026-03-03        18391.0                        4
      2026-03-04        16420.0                        4
      2026-03-05        19232.0                        1
      2026-03-06        10606.0                        2

## Q5
### Query
```sql
SELECT merchant_name,
       SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
       COUNT(*) AS total_transactions,
       SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) > 0.01
ORDER BY chargeback_ratio DESC;
```
### Result Summary
merchant_name  chargeback_count  total_transactions    ratio
   Alpha Mart                 1                  11 0.090909
  Beta Stores                 1                  11 0.090909
Delta Travels                 1                   4 0.250000
     Eco Home                 1                   2 0.500000

## Q6
### Query
```sql
SELECT gateway_region AS region, AVG(risk_score) AS avg_risk_score, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY gateway_region
HAVING AVG(risk_score) > 50 AND COUNT(*) > 20;
```
### Result Summary
gateway_region  avg_risk_score  transaction_count
          APAC        65.47619                 22

## Q7
### Query
```sql
SELECT user_id, transaction_date, COUNT(*) AS issue_count
FROM cleaned_transactions
WHERE status IN ('failed', 'chargeback')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;
```
### Result Summary
user_id transaction_date  issue_count
   U008       2026-03-05            4

## Q8
### Query
```sql
SELECT merchant_name,
       SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
       COUNT(DISTINCT CASE WHEN status = 'chargeback' THEN user_id ELSE NULL END) AS unique_affected_users,
       SUM(CASE WHEN status = 'chargeback' THEN amount_usd ELSE 0 END) AS chargeback_amount_usd
FROM cleaned_transactions
GROUP BY merchant_name
ORDER BY chargeback_amount_usd DESC;
```
### Result Summary
merchant_name  chargeback_count  unique_affected_users  chargeback_amount_usd
   Alpha Mart                 1                      1                 5400.0
  Beta Stores                 1                      1                 1711.0
Delta Travels                 1                      1                 2500.0
     Eco Home                 1                      1                 6649.0
