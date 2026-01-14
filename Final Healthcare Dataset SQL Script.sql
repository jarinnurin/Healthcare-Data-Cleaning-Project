SELECT *
FROM healthcare_dataset;

-- 1. Remove duplicates
-- 2. Standardize data
-- 3. Null values or blank values

-- Creating a staging database 
CREATE TABLE healthcare_dataset_staging
LIKE healthcare_dataset;

SELECT *
FROM healthcare_dataset_staging;

INSERT healthcare_dataset_staging
SELECT * 
FROM healthcare_dataset;

-- Checking for exact duplicate rows 
SELECT
    Name, Age, Gender, `Blood Type`, `Medical Condition`,
    `Date of Admission`, Doctor, Hospital, `Insurance Provider`,
    `Billing Amount`, `Room Number`, `Admission Type`,
    `Discharge Date`, Medication, `Test Results`,
    COUNT(*) AS duplicate_count
FROM healthcare_dataset_staging
GROUP BY
    Name, Age, Gender, `Blood Type`, `Medical Condition`,
    `Date of Admission`, Doctor, Hospital, `Insurance Provider`,
    `Billing Amount`, `Room Number`, `Admission Type`,
    `Discharge Date`, Medication, `Test Results`
HAVING COUNT(*) > 1;
-- No exact duplicate rows found

-- Checking for duplicates based on business logic (same patient with same doctor and hospital)
SELECT
    Name,
    Doctor,
    Hospital,
    COUNT(*) AS duplicate_count
FROM healthcare_dataset_staging
GROUP BY Name, Doctor, Hospital
HAVING COUNT(*) > 1;
-- No duplicates found 

-- Standardizing the data
-- Checking for Inconsistancies
SELECT DISTINCT Gender
FROM healthcare_dataset_staging;

SELECT DISTINCT `Blood Type`
FROM healthcare_dataset_staging;

SELECT DISTINCT `Medical Condition`
FROM healthcare_dataset_staging;

SELECT DISTINCT `Insurance Provider`
FROM healthcare_dataset_staging;

SELECT DISTINCT `Admission Type`
FROM healthcare_dataset_staging;

SELECT DISTINCT Medication
FROM healthcare_dataset_staging;

SELECT DISTINCT `Test Results`
FROM healthcare_dataset_staging;

SELECT DISTINCT Name
FROM healthcare_dataset_staging;
-- Names with prefixes and periods found
-- Standardizing names
SELECT DISTINCT Name, TRIM(TRAILING '.' FROM Name)
FROM healthcare_dataset_staging
ORDER BY 1;

UPDATE healthcare_dataset_staging
SET Name = TRIM(TRAILING '.' FROM Name)
WHERE Name LIKE '%.';
-- Removed names with periods
SELECT
    Name AS original_name,
    REGEXP_REPLACE(
        Name,
        '^(Mr|Mrs|Ms|Miss|Dr|Prof|Sir|Madam)\\.\\s+',
        ''
    ) AS cleaned_name
FROM healthcare_dataset_staging
WHERE Name REGEXP '^(Mr|Mrs|Ms|Miss|Dr|Prof|Sir|Madam)\\.\\s+';

UPDATE healthcare_dataset_staging
SET Name = REGEXP_REPLACE(
    Name,
    '^(Mr|Mrs|Ms|Miss|Dr|Prof|Sir|Madam)\\.\\s+',
    ''
)
WHERE Name REGEXP '^(Mr|Mrs|Ms|Miss|Dr|Prof|Sir|Madam)\\.\\s+';

-- Removed all prefixes
-- Changing all dates text columns to dates
-- First changing Date of Admission
SELECT `Date of Admission`,
str_to_date(`Date of Admission`, '%m/%d/%Y') AS converted_date_of_admission
FROM healthcare_dataset_staging;

UPDATE healthcare_dataset_staging
SET `Date of Admission` = str_to_date(`Date of Admission`, '%m/%d/%Y');

SELECT `Date of Admission`
FROM healthcare_dataset_staging;

ALTER TABLE healthcare_dataset_staging
MODIFY COLUMN `Date of Admission` DATE;

-- Now changing Discharge Date
SELECT `Discharge Date`,
str_to_date(`Discharge Date`, '%m/%d/%Y') AS converted_discharge_date
FROM healthcare_dataset_staging;

UPDATE healthcare_dataset_staging
SET `Discharge Date` = str_to_date(`Discharge Date`, '%m/%d/%Y');

SELECT `Discharge Date`
FROM healthcare_dataset_staging;

ALTER TABLE healthcare_dataset_staging
MODIFY COLUMN `Discharge Date` DATE;

-- Formatting Billing Amount column
SELECT
    `Billing Amount`,
    ROUND(`Billing Amount`, 2) AS rounded_amount
FROM healthcare_dataset_staging
LIMIT 10;

UPDATE healthcare_dataset_staging
SET `Billing Amount` = ROUND(`Billing Amount`, 2);

ALTER TABLE healthcare_dataset_staging
MODIFY `Billing Amount` DECIMAL(10,2);

-- Checking for NULL Values or BLANK Values

SELECT Name
FROM healthcare_dataset_staging
WHERE Name IS NULL
OR Name = '';

SELECT Age
FROM healthcare_dataset_staging
WHERE Age IS NULL
OR Age = '';

SELECT Gender
FROM healthcare_dataset_staging
WHERE Gender IS NULL
OR Gender = '';

SELECT `Blood Type`
FROM healthcare_dataset_staging
WHERE `Blood Type` IS NULL
OR `Blood Type` = '';

SELECT `Medical Condition`
FROM healthcare_dataset_staging
WHERE `Medical Condition` IS NULL
OR `Medical Condition` = '';

SELECT `Date of Admission`
FROM healthcare_dataset_staging
WHERE `Date of Admission` IS NULL;

SELECT Doctor
FROM healthcare_dataset_staging
WHERE Doctor IS NULL
OR Doctor = '';

SELECT Hospital
FROM healthcare_dataset_staging
WHERE Hospital IS NULL
OR Hospital = '';

SELECT `Insurance Provider`
FROM healthcare_dataset_staging
WHERE `Insurance Provider` IS NULL
OR `Insurance Provider` = '';

SELECT `Billing Amount`
FROM healthcare_dataset_staging
WHERE `Billing Amount` IS NULL
OR `Billing Amount` = '';

SELECT `Room Number`
FROM healthcare_dataset_staging
WHERE `Room Number` IS NULL
OR `Room Number` = '';

SELECT `Admission Type`
FROM healthcare_dataset_staging
WHERE `Admission Type` IS NULL
OR `Admission Type` = '';

SELECT `Discharge Date`
FROM healthcare_dataset_staging
WHERE `Discharge Date` IS NULL;

SELECT `Medication`
FROM healthcare_dataset_staging
WHERE `Medication` IS NULL
OR `Medication` = '';

SELECT `Test Results`
FROM healthcare_dataset_staging
WHERE `Test Results` IS NULL
OR `Test Results` = '';

-- No NULL or BLANK values found