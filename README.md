# Healthcare-Data-Cleaning-Project
Project Overview

This project focuses on assessing and preparing a healthcare dataset for downstream data visualization using MySQL. The dataset contains 10,000 rows and 15 columns and serves as the foundation for a larger analytics workflow, with the next phase centered on building dashboards in Power BI.

Using SQL, I performed a comprehensive data quality review to ensure the dataset was reliable, consistent, and analysis-ready. I validated data integrity by checking for null, blank, and duplicate values, confirming that none were present. This step ensured the dataset could be confidently used without data loss or bias.

The primary focus of the cleaning process was standardization. I removed prefixes from name fields to improve readability and consistency, converted date fields stored as text into proper DATE formats, and standardized billing amounts to two decimal places. These transformations ensure accurate aggregation, filtering, and visualization in Power BI.

This repository represents the data preparation stage of the project and highlights best practices in SQL-based data cleaning and validation for analytics and visualization workflows.

Key Tasks Performed:

* Validated dataset integrity (null, blank, and duplicate checks)

* Standardized name fields by removing prefixes

* Converted text-based date fields into proper DATE formats

* Standardized billing amounts to two decimal places

* Prepared clean, visualization-ready data for Power BI

Tools & Technologies:

* MySQL

* SQL

* Power BI (planned for visualization phase)

Next Steps:

* Build interactive dashboards in Power BI

* Analyze trends and patterns within the healthcare data

* Generate insights to support data-driven decision-making
