# Spreadsheet Answers

## Cleaning Steps
Standardized merchant names, normalized dates to YYYY-MM-DD, cleaned status values to captured/failed/chargeback, extracted numeric risk scores, normalized gateway regions, converted all transaction amounts to USD using exchange rates, and enriched with merchant metadata.

## Standardization Rules
- Merchant names: trimmed whitespace, collapsed duplicate spaces, and title-cased text.
- Dates: converted to ISO `YYYY-MM-DD` format.
- Status: mapped to `captured`, `failed`, or `chargeback` based on the text.
- Risk scores: extracted numeric values from strings like `score:62` and `risk-41`.
- Gateway regions: trimmed and upper-cased values to `APAC`, `EU`, or `US`.
- Amounts: converted to USD using `exchange_rates.csv` on transaction date.

## Lookup and Enrichment Logic
- Joined transactions to `merchant_master.csv` by cleaned merchant name.
- Enriched each transaction with `merchant_id`, `account_manager`, `merchant_category`, and `default_region`.
- Used merchant default region when gateway region was missing.

## Final Answers
- Total raw rows: 30
- Total cleaned rows: 30
- Invalid or missing rows handled: 10
- Top region by GMV: APAC
- Number of high value transactions: 7
- Number of high risk transactions: 9
- Top merchant by captured GMV: Beta Stores

## Formula Samples
- `amount_usd = raw_amount * usd_rate`
- `high_value_flag = 1 WHEN (region='APAC' AND amount_usd>5000) OR (region='EU' AND amount_usd>6000) OR (region='US' AND amount_usd>7000)`
- `high_risk_flag = 1 WHEN risk_score >= 70 OR status = 'chargeback'`
