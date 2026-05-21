# Employee-Attrition-Risk-Analysis
Built an end-to-end Employee Attrition Analysis project to identify the major reasons behind employee turnover using SQL, Python, Machine Learning, and Power BI. Developed predictive models to identify high-risk employees, created interactive HR dashboards, and deployed the final attrition prediction model using Streamlit for real-time business use
# Employee Attrition Analysis

## Project Overview

Employee attrition is one of the biggest challenges faced by organizations because it directly affects productivity, operational stability, employee morale, recruitment cost, and long-term business performance.

This project focuses on analyzing employee attrition using SQL, Python, Machine Learning, and Power BI to identify the major reasons behind employee turnover and predict employees who are at high risk of leaving the organization.

The project combines:

* Descriptive Analysis
* Diagnostic Analysis
* Predictive Analysis
* Dashboard Reporting
* Machine Learning Deployment

The complete workflow was built using Snowflake, Databricks, Power BI, and Streamlit.

---

# Business Problem

A large multinational company is facing employee attrition above the industry benchmark. Frequent employee exits are creating several business problems such as:

* Increased recruitment and training costs
* Operational disruption
* Productivity loss
* Reduced employee morale
* Increased workload on existing employees
* Difficulty in workforce planning

The HR team lacked proper data-driven insights to answer important business questions such as:

* Why are employees leaving?
* Which employee groups are at highest risk?
* Which workplace factors influence attrition the most?
* How can the company reduce employee turnover?

Without proper analysis, the organization struggled to:

* Improve employee retention
* Design effective HR strategies
* Improve employee engagement
* Build a healthier work culture
* Reduce future attrition risk

This project was developed to solve these business challenges using analytics and predictive modeling.

---

# Project Objectives

## 1. Descriptive Analysis

Understand:

* Workforce composition
* Attrition distribution
* Salary trends
* Employee demographics
* HR metrics across the organization

---

## 2. Diagnostic Analysis

Identify:

* Root causes behind employee attrition
* Employee risk patterns
* Relationships between workplace factors and attrition
* High-risk employee segments

---

## 3. Predictive Modeling

Build a Logistic Regression Model to:

* Predict employee attrition probability
* Identify high-risk employees
* Find the most important attrition predictors

---

## 4. Dashboard Development

Create interactive Power BI dashboards to:

* Monitor attrition trends
* Track HR KPIs
* Explore employee risk factors
* Support management decision-making

---

# Technology Stack

| Technology | Purpose                                        |
| ---------- | ---------------------------------------------- |
| Snowflake  | Data Importing, Data Auditing, Data Validation |
| Databricks | Data Cleaning, EDA, Predictive Modeling        |
| SQL        | Data Analysis and KPI Reporting                |
| Python     | Statistical Analysis and Machine Learning      |
| Power BI   | Dashboard Development and Visualization        |
| Streamlit  | Machine Learning Model Deployment              |

---

# Data Available

The project used three main datasets related to employees, surveys, and manager evaluations.

---

# 1. General Data Table

This table contains the primary employee information used for attrition analysis.

## Includes:

* Employee demographics
* Job role
* Job level
* Salary information
* Promotions
* Distance from home
* Overtime information
* Company tenure
* Recognition details
* Leadership opportunities
* Innovation opportunities
* Attrition status

This was the main table used throughout the analysis.

---

# 2. Employee Survey Table

This table captured employee feedback regarding workplace experience.

## Includes:

* Work-life balance
* Job satisfaction
* Workplace environment satisfaction

This dataset helped measure employee experience and workplace pressure.

---

# 3. Manager Survey Table

This table contained manager evaluations of employees.

## Includes:

* Performance ratings
* Job involvement scores

This data helped analyze employee performance and talent segments.

---

# Data Cleaning and Quality Validation

Before starting the analysis, several SQL-based data quality checks were performed.

## Data Quality Checks Performed

| Validation Check              | Result                      |
| ----------------------------- | --------------------------- |
| NULL / Missing Values Check   | No null values found        |
| Duplicate Records Check       | No duplicate records found  |
| Invalid / Inconsistent Values | No invalid data found       |
| Data Type Validation          | All columns correctly typed |

---

# Data Cleaning Conclusion

The dataset was:

* Clean
* Complete
* Consistent
* Ready for analysis

This ensured that the analysis and predictive modeling results were reliable.

---

# SQL Analysis

The first phase of the project focused on descriptive and diagnostic analysis using SQL.

The objective was to understand:

* Which employees were leaving the company
* Which factors were driving attrition
* Which employee groups were at highest risk
* What business impact attrition was creating

---

# SQL KPI Analysis

## Important Business KPIs

| KPI                                  | Result |
| ------------------------------------ | ------ |
| Total Attrition Rate                 | 47.48% |
| Average Monthly Income               | 7299   |
| Average Income of Employees Who Left | 7275   |
| Low Job Satisfaction Attrition       | 52.78% |
| Poor Work-Life Balance Attrition     | 60.18% |

---

# Key SQL Insights

## 1. Entry-Level Employees Had Highest Attrition

Entry-level employees showed the highest attrition rate.

| Job Level | Attrition Rate |
| --------- | -------------- |
| Entry     | 63.27%         |
| Mid       | 45.42%         |
| Senior    | 20.27%         |

### Insight

Early-career employees were leaving the organization more frequently than experienced employees.

Possible reasons:

* Higher pressure
* Lower engagement
* Limited career growth
* Lack of organizational support

---

# 2. Workplace Opportunities Reduced Attrition

Three employee opportunity factors were analyzed:

* Remote work
* Leadership opportunities
* Innovation opportunities

Employees with no opportunities contributed most to attrition.

| Opportunity Score | Attrition Contribution |
| ----------------- | ---------------------- |
| 0                 | 72.61%                 |
| 1                 | 24.88%                 |
| 2                 | 2.45%                  |
| 3                 | 0.06%                  |

### Insight

Employees who lacked workplace flexibility and growth opportunities were much more likely to resign.

---

# 3. Composite Attrition Risk Index (CARI)

A custom risk score was created using:

* Overtime
* Work-life balance
* Job satisfaction
* Employee recognition
* Promotions
* Distance from home
* Performance ratings

Employees were grouped into risk levels.

| Risk Tier | Attrition Rate |
| --------- | -------------- |
| Critical  | 61.46%         |
| High      | 51.98%         |
| Medium    | 42.90%         |
| Low       | 35.21%         |

### Insight

Attrition increased sharply as employee risk scores increased.

---

# 4. High-Risk Employee Identification

Top high-risk employees were identified using:

* Overtime
* Low satisfaction
* Poor work-life balance
* No promotions
* Long commuting distance

### Business Value

The company can proactively monitor risky employees before resignation happens.

---

# 5. Triple Dissatisfaction Analysis

Employees facing all three conditions together:

* Low job satisfaction
* Poor work-life balance
* Poor company reputation

showed very high attrition.

| Group              | Attrition Rate |
| ------------------ | -------------- |
| Triple Deprivation | 63.32%         |
| Others             | 47.06%         |

### Insight

Employees leave when multiple workplace problems combine together.

---

# 6. Talent Segment Analysis

Employees were grouped based on:

* Performance
* Recognition

| Talent Segment                      | Attrition Contribution |
| ----------------------------------- | ---------------------- |
| High Performance + Low Recognition  | Highest                |
| High Performance + High Recognition | Lower                  |
| Low Performance Employees           | Lower                  |

### Insight

High-performing employees were also leaving when recognition was low.

Recognition became one of the strongest retention factors.

---

# Python Predictive Analysis

After SQL analysis, Python was used for:

* Advanced analytics
* Statistical testing
* Employee risk modeling
* Predictive machine learning

The analysis was performed in Databricks using data fetched from Snowflake.

---

# Attrition Pressure Index

A custom Attrition Pressure Index was created using:

* Work-life balance
* Job satisfaction
* Overtime

| Attrition Status | Pressure Score |
| ---------------- | -------------- |
| Left             | 5.77           |
| Stayed           | 5.44           |

### Insight

Employees who left the company had higher workplace pressure scores.

---

# Income Gap Analysis

Salary fairness was analyzed by comparing:

* Actual salary
* Expected salary based on experience

### Insight

Employees earning below expected salary levels were more likely to resign.

This showed that salary fairness strongly impacts retention.

---

# Organizational Loyalty Analysis

Attrition was analyzed across employee tenure groups.

### Insight

Employees in early and mid-career stages showed higher attrition compared to long-tenure employees.

---

# Python-Based Composite Attrition Risk Index

A simplified Python version of CARI was created using:

* Overtime
* Work-life balance
* Job satisfaction

| Risk Tier | Attrition Rate |
| --------- | -------------- |
| Critical  | 63.57%         |
| High      | 55.52%         |
| Medium    | 47.94%         |
| Low       | 36.66%         |

### Insight

Employees with higher risk scores were much more likely to leave the company.

---

# Hypothesis Testing

Several statistical hypothesis tests were performed.

## Findings

### Salary vs Attrition

P-value = 0.003

Salary has a significant relationship with attrition.

---

### Work-Life Balance vs Attrition

P-value = 0.00

Poor work-life balance significantly contributes to employee attrition.

---

### Overtime vs Attrition

P-value = 1.0e-52

Overtime strongly affects employee resignation.

---

### Experience Level vs Attrition

P-value = 8.07e-101

Attrition differs significantly across career stages.

---

# Feature Selection

Multiple feature selection techniques were used to identify the most important attrition predictors.

## Methods Used

* SelectKBest
* ANOVA
* Recursive Feature Elimination (RFE)
* Variance Inflation Factor (VIF)

### Purpose

* Remove unnecessary variables
* Improve model quality
* Reduce multicollinearity
* Improve prediction performance

---

# Machine Learning Model

## Model Used

Logistic Regression

---

# Model Building Process

The following steps were performed:

1. Data preprocessing
2. Feature engineering
3. Feature selection
4. Train-test split
5. Logistic regression training
6. Threshold optimization using KS statistics
7. Model evaluation

---

# Model Performance

## Test Data Results

| Metric      | Score |
| ----------- | ----- |
| Accuracy    | 73.6% |
| Sensitivity | 71.7% |
| Specificity | 75.3% |
| Precision   | 72.4% |

### Insight

The model showed balanced performance and successfully identified employees at risk of attrition.

---

# Power BI Dashboard

Interactive dashboards were created in Power BI for HR and management reporting.

---

# Dashboard 1 – Executive Attrition Overview

This dashboard focused on:

* Overall attrition rate
* Employee distribution
* Salary overview
* Company size analysis
* Recognition analysis
* Promotion analysis

## Key Insights

* Attrition rate was critically high
* Employees with low recognition contributed most to attrition
* Promotion opportunities reduced attrition
* Medium-sized teams showed higher attrition

---

# Dashboard 2 – Risk Factor Analysis

This dashboard focused on:

* Overtime
* Job satisfaction
* Work-life balance
* Leadership opportunities
* Talent segments
* Job levels
* Work mode analysis

## Key Insights

* Poor work-life balance strongly increased attrition
* Overtime increased employee exits
* Entry-level employees had highest attrition
* High performers with low recognition left the most
* On-site employees contributed most to attrition

---

# Streamlit Model Deployment

The final Logistic Regression model was deployed using Streamlit Community Cloud.

## Features of the Application

* Predict employee attrition risk
* Accept employee input data
* Generate attrition predictions instantly
* Support HR retention planning

---

# Business Recommendations

Based on the analysis, the following recommendations were identified.

---

# 1. Improve Work-Life Balance

* Reduce excessive overtime
* Introduce flexible work arrangements
* Encourage healthy work schedules

---

# 2. Improve Employee Recognition

* Reward high-performing employees
* Conduct employee appreciation programs
* Increase feedback and recognition culture

---

# 3. Create Better Career Growth Opportunities

* Improve promotion systems
* Increase leadership opportunities
* Support employee skill development

---

# 4. Focus on Entry-Level Employees

* Improve onboarding
* Provide mentoring support
* Increase employee engagement programs

---

# 5. Use Predictive Analytics in HR

* Monitor employee risk scores regularly
* Identify risky employees early
* Take preventive retention actions

---

# Final Conclusion

This project successfully combined SQL, Python, Machine Learning, and Power BI to analyze employee attrition and predict employee risk.

The analysis revealed that employee attrition was mainly influenced by:

* Poor work-life balance
* Overtime pressure
* Low recognition
* Lack of growth opportunities
* Workplace dissatisfaction

The machine learning model successfully predicted employee attrition risk and was deployed into a real business application using Streamlit.

This project demonstrates how data analytics and predictive modeling can help organizations make better HR decisions, reduce employee turnover, and improve workforce stability.

---

# Project Outcome

The project delivered:

* End-to-end attrition analysis
* Business-driven SQL insights
* Statistical validation
* Predictive employee risk modeling
* Interactive dashboards
* Real-time model deployment

The organization can now move from reactive attrition management to proactive employee retention strategies.
