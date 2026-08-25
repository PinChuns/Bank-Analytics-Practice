# Bank Analytics Project Pratice 銀行客戶交易與商業行為分析練習

## Project Overview (專案簡介)
本專案旨在透過 SQL 針對銀行客戶資料、帳戶類型及交易紀錄進行深入分析。透過資料清理、多表關聯 (JOIN)、聚合統計及視窗函數 (Window Functions)，拆解客戶消費習慣、高價值客群特徵與異常交易行為，為商業決策提供數據支持。

---

## Database Schema (資料庫架構)
專案建構於 **PostgreSQL** 環境，包含三張主要資料表：
* **`customers`**：客戶基礎背景（年齡、性別、居住城市）。
* **`accounts`**：客戶帳戶類型（支票/活存、定存/儲蓄）與帳戶餘額。
* **`transactions`**：交易明細紀錄（存款、提款、轉帳、金額及時間）。

---

## Key Analytics & Queries (分析重點與核心語法)

### 1. 客戶畫像與地域分佈
* 統計各城市的客戶總數與平均年齡。
* 計算不同性別的平均帳戶餘額。

### 2. 客戶價值與交易行為
* 使用 `LEFT JOIN` 與 `GROUP BY` 計算每位客戶的總交易次數與總消費金額。
* 找出存款餘額前 5 高的 VIP 客戶。

### 3. 高級商業分析 (Advanced Analysis)
* **視窗函數 (Window Functions)**：計算客戶歷史交易的累計金額與消費排名 (`RANK()`)。
* **條件聚合 (CASE WHEN)**：劃分客戶年齡層（如：<30 青年、30-50 中壯年、>50 高齡）並分析其主要偏好的交易模式。

---

## Tech Stack (使用工具)
* **Database**: PostgreSQL
* **Tool / IDE**: VS Code (with SQLTools Extension) / DBeaver
* **Version Control**: Git & GitHub
