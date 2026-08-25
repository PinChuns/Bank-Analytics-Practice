-- ============================================================
-- Bank Analytics Project Pratice
-- ============================================================

-- 1. Delete Old Table
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

-- 2. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

-- 3. Accounts Table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    account_type VARCHAR(20), -- Checking (支票/活存), Savings (定存/儲蓄)
    balance DECIMAL(12, 2)    -- Balance (帳戶餘額)
);

-- 4. Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    transaction_date DATE,
    transaction_type VARCHAR(20), -- Deposit (存款), Withdrawal (提款), Transfer (轉帳)
    amount DECIMAL(12, 2)
);

-- ============================================================
-- 5. Insert Sample Data
-- ============================================================

INSERT INTO customers (customer_id, customer_name, age, gender, city) VALUES
(1, 'Alice', 25, 'Female', 'Taipei'),
(2, 'Bob', 42, 'Male', 'New Taipei'),
(3, 'Charlie', 58, 'Male', 'Taipei'),
(4, 'Diana', 31, 'Female', 'Taichung'),
(5, 'Ethan', 65, 'Male', 'Kaohsiung'),
(6, 'Fiona', 22, 'Female', 'Tainan');

INSERT INTO accounts (account_id, customer_id, account_type, balance) VALUES
(101, 1, 'Checking', 5000.00),
(102, 1, 'Savings', 12000.00),
(103, 2, 'Checking', 80000.00), -- 高餘額但交易少
(104, 3, 'Savings', 250000.00),
(105, 4, 'Checking', 15000.00),
(106, 5, 'Savings', 500000.00), -- 高餘額但交易少
(107, 6, 'Checking', 1200.00);

INSERT INTO transactions (transaction_id, account_id, transaction_date, transaction_type, amount) VALUES
-- 2026年5月交易
(1, 101, '2026-05-10', 'Deposit', 2000.00),
(2, 101, '2026-05-15', 'Withdrawal', 500.00),
(3, 104, '2026-05-20', 'Deposit', 50000.00),
(4, 105, '2026-05-22', 'Withdrawal', 3000.00),

-- 2026年6月交易
(5, 101, '2026-06-05', 'Deposit', 3000.00),
(6, 102, '2026-06-12', 'Deposit', 10000.00),
(7, 104, '2026-06-18', 'Withdrawal', 12000.00),
(8, 105, '2026-06-25', 'Deposit', 8000.00),
(9, 107, '2026-06-28', 'Deposit', 1000.00),

-- 2026年7月交易
(10, 101, '2026-07-01', 'Withdrawal', 1500.00),
(11, 101, '2026-07-08', 'Deposit', 5000.00),
(12, 104, '2026-07-15', 'Deposit', 80000.00),
(13, 105, '2026-07-20', 'Withdrawal', 2000.00),
(14, 107, '2026-07-22', 'Withdrawal', 500.00),

-- 2026年8月交易
(15, 101, '2026-08-02', 'Deposit', 8000.00),
(16, 101, '2026-08-10', 'Withdrawal', 2000.00),
(17, 104, '2026-08-15', 'Deposit', 100000.00),
(18, 105, '2026-08-18', 'Deposit', 15000.00),
(19, 107, '2026-08-20', 'Deposit', 2000.00),
(20, 103, '2026-08-22', 'Withdrawal', 1000.00);


-- ============================================================
-- 6. 10 Business Analytics Queries
-- ============================================================

-- Q1: 每個城市有多少客戶？ (分行區域客群分佈)
SELECT 
    city, 
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- Q2: 各年齡層平均存款多少？ (客群年齡層財力分析)
SELECT 
    CASE 
        WHEN c.age < 30 THEN '青年 (<30)'
        WHEN c.age BETWEEN 30 AND 50 THEN '壯年 (30-50)'
        ELSE '熟齡 (>50)'
    END AS age_group,
    ROUND(AVG(a.balance), 2) AS avg_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY age_group
ORDER BY avg_balance DESC;


-- Q3: 哪種帳戶餘額最高？ (產品線存款總額評估)
SELECT 
    account_type,
    SUM(balance) AS total_balance,
    ROUND(AVG(balance), 2) AS avg_balance
FROM accounts
GROUP BY account_type;


-- Q4: 每月交易總金額是多少？ (業務營運月成長趨勢)
SELECT 
    TO_CHAR(transaction_date, 'YYYY-MM') AS month,
    SUM(amount) AS total_transaction_amount,
    COUNT(transaction_id) AS transaction_count
FROM transactions
GROUP BY month
ORDER BY month;


-- Q5: 哪些客戶交易最頻繁？ (活躍用戶 MAU/DAU 識別)
SELECT 
    c.customer_name,
    COUNT(t.transaction_id) AS total_transactions
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_name
HAVING COUNT(t.transaction_id) >= 3
ORDER BY total_transactions DESC;


-- Q6: 存款與提款金額比例？ (資負結構與流動性分析)
SELECT 
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END) AS total_withdrawals,
    ROUND(
        SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END), 0), 2
    ) AS deposit_to_withdrawal_ratio
FROM transactions;


-- Q7: 找出交易金額最高的 Top 10 客戶 (高端 VIP 名單)
SELECT 
    c.customer_name,
    SUM(t.amount) AS total_amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_name
ORDER BY total_amount DESC
LIMIT 10;


-- Q8: 找出「高餘額 (總資產>5萬) 但低交易 (交易筆數<=2)」的客戶 (沉睡高資產客戶喚醒)
SELECT 
    c.customer_name,
    SUM(a.balance) AS total_balance,
    COUNT(t.transaction_id) AS transaction_count
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_name
HAVING SUM(a.balance) > 50000 AND COUNT(t.transaction_id) <= 2;


-- Q9: 比較不同城市/客群的平均單筆交易金額 (消費力道差異分析)
SELECT 
    c.city,
    ROUND(AVG(t.amount), 2) AS avg_transaction_amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.city
ORDER BY avg_transaction_amount DESC;


-- Q10: 找出最近 3 個月交易金額成長最快的客戶 (高潛力用戶挖掘 - 使用視窗函數)
WITH monthly_customer_spend AS (
    SELECT 
        c.customer_name,
        TO_CHAR(t.transaction_date, 'YYYY-MM') AS month,
        SUM(t.amount) AS monthly_amount
    FROM customers c
    JOIN accounts a ON c.customer_id = a.customer_id
    JOIN transactions t ON a.account_id = t.account_id
    WHERE t.transaction_date >= '2026-06-01'
    GROUP BY c.customer_name, month
)
SELECT 
    customer_name,
    month,
    monthly_amount,
    LAG(monthly_amount) OVER (PARTITION BY customer_name ORDER BY month) AS previous_month_amount,
    ROUND(
        (monthly_amount - LAG(monthly_amount) OVER (PARTITION BY customer_name ORDER BY month)) / 
        LAG(monthly_amount) OVER (PARTITION BY customer_name ORDER BY month) * 100, 2
    ) AS growth_rate_percentage
FROM monthly_customer_spend
ORDER BY customer_name, month;