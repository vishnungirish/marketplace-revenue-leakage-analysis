# Marketplace Revenue Leakage & Profitability Analysis

## Project Overview

This project analyses the profitability of an e-commerce marketplace using SQL to identify where revenue and profit are being lost across the business.

The analysis investigates four major sources of potential leakage: **discounts, product returns, logistics costs, and payment processing fees**. It also examines category and product profitability, customer-level risk, and the relationship between sales revenue and actual profit.

The project follows an end-to-end SQL workflow, including database creation, raw data profiling, data transformation, relational modelling, and business analysis.

### Business Objective

The objective is to move beyond topline sales and answer a more important business question:

> **Where is the marketplace losing revenue and profit, what is driving those losses, and where should management focus its attention?**

## Tools & Skills Demonstrated

- **MySQL** — database creation, relational modelling, data cleaning, transformation and analysis
- **SQL** — joins, aggregations, CTEs, conditional logic, subqueries and analytical queries
- **Data Profiling** — validation of raw data, missing values and data-quality issues
- **Data Transformation** — preparation and loading of raw marketplace data into structured relational tables
- **Business Analysis** — profitability analysis, revenue leakage identification and root-cause investigation
- **Data Modelling** — relational database design using primary and foreign key relationships

## Dataset & Data Model

The analysis uses six interconnected datasets representing key areas of marketplace operations:

- **Orders** — transaction-level sales and order information
- **Products** — product, category and cost information
- **Discounts** — discounts applied to marketplace transactions
- **Returns** — returned orders and return reasons
- **Logistics Costs** — fulfilment and delivery-related costs
- **Payment Fees** — payment-method processing charges

The source data was provided as part of the project and was imported, profiled, transformed and structured in MySQL before analysis.

### Entity Relationship Diagram

The relational model connects the marketplace datasets through common identifiers, allowing sales, product, discount, return, logistics and payment information to be analysed together.

![Marketplace Revenue Leakage ER Diagram](images/ER%20Diagram.png)

## Business Questions

The analysis was structured around a series of business questions designed to diagnose marketplace profitability and identify potential sources of revenue leakage:

1. What are the marketplace's total sales revenue, cost and profit?
2. Which product categories generate the strongest and weakest profitability?
3. Which products are generating losses?
4. How extensively are discounts being used across marketplace orders?
5. Which payment methods account for the largest share of orders and sales?
6. How does profitability differ between discounted and non-discounted orders?
7. What is the financial impact of product returns?
8. Which return reasons contribute most to revenue loss?
9. Which orders experience disproportionately high logistics costs?
10. How much profit is being absorbed by payment processing fees?
11. How is total revenue leakage distributed across discounts, returns, logistics and payment fees?
12. Which products contribute the most and least net profit?
13. Which categories show the greatest variation in profit margins?
14. Which customers exhibit unusually high return behaviour?
15. What does the consolidated profitability picture reveal about the marketplace?

## Analytical Approach

The project followed a structured SQL workflow:

**1. Database Design**  
Designed a relational marketplace database connecting orders, products, discounts, returns, logistics costs and payment fees.

**2. Data Staging & Profiling**  
Loaded the source data into staging tables and profiled the datasets to identify missing values, inconsistencies and potential data-quality issues.

**3. Data Transformation**  
Prepared and transformed the raw data into structured, analysis-ready tables while maintaining relationships between marketplace entities.

**4. SQL Business Analysis**  
Developed a series of analytical queries using joins, aggregations, conditional logic, subqueries, CTEs and window functions to investigate profitability and revenue leakage.

**5. Business Interpretation**  
Translated query outputs into business findings relating to pricing, discounts, returns, fulfilment costs, payment fees, product performance and customer behaviour.

### Analysis Workflow

`Raw Data → Data Profiling → Transformation → Relational Database → SQL Analysis → Revenue Leakage Diagnosis → Business Recommendations`

## Key Business Findings

### 1. Strong Revenue Does Not Eliminate Profit Leakage

The marketplace generated **₹62.83M in total sales revenue** against **₹30.32M in product costs**, resulting in **₹32.51M gross profit** before considering several additional sources of revenue leakage.

This demonstrates why topline revenue alone is insufficient for evaluating marketplace performance.

| Metric | Value |
|---|---:|
| Total Sales Revenue | ₹62.83M |
| Total Product Cost | ₹30.32M |
| Gross Profit | ₹32.51M |

### 2. Electronics Leads Marketplace Profitability

Electronics was the strongest-performing category, generating approximately **₹12.00M in sales** and **₹6.27M in profit**.

Fashion followed with **₹11.50M in sales** and **₹5.78M in profit**.

Despite healthy category-level profitability, the product-level analysis identified **71 loss-making product records**, showing that strong aggregate category performance can conceal underperforming products.

### 3. Discounting Is Significant — But Not Automatically Unprofitable

A total of **7,417 orders** used discounts, representing approximately **₹5.73M in total discount value**.

However, discounted orders generated an average profit of **₹1,492.71 per order**, compared with **₹1,469.80 for non-discounted orders**.

This suggests that discounting should not automatically be treated as a profitability problem. Discount effectiveness should instead be evaluated at product, category and customer level.

### 4. Returns Create a Material Financial Impact

The analysis identified **1,290 returned orders**, associated with approximately:

- **₹3.69M in revenue lost**
- **₹1.93M in profit lost**

Return management therefore represents a significant opportunity for protecting marketplace profitability.

The largest recorded return-reason group was **Unknown**, accounting for **242 returns and approximately ₹714.7K in lost revenue**. This indicates a data-quality and process-control issue in addition to the financial impact of returns.

### 5. Payment Method Choice Affects Net Profit

Payment processing fees vary materially across payment methods.

| Payment Method | Fee Rate | Payment Fees |
|---|---:|---:|
| COD | 3.5% | ₹437.3K |
| Card | 2.1% | ₹257.3K |
| Wallet | 2.0% | ₹251.7K |
| UPI | 1.2% | ₹152.1K |

Among the valid payment methods analysed, **COD creates the highest payment-fee burden**, while **UPI has the lowest fee rate**.

### 6. Multiple Leakage Sources Accumulate

The revenue-leakage analysis identified substantial financial exposure across several operational areas:

| Leakage Component | Estimated Impact |
|---|---:|
| Discounts | ₹4.57M |
| Returns | ₹2.95M |
| Payment Fees | ₹1.10M |
| Logistics | ₹0.95M |

Rather than being driven by a single issue, marketplace leakage is distributed across **commercial, customer-return, fulfilment and payment activities**.

> **Key takeaway:** High sales performance can coexist with significant underlying leakage. Profitability improvement therefore requires targeted action across discounts, returns, logistics and payment processing rather than focusing solely on increasing revenue.
