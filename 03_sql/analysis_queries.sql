-- Q1
SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status
ORDER BY transaction_count DESC;

-- Q2
SELECT merchant_name, SUM(amount_usd) AS captured_gmv_usd
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY captured_gmv_usd DESC;

-- Q3
SELECT merchant_name, SUM(amount_usd) AS captured_gmv_usd
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY captured_gmv_usd DESC
LIMIT 10;

-- Q4
SELECT transaction_date, SUM(amount_usd) AS total_gmv_usd, SUM(CASE WHEN status = 'captured' THEN 1 ELSE 0 END) AS successful_transactions
FROM cleaned_transactions
GROUP BY transaction_date
ORDER BY transaction_date;

-- Q5
SELECT merchant_name,
       SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
       COUNT(*) AS total_transactions,
       SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) > 0.01
ORDER BY chargeback_ratio DESC;

-- Q6
SELECT gateway_region AS region, AVG(risk_score) AS avg_risk_score, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY gateway_region
HAVING AVG(risk_score) > 50 AND COUNT(*) > 20;

-- Q7
SELECT user_id, transaction_date, COUNT(*) AS issue_count
FROM cleaned_transactions
WHERE status IN ('failed', 'chargeback')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;

-- Q8
SELECT merchant_name,
       SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
       COUNT(DISTINCT CASE WHEN status = 'chargeback' THEN user_id ELSE NULL END) AS unique_affected_users,
       SUM(CASE WHEN status = 'chargeback' THEN amount_usd ELSE 0 END) AS chargeback_amount_usd
FROM cleaned_transactions
GROUP BY merchant_name
ORDER BY chargeback_amount_usd DESC;
