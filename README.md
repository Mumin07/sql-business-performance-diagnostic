# 📊 SQL Project — Business Performance Diagnostic

## Tools Used
- Excel (Data Cleaning & Validation)
- SQL (Analysis, Aggregation, Window Functions)

---

## TL;DR — Executive Summary
- $5.0M total revenue, $1.19M total profit
- ~23.8% overall profit margin
- Profit volatility driven by cost fluctuations, not revenue alone
- West & East regions deliver strongest margins
- No customer concentration risk detected

---

## 1. Business Problem

Company leadership lacks clear, data-driven visibility into overall business performance.  
Key strategic questions remain unanswered:

- How much revenue and profit is the business actually generating?
- Is performance improving, declining, or volatile over time?
- Which regions and customer segments are truly profitable?
- Is the business overly dependent on a small number of customers?

### Business Impact of This Gap

Without clear answers:
- Decisions rely on intuition instead of data
- High-revenue but low-profit areas may receive excessive investment
- Cost volatility remains hidden
- Customer concentration risk is unknown

### Project Goal

Build a **business performance diagnostic** using SQL that enables leadership to:
- Understand financial health
- Identify volatility and risk
- Allocate resources more effectively

---

## 2. Business Objectives

This project answers the following executive-level questions:

1. What is the company’s overall revenue and profit?
2. How do revenue and profit trend over time?
3. How volatile is month-over-month performance?
4. Which regions and customer segments drive profitability?
5. Is revenue concentrated among a small group of customers?

---

## 3. Data Source

The dataset used in this project is **synthetic transactional data** designed to simulate real-world business operations and common data quality issues.

### Data Characteristics
- Transaction-level sales data
- Customer, product, region, and segment attributes
- Revenue, quantity, and unit cost fields

### Intentional Data Issues
- Invalid or zero quantities
- Missing or negative costs
- Inconsistent formatting
- Invalid customer and product IDs

### Purpose of Using Synthetic Data

The focus of this project is not the data source itself, but the analyst’s ability to:
- Identify data quality issues
- Apply defensible cleaning rules
- Build reliable SQL-based diagnostics
- Translate raw data into actionable business insights

This mirrors real analyst workflows where:
- Data originates from multiple systems
- Validation and cleaning are required before analysis
- Business logic matters more than perfect data sources

---

## 4. Data Preparation & Assumptions

### Data Cleaning (Excel)

Data cleaning was performed **before SQL analysis** to reflect real-world workflows where raw data often arrives outside databases.

#### Actions Taken
- Flagged and excluded:
  - Invalid or zero quantities
  - Missing or negative unit costs
  - Invalid product IDs
  - Invalid customer IDs
- Standardized date formats
- Ensured numeric consistency for revenue and cost fields

#### Assumptions
- Invalid records were excluded rather than imputed due to structural errors
- Less than a small percentage of records were removed, minimizing analytical bias
- All SQL analysis explicitly filters for valid records only

---

## 5. Analytical Approach

### Tool Responsibilities
- **Excel:** Rule-based validation and cleaning
- **SQL:** Aggregation, trend analysis, segmentation, and window functions

### Design Principles
- Prioritize business relevance over query complexity
- Separate logic into readable, auditable steps
- Focus on decisions, not just metrics

---

## 6. SQL Techniques Used

This project applies SQL techniques commonly used in business analytics roles:

- Aggregations (`SUM`, `GROUP BY`) for revenue, cost, and profit
- Date functions for monthly performance trends
- Window functions (`LAG`, `RANK`, cumulative `SUM OVER`) to analyze:
  - Month-over-month growth
  - Customer revenue ranking
  - Cumulative revenue contribution
- Common Table Expressions (CTEs) for readable logic
- Explicit filtering rules to exclude invalid records

---

## 7. Repository Structure

**data/**
- Cleaned transactional dataset (Excel)

**sql/**
- 01_overall_business_performance.sql
- 02_monthly_trends_and_mom.sql
- 03_regional_segment_profitability.sql
- 04_customer_concentration.sql

**README.md**

## Analysis Status

This repository currently documents the analytical design, business logic, and SQL project structure.

Individual SQL queries are implemented in the `/sql` directory and will be expanded as development progresses.









