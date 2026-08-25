# Bank Analytics Practice

A SQL-based data analytics project analyzing bank customer demographics, account types, and transaction behaviors to derive actionable business insights.

---

## Project Overview
This project aims to perform end-to-end data analysis on banking datasets using SQL. By applying data cleaning, multi-table joins (`JOIN`), aggregate statistics, and advanced window functions (`Window Functions`), the project explores customer spending habits, high-value customer characteristics, and transaction patterns to support data-driven business decisions.

---

## Key Business Insights & Recommendations
* **Top Revenue Segment**: Middle-aged customers (30-50) hold over 60% of total deposit balances, presenting prime targets for wealth management services.
* **Retention Alert**: Low-frequency transaction users exhibit higher churn risk; recommended targeted promotional campaigns for inactive accounts.

---

## Database Schema
The database is built on **PostgreSQL** and consists of three core relational tables:
* **`customers`**: Customer demographic data (Age, Gender, City).
* **`accounts`**: Account details (Checking/Savings types, Current Balance).
* **`transactions`**: Transaction records (Deposit, Withdrawal, Transfer, Amount, Timestamp).

---

## Key Analytics & Technical Highlights

### 1. Customer Demographics & Regional Distribution
* Analyzed total customer count and average age per city to identify primary target markets.
* Calculated average account balances segmented by gender.

### 2. Customer Lifetime Value & Behavioral Patterns
* Leveraged `LEFT JOIN` and `GROUP BY` to compute total transaction frequency and overall spending per customer.
* Identified the Top 5 VIP customers based on total savings balance.

### 3. Advanced Business Analytics
* **Window Functions**: Utilized `SUM() OVER()` and `RANK()` to track cumulative transaction history and evaluate spending rank per account.
* **Conditional Aggregation (`CASE WHEN`)**: Segmented customers into distinct age cohorts (<30 Young Adults, 30-50 Middle-aged, >50 Seniors) to reveal channel/transaction type preferences.

---

## 🛠️ Tech Stack
* **Database**: PostgreSQL
* **Tool / IDE**: VS Code (with SQLTools Extension) / DBeaver
* **Version Control**: Git & GitHub
