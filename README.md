# QuickPay FinTech Operations Case Study

Student Name: Dhruv Jain
Student ID: bitsom_ftai_2601160
Public GitHub Repository Link: https://github.com/dhruvjaindj26-afk/FinTech-Operations

## Overview
This repository contains the completed QuickPay FinTech Operations case study. The work includes spreadsheet cleaning, SQL business analysis, Python reconciliation and JSON normalization, plus a dashboard design using processed outputs.

## Run Instructions
1. Open `02_spreadsheet/spreadsheet_workbook.xlsx` for the spreadsheet cleaning logic and output samples.
2. Open `03_sql/analysis_queries.sql` and `03_sql/sql_answers.md` for the SQL queries and business answer summaries.
3. Open `04_python/fintech_pipeline.ipynb` to run the Python reconciliation workflow and JSON normalization steps.
4. View processed output files in `01_data/processed/`.
5. The dashboard public link should be placed in `05_visualization/dashboard_link.txt` after publishing the Looker Studio report.

## Files and Logic Summary

### Spreadsheet Section
- Input data: `01_data/raw/transactions_raw.csv`, `01_data/raw/merchant_master.csv`, `01_data/raw/exchange_rates.csv`
- Cleaning logic: standardized merchant names, dates, status values, risk scores, and gateway regions.
- Amounts were converted to USD using exchange rates on `transaction_date`.
- Enrichment: transactions were joined to merchant master data for merchant metadata and default region.
- Flags created: `high_value_flag` and `high_risk_flag` using assignment rules.
- Output files: `01_data/processed/cleaned_transactions.csv`, `01_data/processed/merchant_risk_summary.csv`.

### SQL Section
- Input assumptions: `cleaned_transactions.csv` is the canonical cleaned transaction table.
- Queries cover transaction counts by status, captured GMV by merchant, top merchants, daily GMV and successful counts, chargeback ratios, region risk analysis, user issue detection, and chargeback impact by merchant.
- Output files: `03_sql/analysis_queries.sql`, `03_sql/sql_answers.md`.

### Python Section
- Input data: `01_data/raw/ledger.csv`, `01_data/raw/gateway.csv`, `01_data/raw/api_response_sample.json`.
- Reconciliation logic: load and validate data, identify missing records in gateway/ledger, find amount mismatches, find status mismatches, and build a reconciliation report.
- JSON normalization: flatten nested API batches and settlements into tabular CSV format.
- Output files: `01_data/processed/missing_in_gateway.csv`, `01_data/processed/missing_in_ledger.csv`, `01_data/processed/amount_mismatches.csv`, `01_data/processed/status_mismatches.csv`, `01_data/processed/reconciliation_report.csv`, `01_data/processed/api_normalized.csv`, `04_python/summary_metrics.json`.

### Dashboard Section
- Use processed outputs to create a Looker Studio dashboard.
- Required charts: headline KPIs, daily trend, payment method breakdown, region or merchant breakdown, detailed table, and at least one filter.
- Dashboard link placeholder file: `05_visualization/dashboard_link.txt`.

## Outputs
All processed output files are stored under `01_data/processed/`. Example outputs include cleaned transactions, summary breakdowns, and reconciliation findings.

## Tools Used
- Python 3.12
- pandas
- openpyxl
- Jupyter Notebook
- Looker Studio (dashboard)

## Submission Rules
- Submit one public GitHub repository link only.
- All required files are present in the `main` branch.
- Do not rename files or folders.
- Do not change the folder structure.
- Do not remove any required file.
- Do not submit zipped folders.
- Do not submit only notebook links or drive links.

