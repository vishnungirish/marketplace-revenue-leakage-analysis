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
