# TechForce Solutions HR Analytics Project

End-to-end HR analytics project for a fictional company, TechForce Solutions — from raw data cleaning through SQL exploration to a Power BI dashboard, covering employee salary, tenure, department, and location trends.

## Project Overview

This project analyzes workforce data for a 57-employee company to answer core HR questions: Where is compensation spend concentrated? Is pay distributed equitably? What does the tenure profile say about retention risk? 
The workflow moved through three stages, each with a distinct purpose:

1. **Data Cleaning(MySQL)** — resolved data quality issues in the raw dataset (missing values, inconsistent formatting, duplicates) to produce a reliable base for analysis.
2. **Exploratory Data Analysis (MySQL)** — queried the cleaned data in SQL to surface initial patterns in salary, department, and tenure before any visualization work began.
3. **Dashboard Development (Power BI)** — built an interactive dashboard with DAX measures to make the findings explorable and decision-ready.

This mirrors how HR analytics work is typically done in practice: clean first, understand the data through queries, then visualize for stakeholders.

## Dashboard Preview

*(Add a screenshot or GIF of your dashboard here)*

```
![Dashboard Screenshot](path/to/screenshot.png)
```

## Key Findings

- **Retention is strong overall** — 75% of employees have 5–8 years of tenure, with few very-new or very-senior hires, suggesting stable headcount rather than high turnover.
- **A gender pay gap exists at the aggregate level** — men account for 58.3% of total salary spend versus 41.7% for women; this is flagged for further investigation against headcount by gender rather than treated as conclusive.
- **Engineering is the largest cost center** — 26% of headcount (15 of 57 employees) and the highest departmental salary spend (₦9.5m), consistent with a tech-driven organization.
- **Pay per head is uneven across similarly-sized departments** — Sales and Finance carry a higher salary spend than HR, Marketing, or Customer Support despite comparable headcounts, pointing to differences in role seniority or market rate rather than department size.
- **Kano is a location outlier** — 2 employees versus 16–20 each in Lagos, Port Harcourt, and Abuja, warranting a check on whether it's an intentional small satellite office or a data gap.

## Tools & Skills Applied

| Stage | Tools | Skills |
|---|---|---|
| Data Cleaning | MySQL | Handling missing values, standardizing formats, deduplication |
| Exploratory Analysis | MySQL | Aggregation, GROUP BY/HAVING, filtering, query-driven hypothesis testing |
| Visualization | Power BI | Data modeling, DAX measures, KPI cards, chart design |
| Communication | — | Translating query and chart output into business findings and recommendations |

## Data Source

This project uses a fictional HR dataset created for training/practice purposes, structured to reflect a realistic Nigerian company HR database. *(Add a link to the dataset file here if you're including it in the repo.)*

## Repository Structure

```
├── data/
│   ├── raw_hr_data.csv          # Original uncleaned dataset
│   └── cleaned_hr_data.csv      # Cleaned dataset used for analysis
├── sql/
│   └── eda_queries.sql          # SQL queries used for exploratory analysis
├── dashboard/
│   └── techforce_hr_dashboard.pbix
├── screenshots/
│   └── dashboard_preview.png
└── README.md
```
*(Adjust this to match your actual folder layout.)*

## How to Explore This Project

1. **Review the SQL analysis** — open `sql/eda_queries.sql` to see the exploratory queries and the questions they were built to answer.
2. **Open the dashboard** — download `dashboard/techforce_hr_dashboard.pbix` and open it in [Power BI Desktop](https://www.microsoft.com/en-us/power-platform/products/power-bi/desktop) (free) to interact with the visuals.
3. **Check the cleaned dataset** — `data/cleaned_hr_data.csv` if you want to trace findings back to source rows.

## Dashboard Structure

- **KPI Cards** — total employees, average, max, and min salary
- **Tenure Chart** — employee count by years at the company
- **Salary by Gender** — total salary split by gender
- **Employees by City** — headcount across Lagos, Port Harcourt, Abuja, and Kano
- **Salary by Department** — total salary spend per department
- **Top 5 Salaries by Job Title** — highest-paid roles on average

## Recommendations

- Break down the gender pay gap by role/seniority to confirm whether it reflects a structural pay issue or role distribution.
- Investigate the Kano office's small headcount before treating it as a strategic location.
- Compare average (not total) salary per department to separate "costs more because of headcount" from "costs more per person."
- Monitor the 5–8 year tenure cohort as a retention watch group, since a concentrated departure wave would hit a large share of the workforce at once.

## Connect

*(Add your LinkedIn or portfolio link here)*


