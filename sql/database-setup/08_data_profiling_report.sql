/**************************************************************************
PROJECT:
Marketplace Revenue Leakage & Gap Analysis using SQL

FILE:
08_data_profiling_report.sql

PURPOSE:
This report documents all data quality issues identified during the
profiling phase before any cleaning or transformation was performed.

Author:
Vishnu Narayanan Girishbabu

**************************************************************************/

/**************************************************************************
PROJECT OVERVIEW

This project analyses an e-commerce marketplace dataset to identify
potential revenue leakage caused by returns, discounts, payment gateway
fees, logistics costs, pricing anomalies, and operational inefficiencies.

Before performing any ETL activities, a comprehensive data profiling
exercise was conducted to assess the quality of the raw data.

The findings documented in this report form the basis for the data
cleaning and transformation strategy implemented in the ETL phase.

**************************************************************************/

/**************************************************************************
DATASET SUMMARY

Table                     Records
---------------------------------
raw_products               1,800
raw_orders                22,000
raw_discounts              9,000
raw_returns                4,000
raw_logistics_cost        13,000
raw_payment_fees               6

Total Records Analysed: 49,806

**************************************************************************/

/**************************************************************************
DATA PROFILING SUMMARY
***************************************************************************

Raw Tables Analysed

1. raw_products
2. raw_orders
3. raw_discounts
4. raw_returns
5. raw_logistics_cost
6. raw_payment_fees

**************************************************************************/

/**************************************************************************
TABLE: raw_products
Records: 1,800

Findings

✔ No duplicate Product IDs
✔ No missing Product IDs

Issues Identified

- 257 missing Categories
- 341 missing Brands
- 60 missing Weight values
- 72 products have negative Cost Price
- 297 products have Cost Price greater than MRP

No invalid Launch Dates detected.
No invalid Weight values detected.

Recommended ETL Actions

• Handle missing Category and Brand values.
• Decide treatment for missing Weight.
• Remove or correct negative Cost Prices.
• Investigate products where Cost Price exceeds MRP.

**************************************************************************/

/**************************************************************************
TABLE: raw_orders
Records: 22,000

Findings

✔ No duplicate Order IDs
✔ No missing Order IDs
✔ No invalid Order Dates
✔ No negative Selling Prices

Issues Identified

- 4,438 missing Order Status values
- 5,502 missing Order Channel values
- 488 records contain invalid Quantity (<=0)
- Payment Method contains invalid value:
      INVALID

Recommended ETL Actions

• Replace or classify missing Status values.
• Handle missing Sales Channel values.
• Remove or correct invalid Quantities.
• Resolve invalid Payment Method before fee calculation.

**************************************************************************/

/**************************************************************************
TABLE: raw_discounts
Records: 9,000

Findings

✔ No duplicate Discount IDs
✔ No negative Discount Amounts

Issues Identified

- 2,298 missing Discount Types
- 1,837 missing Coupon Codes
- Stackable flag contains formatting characters (\r)

Recommended ETL Actions

• Standardize Stackable flag.
• Investigate missing Discount Types.
• Validate missing Coupon Codes according to Discount Type.

**************************************************************************/

/**************************************************************************
TABLE: raw_returns
Records: 4,000

Findings

✔ No duplicate Return IDs
✔ No invalid Return Dates

Issues Identified

- 699 missing Return Reasons
- 1,016 missing Refund Mode
- 1,011 missing Refund Status
- Invalid Return Flag value:
      X
- 242 returned items have no Return Reason
- Customer Fault Flag contains formatting characters (\r)

Recommended ETL Actions

• Standardize Return Flag.
• Clean Customer Fault Flag.
• Validate Refund information.
• Populate or investigate missing Return Reasons.

**************************************************************************/

/**************************************************************************
TABLE: raw_logistics_cost
Records: 13,000

Findings

✔ No duplicate Logistics IDs

Issues Identified

- 722 missing Delivery Days
- 650 negative Shipping Costs
- 1 missing Delivery Status
- Delivery Status contains formatting characters (\r)

Recommended ETL Actions

• Correct negative Shipping Costs.
• Investigate missing Delivery Days.
• Clean Delivery Status values.

**************************************************************************/

/**************************************************************************
TABLE: raw_payment_fees
Records: 6

Findings

✔ No duplicate Payment Methods
✔ No negative Fee Percentages

Issues Identified

- 1 missing Settlement Day

Cross-table Issue

Orders contain Payment Method:

INVALID

This value does not exist in the Payment Fee lookup table.

Recommended ETL Actions

• Resolve missing Settlement Day.
• Correct invalid Payment Methods before fee calculations.

**************************************************************************/

/**************************************************************************
OVERALL ASSESSMENT

The raw dataset is suitable for analysis but contains intentional data
quality issues that must be resolved before loading into the normalized
database.

The most common issues identified include:

• Missing attribute values
• Invalid numeric values
• Invalid categorical values
• Formatting inconsistencies
• Referential integrity issues
• Business rule violations

No duplicate business identifiers were detected across any of the six
raw tables, indicating that entity uniqueness has been preserved.

**************************************************************************/

/**************************************************************************
ETL OBJECTIVES

The ETL process aims to:

• Improve overall data quality
• Standardize data formats
• Remove invalid values
• Enforce business rules
• Convert data into appropriate data types
• Load cleaned data into the normalized schema
• Enable accurate analytical reporting

**************************************************************************/

/**************************************************************************
ETL Plan

The ETL process will perform the following tasks:

1. Clean formatting issues
2. Remove carriage-return characters
3. Convert VARCHAR columns to appropriate data types
4. Handle missing values
5. Correct invalid categorical values
6. Apply business rules
7. Load cleaned data into normalized tables
8. Enforce Primary Keys
9. Enforce Foreign Keys
10. Perform Revenue Leakage Analysis

**************************************************************************/

/**************************************************************************
CONCLUSION

The profiling phase identified several data quality issues that would
impact downstream analytical results if left unresolved.

The next phase of the project focuses on transforming and cleaning the
raw data before loading it into the normalized relational database.

Once the ETL process is completed, business analysis and revenue leakage
assessment can be performed on a high-quality dataset.

END OF DATA PROFILING REPORT

**************************************************************************/