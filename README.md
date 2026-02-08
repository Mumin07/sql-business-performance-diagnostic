# 📊 Business Performance Diagnostic Using Excel & SQL

## 📌 Project Overview

This project analyzes transactional sales data to evaluate overall business performance, profitability trends, customer contribution, and regional efficiency.

The analysis simulates real-world business analytics workflows by combining **Excel-based data cleaning** with **SQL-driven analytical diagnostics**.

This project focuses specifically on analytical diagnostics using Excel and SQL. Visualization layers will be developed in a separate BI-focused project.

---

📊 Analytical Workflow

Raw Sales Data → Excel Cleaning → SQL Analysis → Business Insights

---

## 🧠 Executive Summary

• Generated approximately **$5.0M total revenue** and **$1.19M total profit**  
• Achieved an overall **profit margin of ~23.8%**  
• Profit volatility was primarily influenced by **cost fluctuations rather than revenue instability**  
• **West and East regions** demonstrated the strongest profit margins  
• Revenue distribution across customers indicates **low concentration risk**  
• Analysis suggests opportunities to improve profitability through **cost monitoring and targeted regional investment**

---

## 🎯 Business Problem

Company leadership lacked clear, data-driven visibility into overall business performance. Critical strategic questions remained unanswered, including:

- How much revenue and profit is the company generating?
- Is financial performance improving or declining over time?
- Which regions and customer segments drive profitability?
- Is revenue overly dependent on a small number of customers?

Without these insights, business decisions risk relying on assumptions rather than data-driven evidence.

---

## 🎯 Business Objectives

This project answers the following executive-level questions:

1. What is the company’s overall financial performance?
2. How do revenue and profit trend over time?
3. How volatile is month-over-month performance?
4. Which regions and customer segments drive profitability?
5. Is revenue concentrated among a small group of customers?

---

## 📂 Dataset Description

The dataset contains synthetic transactional sales data designed to simulate real-world operational and data quality challenges.

### Dataset Features:
- Transaction-level order data
- Customer, product, region, and segment attributes
- Revenue, quantity, and cost metrics

### Simulated Data Quality Issues:
- Invalid or zero quantities
- Missing or negative cost values
- Invalid customer and product identifiers
- Formatting inconsistencies

The synthetic nature of the dataset allows focus on analytical methodology rather than data sourcing.

---

## 🧹 Data Preparation & Cleaning (Excel)

Data cleaning was performed in Excel to reflect real-world workflows where data often originates from external operational systems.

### Cleaning Steps:

✔ Removed invalid or zero quantity transactions  
✔ Filtered missing or negative unit cost values  
✔ Validated customer and product identifiers  
✔ Standardized date and categorical formatting  
✔ Created data quality validation flags  

### Cleaning Assumptions:

- Invalid records were excluded due to structural data errors  
- Removed records represented a minimal proportion of total dataset  
- All SQL analysis explicitly filters validated records  

---

## 🔍 Analytical Approach (SQL)

SQL was used to transform cleaned data into business diagnostics through structured analytical queries.

### Design Principles:

- Focus on business decision support  
- Maintain readable and auditable SQL logic  
- Separate metric computation from interpretation  
- Apply defensive filtering to ensure analytical reliability  

---

## 🛠 SQL Techniques Used

This project applies analytical SQL techniques commonly used in business intelligence and analytics roles:

- Aggregations (`SUM`, `GROUP BY`) for financial metrics  
- Date functions for monthly performance analysis  
- Window Functions:
  - `LAG()` for month-over-month growth
  - `RANK()` for performance ranking
  - `SUM() OVER()` for cumulative contribution analysis
  - `NTILE()` for customer segmentation  
- Common Table Expressions (CTEs) for modular query design  
- Data validation filtering logic  

---

## 📈 Analysis & Key Insights

### 1️⃣ Overall Business Performance

- Total Revenue: **$5.0M**
- Total Profit: **$1.19M**
- Profit Margin: **23.8%**

📌 Insight:
The business demonstrates stable profitability with a healthy margin level. However, margin stability is influenced more by cost fluctuations than revenue variation.

---

### 2️⃣ Time Trend & Performance Volatility

Monthly analysis revealed fluctuations in profitability driven primarily by cost variation rather than revenue decline.

📌 Insight:
Cost monitoring mechanisms may help stabilize margin volatility.

---

### 3️⃣ Product & Category Profitability

- High-revenue products do not always produce highest profit margins  
- Certain product categories rely heavily on discounting strategies  

📌 Insight:
Margin-focused pricing strategies could improve profitability.

---

### 4️⃣ Regional & Segment Performance

- West and East regions deliver the highest profit margins compared to other regions.

📌 Insight:
These regions show stronger pricing power or operational efficiency. Expanding customer acquisition and marketing investment in these regions could improve overall profitability.

---

### 5️⃣ Customer Contribution & Risk Analysis

Customer revenue distribution analysis indicates a diversified customer base with no significant concentration risk.

📌 Insight:
Revenue stability is supported by broad customer participation, reducing dependency on individual customers.

---

## 🧭 Strategic Business Recommendations

✔ Implement cost monitoring dashboards to detect margin erosion  
✔ Focus marketing investment on high-margin regions (West and East)  
✔ Evaluate supplier pricing and cost control strategies  
✔ Maintain diversified customer acquisition strategy to preserve revenue stability  

---

## 💻 Tools & Technologies

### Excel
- Data cleaning and validation
- Data quality auditing
- Rule-based filtering

### SQL
- Data aggregation and financial metric analysis
- Time-series trend analysis
- Customer segmentation modeling
- Profitability diagnostics

---

## 📁 Repository Structure

business-performance-diagnostic/
│
├── data/
│     └── sales_data.xlsx
│
├── sql/
│     ├── 01_overall_business_performance.sql
│     ├── 02_monthly_trends_and_mom.sql
│     ├── 03_regional_segment_profitability.sql
│     ├── 04_customer_concentration.sql
│     └── 05_product_profitability_analysis.sql
│
└── README.md


