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
