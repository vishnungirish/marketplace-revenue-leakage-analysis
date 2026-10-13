USE marketplace_revenue_analysis;

-- ==========================================
-- Data Import Script
-- Note:
-- Data imported via MySQL Terminal because
-- MySQL Workbench on macOS blocked
-- LOAD DATA LOCAL INFILE.
-- ==========================================

LOAD DATA LOCAL INFILE '/Users/vishnunarayanang/Downloads/GUVI BA/Assignment/Marketplace Revenue Leakage & Gap Analysis using SQL/Marketplace_SQL_Project/Raw_Data/products_v2.csv'
INTO TABLE raw_products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/vishnunarayanang/Downloads/GUVI BA/Assignment/Marketplace Revenue Leakage & Gap Analysis using SQL/Marketplace_SQL_Project/Raw_Data/payment_fees_v2.csv'
INTO TABLE raw_payment_fees
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/vishnunarayanang/Downloads/GUVI BA/Assignment/Marketplace Revenue Leakage & Gap Analysis using SQL/Marketplace_SQL_Project/Raw_Data/orders_v2.csv'
INTO TABLE raw_orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/vishnunarayanang/Downloads/GUVI BA/Assignment/Marketplace Revenue Leakage & Gap Analysis using SQL/Marketplace_SQL_Project/Raw_Data/discounts_v2.csv'
INTO TABLE raw_discounts
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/vishnunarayanang/Downloads/GUVI BA/Assignment/Marketplace Revenue Leakage & Gap Analysis using SQL/Marketplace_SQL_Project/Raw_Data/returns_v2.csv'
INTO TABLE raw_returns
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/vishnunarayanang/Downloads/GUVI BA/Assignment/Marketplace Revenue Leakage & Gap Analysis using SQL/Marketplace_SQL_Project/Raw_Data/logistics_cost_v2.csv'
INTO TABLE raw_logistics_cost
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;