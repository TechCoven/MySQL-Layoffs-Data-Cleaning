
# MySQL Global Layoffs Data Cleaning & Standardization

A MySQL-based data cleaning and standardization project that transforms raw global layoffs data into a clean, consistent, and analysis-ready dataset.

## Project Overview

This project focuses on cleaning, standardizing, and preparing a global layoffs dataset (2020–2023) using MySQL. The raw dataset contained duplicates, inconsistent formatting, null values, and incorrect data types. The goal was to transform the data into a clean, analysis-ready table suitable for further exploration, visualization, or reporting.

The entire workflow was executed using SQL only, following data engineering best practices such as staging tables, window functions, and controlled transformations.
## Tools & Technologies

Database: MySQL

Techniques Used:

Staging tables

Window functions (ROW_NUMBER())

Common Table Expressions (CTEs)

Data standardization

NULL handling

Data type conversion
## Dataset Description

The dataset contains records of layoffs across companies globally, covering:

Company name

Location

Industry

Total laid-off employees

Percentage laid off

Date of layoff

Company stage

Country

Funds raised (in millions)

Time period: 2020 – 2023
## Data Cleaning Workflow

1️⃣ Create a Staging Table

To preserve the raw dataset, a staging table was created and used for all transformations.

CREATE TABLE layoff_staging
LIKE layoffs;

2️⃣ Identify and Remove Duplicates

Since the dataset had no primary key, duplicates were identified using the ROW_NUMBER() window function.


A second staging table was created to store row numbers, and duplicate rows were deleted.


3️⃣ Standardize Text Data

Several columns contained inconsistent formatting:

Company names: Extra spaces removed using TRIM()

Industry: Standardized values (e.g., Crypto, CryptoCurrency → crypto)

Country: Removed trailing punctuation (e.g., United States. → United States)


4️⃣ Date Formatting & Data Type Conversion

Dates were originally stored as text and converted into proper DATE format using the - SET date = STR_TO_DATE


5️⃣ Handle NULL and Blank Values

Rows where both total_laid_off and percentage_laid_off were NULL were removed.

Blank industry values were converted to NULL.

Missing industries were populated using self-joins based on company name.


6️⃣ Final Cleanup

Temporary helper columns used for deduplication were removed.

## ✅ Final Output

The final cleaned dataset:

Contains no duplicate records

Uses consistent naming and formatting conventions

Has valid date data types

Handles NULL values appropriately

Is suitable for exploratory analysis, dashboards, and reporting
## Author

- Victor Ovie Data • Systems • Analytics https://github.com/TechCoven

