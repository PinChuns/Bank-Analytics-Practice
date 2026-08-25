# 🏦 Bank Customer & Transaction Analytics (銀行客戶與交易行為分析專案)

## 📌 專案背景與商業目的 (Business Context)
本專案建立一個模擬的銀行關聯式資料庫 (PostgreSQL)，包含 `customers` (客戶表)、`accounts` (帳戶表) 與 `transactions` (交易紀錄表) 三張核心資料表。

針對客戶基本資料與交易紀錄進行商業數據分析，目的在於透過 SQL 查詢解答核心營運問題，包括 **VIP 高價值客戶識別、沈睡高資產客戶喚醒、客群消費行為分群與營運月成長率 (MoM)**，為銀行行銷與風險管理團隊提供數據支持。

---

## 🛠️ 使用技術 (Tech Stack)
- **Database**: PostgreSQL 25
- **GUI Tool**: DBeaver
- **SQL Skills**: 
  - **DDL / DML**: `CREATE TABLE`, `FOREIGN KEY`, `INSERT INTO`
  - **DQL / Advanced SQL**: `JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, `CASE WHEN`, `SUM(CASE WHEN...)`, `Window Functions (LAG)`, `CTE (WITH ... AS)`

---

## 📊 核心商業問題與 SQL 解答 (Key Analysis & Insights)

本專案解答以下 10 大銀行營運核心問題：

1. **分行區域客群分佈統計**：計算每個城市的客戶數量 (`COUNT`, `GROUP BY`)
2. **客群年齡層財力分析**：劃分青年、壯年與熟齡層並計算平均存款 (`CASE WHEN`, `AVG`)
3. **產品線存款總額評估**：比較 Checking (活存) 與 Savings (定存) 帳戶餘額總和 (`SUM`)
4. **業務營運月成長趨勢**：統計每月交易總金額與筆數 (`TO_CHAR`, `SUM`)
5. **活躍用戶 MAU 識別**：篩選交易次數 >= 3 次的高頻客戶 (`COUNT`, `HAVING`)
6. **資負結構與流動性分析**：計算存款與提款金額比例 (`SUM(CASE WHEN...)`, `NULLIF`)
7. **高端 VIP 名單產生器**：找出累積交易金額最高的 Top 10 客戶 (`ORDER BY ... DESC`, `LIMIT`)
8. **沈睡高資產客戶喚醒**：找出資產 > 5萬 但交易次數 <= 2 次的客戶 (`LEFT JOIN`, `HAVING`)
9. **區域消費力道分析**：比較不同城市的平均單筆交易金額 (`AVG`, `GROUP BY`)
10. **高潛力客戶挖掘 (MoM)**：計算客戶近 3 個月交易金額成長率 (`Window Function LAG()`, `CTE`)

---

## 🚀 專案腳本說明
* **`bank_analytics_project.sql`**：包含完整建表語法、模擬數據填入以及 10 大商業分析查詢解答。
