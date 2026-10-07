# Nashville Housing Data Cleaning with SQL Server

## Project Overview

This project uses SQL Server to clean Nashville housing data and prepare it for analysis. The SQL script addresses missing property addresses, separates address components, standardizes dates and categorical values, and identifies duplicate records.

## Cleaning Steps

1. Created a date-only column named `SaleDateConverted`.
2. Filled missing property addresses using matching ParcelID records through a self-join.
3. Split property addresses into separate street address and city columns.
4. Split owner addresses into separate street address, city, and state columns.
5. Standardized `SoldAsVacant` values from Y and N to Yes and No.
6. Identified duplicate records using a CTE and `ROW_NUMBER()`.
7. Removed original address and date columns after creating separate columns, along with `TaxDistrict`.

## SQL Skills Demonstrated

- Self-joins
- NULL handling with `ISNULL()`
- Date conversion with `CONVERT()`
- Text functions: `SUBSTRING()`, `CHARINDEX()`, `REPLACE()`, and `PARSENAME()`
- Conditional logic with `CASE`
- Common table expressions (CTEs)
- Window functions with `ROW_NUMBER()`
- Table modifications with `ALTER TABLE`
- Data updates with `UPDATE`

## Files

- `Nashville Data Cleaning Project.sql` — SQL cleaning queries.
- `Nashville Housing Data for Data Cleaning.xlsx` — source dataset.

## Tools Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Microsoft Excel source file

## Script Notes

The script references `Nashville_Housing.dbo.NashvilleHousingFull`.

It records the cleaning workflow and should be reviewed and executed section by section against a working copy of the source data. It modifies data and removes columns, so it is not intended to be rerun in full against an already cleaned table.

The duplicate-checking section identifies duplicate records; the uploaded script does not include a DELETE statement to remove them.

## Acknowledgment

This project was completed while following Alex The Analyst's Nashville housing data cleaning tutorial.
