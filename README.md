# 📊 Netflix SQL Data Analysis

## 📌 Project Overview

This project analyzes the Netflix dataset using SQL Server.
The goal is to explore content trends, understand distribution patterns, and extract meaningful insights from the data.

---

## 🛠️ Tools & Technologies

* Microsoft SQL Server
* T-SQL
* Dataset: Netflix Titles Dataset

---

## 📂 Dataset Description

The dataset contains information about Netflix content including:

* Title
* Type (Movie / TV Show)
* Director
* Cast
* Country
* Release Year
* Rating
* Duration
* Genre (listed_in)
* Description
* Date Added

---

## 📊 Key Analysis Performed

### 1️⃣ Content Distribution

* Count of Movies vs TV Shows

### 2️⃣ Ratings Analysis

* Most common rating per content type using `RANK()`

### 3️⃣ Time-Based Analysis

* Content released in a specific year
* Content added in the last 5 years

### 4️⃣ Country Analysis

* Top 5 countries producing the most content
* Handled multi-value columns using `STRING_SPLIT` and `CROSS APPLY`

### 5️⃣ Duration Analysis

* Longest movie based on duration parsing

### 6️⃣ People Analysis

* Movies featuring Salman Khan in the last 10 years
* Top 10 actors in Indian movies

### 7️⃣ Genre Analysis

* Number of content items per genre

### 8️⃣ Content Classification

* Categorized content as **Good** or **Bad** based on keywords:

  * "kill"
  * "violence"

---

## 🔍 Key SQL Concepts Used

* `GROUP BY` and Aggregations
* Window Functions (`RANK()`)
* Common Table Expressions (CTE)
* String Functions (`STRING_SPLIT`, `CHARINDEX`, `LEFT`)
* Data Cleaning (`TRIM`, `LOWER`)
* Conditional Logic (`CASE WHEN`)

---

## ⚠️ Data Challenges

* Multi-valued columns (e.g., country, cast, genres)
* Text-based fields requiring parsing (e.g., duration)
* Date conversion issues (`date_added`)

---

## 👩‍💻 Author

Salma Yasser
Aspiring Data Analyst | SQL Developer

---
