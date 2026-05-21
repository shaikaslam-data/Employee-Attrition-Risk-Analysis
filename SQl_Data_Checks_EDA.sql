/* Creating the new database */
create database HR_Analysis
use HR_Analysis

/* creating new schema called Hr */
create schema Hr

-----------------------------------------------------------------------------------------------------------------------------------------------
                                                   --Data checks
-----------------------------------------------------------------------------------------------------------------------------------------------
select top 10 * from general_data
select top 10 * from employee_survey
select top 10 * from manager_survey

-----------------------------------------------------------------------------------------------------------------------------------------------

/* Checking for duplicates */
--Table 1
select employee_id from general_data
group by employee_id
having count(*) > 1
 -- No duplicates founded

 -- Table 2
select emp_id from manager_survey
group by emp_id
having count(*) > 1
 -- No duplicates founded

 -- Table 3 
select emp_id from employee_survey
group by emp_id
having count(*) > 1
-- no duplicates founded

-------------------------------------------------------------------------------------------------------------------

select min(monthly_income) from general_data
select max(monthly_income) from general_data

select * from general_data
where monthly_income < 0

select max(distance_from_home) from general_data
select min(distance_from_home) from general_data

select min(age) from general_data
select max(age) from general_data

select * from general_data
where year_since_last_promotion < 0

select * from general_data
where year_at_company < 0

select * from general_data
where monthly_income < 0 

select min(number_of_promotions), max(number_of_promotions)
from general_data

select * from general_data
where salary_hike_pct > 100 or salary_hike_pct < 0

select min(number_of_company_worked), max(number_of_company_worked)
from general_data


select min(distance_from_home), max(distance_from_home)
from general_data

select min(company_tenure), max(company_tenure)
from general_data

select min(number_of_dependents), max(number_of_dependents)
from general_data
------------------------------------------------------------------------------------------------------------------------------------------------
select min(work_life_balance),max(work_life_balance) from employee_survey

select min(job_satisfaction),max(job_satisfaction) from employee_survey

select min(environment_satisfaction),max(environment_satisfaction) from employee_survey

select * from employee_survey
where work_life_balance is null

select * from employee_survey
where job_satisfaction is null

select * from employee_survey
where environment_satisfaction is null
------------------------------------------------------------------------------------------------------------------------------------------------

select min(performancerating),max(performancerating) from manager_survey

select min(job_involvement),max(job_involvement) from manager_survey

select * from manager_survey
where performancerating is null 

select * from manager_survey
where job_involvement is null 

---------------------------------------------------------------------------------------------------------------------------------------------- -- changging the bool data type to int                                                 

ALTER TABLE employees_info
ADD overtimeN INT;

UPDATE employees_info
SET overtimeN = CASE WHEN overtime = 'TRUE' THEN 1 ELSE 0 END;

ALTER TABLE employees_info
DROP COLUMN overtime;

ALTER TABLE employees_info
RENAME COLUMN overtimeN TO overtime;
-----------------------------------------------------------------------------------------------------------------------------------------------
-- changging the bool data type to int 

ALTER TABLE employees_info
ADD remote_workN INT;

UPDATE employees_info
SET remote_workN = CASE WHEN remote_work = 'TRUE' THEN 1 ELSE 0 END;

ALTER TABLE employees_info
DROP COLUMN remote_work;

ALTER TABLE employees_info
RENAME COLUMN remote_workN TO remote_work;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- changging the bool data type to int 

ALTER TABLE employees_info
ADD leadership_opportunitiesN INT;

UPDATE employees_info
SET leadership_opportunitiesN = CASE WHEN leadership_opportunities = 'TRUE' THEN 1 ELSE 0 END;

ALTER TABLE employees_info
DROP COLUMN leadership_opportunities;

ALTER TABLE employees_info
RENAME COLUMN leadership_opportunitiesN TO leadership_opportunities;


-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-- changging the bool data type to int 
 
ALTER TABLE employees_info
ADD innovation_opportunitiesN INT;

UPDATE employees_info
SET innovation_opportunitiesN = CASE WHEN innovation_opportunities = 'TRUE' THEN 1 ELSE 0 END;

ALTER TABLE employees_info
DROP COLUMN innovation_opportunities;

ALTER TABLE employees_info
RENAME COLUMN innovation_opportunitiesN TO innovation_opportunities;

-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

-- combining all the 3 tabels as employees_info

CREATE TABLE employees_info AS
SELECT 
    g.employee_ID,
    g.age,
    g.gender,
    g.years_at_company,
    g.job_role,
    g.monthly_income,
    g.under_paid,
    g.over_worked,
    g.number_of_promotions,
    g.year_since_last_promotion,
    g.salary_hike_pct,
    g.number_of_company_worked,
    g.overtime,
    g.distance_from_home,
    g.commute_category,
    g.education_level,
    g.marital_status,
    g.number_of_dependents,
    g.job_level,
    g.company_size,
    g.company_tenure,
    g.remote_work,
    g.leadership_opportunities,
    g.innovation_opportunities,
    g.company_reputation,
    g.employee_recognition,
    g.attrition,
    e.environment_satisfaction,
    e.job_satisfaction,
    e.work_life_balance,
    m.job_involvement,
    m.performancerating
FROM general_data g
LEFT JOIN employee_survey e
    ON g.employee_id = e.emp_id
LEFT JOIN manager_survey m
    ON m.emp_id = g.employee_id;


    
-----------------------------------------------------------------------------------------------------------------------------------------------
                                                    -- Analysis & EDA
-----------------------------------------------------------------------------------------------------------------------------------------------
                                                          -- KIPs
                                                          
-- current employee and left employee percentage

select Attrition,count(*) * 100 /(select count(*) from general_data) as Attrition_pct
from employees_info
group by Attrition

-- left employee percentage

select 
sum(case when  attrition = 'Left' then 1 else 0 end) * 100 /count(*) as left_pct
from EMPLOYEES_INFO

-- Average Income

SELECT ROUND(AVG(MONTHLY_INCOME),2) AS AVERAGE_INCOME
FROM EMPLOYEES_INFO

--Average Income for the left employees

SELECT ROUND(AVG(MONTHLY_INCOME),2) AS AVERAGE_INCOME
FROM EMPLOYEES_INFO
where attrition = 'Left'


SELECT ROUND(AVG(MONTHLY_INCOME),2) AS AVERAGE_INCOME
FROM EMPLOYEES_INFO
where attrition = 'Stayed'

-- Job Level Mode
SELECT TOP 1 JOB_LEVEL
FROM EMPLOYEES_INFO
GROUP BY JOB_LEVEL
ORDER BY COUNT(*) DESC

-- Attrition percentage for low JOB_SATISFACTION
SELECT  
SUM(CASE WHEN  attrition = 'Left' THEN 1 ELSE 0 END) * 100 /count(*) as Low_Satisfaction_Left_pct
FROM EMPLOYEES_INFO
WHERE JOB_SATISFACTION = 'Low'

-- Attrition percentage for low work_life_balance

SELECT  
SUM(CASE WHEN  attrition = 'Left' THEN 1 ELSE 0 END) * 100 /count(*) as Poor_WorkLifeBalance_Left_pct
FROM EMPLOYEES_INFO
WHERE work_life_balance = 'Poor'


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                            -- EDA & Analysis
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     


                                            
/*Employees with lower income and low recognition contributed the highest share of attrition, indicating that compensation dissatisfaction combined with lack of appreciation strongly increases resignation risk*/
                                            
SELECT
CASE
WHEN monthly_income < 9000 THEN 'Lower income (13k–14.5k)'
ELSE 'Upper income (14.5k–16k)'
END AS income_band,
CASE
WHEN employee_recognition IN ('Low','Medium') THEN 'Low recognition'
ELSE 'High recognition'
END AS recognition_band,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) * 100 / (select count(*) from employees_info where attrition = 'Left') AS attrition_rate_pct
FROM employees_info
GROUP BY income_band, recognition_band
ORDER BY attrition_rate_pct DESC;



-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


/*Total estimated financial cost of all employee departures in a year, calculated as 1.5× average annual salary per attriton*/

SELECT
COUNT(CASE WHEN attrition='Left' THEN 1 END) AS total_attritors,
ROUND(SUM(CASE WHEN attrition='Left' THEN monthly_income ELSE 0 END)*12*1.5,0) AS aac,
ROUND(SUM(monthly_income)*12,0) AS total_payroll,
ROUND(100.0*SUM(CASE WHEN attrition='Left' THEN monthly_income ELSE 0 END)*1.5
/SUM(monthly_income),2) AS aac_as_pct_of_payroll
FROM employees_info;


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
/*High-performing employees with weak recognition contribute disproportionately to the organization’s attrition problem.*/
/* 
Measure how much each talent segment contributes to total company attrition to identify which employee groups are driving overall workforce loss.
*/


WITH perf_seg AS (
SELECT
employee_id,attrition,
performance_rating, employee_recognition,
CASE WHEN performance_rating   IN ('High','Average') AND employee_recognition IN ('Low','Medium')
THEN 'High perf + Low recognition'
WHEN performance_rating   IN ('High','Average') AND employee_recognition IN ('High','Very High')
THEN 'High perf + High recognition'
ELSE 'Low/Below-avg performance'
END AS talent_segment
FROM employees_info)
SELECT
talent_segment,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / (select COUNT(*) from employees_info), 2) AS attrition_rate_pct
FROM perf_seg
GROUP BY talent_segment  
ORDER BY attrition_rate_pct DESC;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  /* 
Identify employees experiencing multiple workplace dissatisfaction factors simultaneously and measure their impact on attrition risk and estimated replacement cost.
*/
WITH triple_dep AS (
SELECT
employee_id,
job_satisfaction, work_life_balance, company_reputation, monthly_income ,attrition,
 CASE
WHEN job_satisfaction   IN ('Low','Medium')
AND work_life_balance  IN ('Poor','Fair')
AND company_reputation IN ('Foor','Fair')
THEN 'Triple Deprivation'
ELSE 'Rest' END AS cohort
FROM employees_info
)
SELECT
cohort,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / count(*), 2) AS attrition_rate_pct,
ROUND(AVG(CASE WHEN attrition='Left' THEN monthly_income END)*12*1.5,0) AS est_replacement_cost
FROM triple_dep
GROUP BY cohort;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


 /* Analyze how employee attrition varies across different job satisfaction levels.*/
SELECT
JOB_SATISFACTION,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END ) AS Attrited_Employees,
ROUND(100.0 *SUM( CASE WHEN Attrition = 'Left' THEN 1 ELSE 0 END) / COUNT(*),2 ) AS Attrition_Rate
FROM employees_info
GROUP BY JOB_SATISFACTION
ORDER BY Attrition_Rate DESC;

/* 
Identify whether limited career growth is causing attrition among employees who report very high job satisfaction.
*/
-- page line 
SELECT
NUMBER_OF_PROMOTIONS,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0  END ) AS Attrited,
ROUND(100.0 * SUM(CASE WHEN Attrition = 'Left' THEN 1 ELSE 0  END) / (select COUNT(*) from employees_info where attrition = 'Left'),  2) AS Attrition_Rate
FROM employees_info
WHERE JOB_SATISFACTION = 'Very High'
GROUP BY NUMBER_OF_PROMOTIONS
ORDER BY NUMBER_OF_PROMOTIONS

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*“These employees are under heavy workplace pressure from many directions at the same time, and most of them eventually leave the company.*/

SELECT
  employee_id, age, job_role, job_level, monthly_income, attrition,
  -- CARI: Composite Attrition Risk Index (0-100)
  (
    CASE WHEN overtime = 1                          THEN 20 ELSE 0 END
  + CASE WHEN work_life_balance IN ('Poor','Fair')    THEN 18 ELSE 0 END
  + CASE WHEN job_satisfaction IN ('Low','Medium')    THEN 16 ELSE 0 END
  + CASE WHEN employee_recognition IN ('Low','Medium') THEN 14 ELSE 0 END
  + CASE WHEN number_of_promotions = 0               THEN 12 ELSE 0 END
  + CASE WHEN distance_from_home > 60               THEN 10 ELSE 0 END
  + CASE WHEN performance_rating IN ('Low','Below Average') THEN 6 ELSE 0 END
  + CASE WHEN company_tenure > years_at_company * 3  THEN 4 ELSE 0 END
  ) AS cari_score
FROM employees_info
Where attrition = 'Stayed'
ORDER BY cari_score DESC
LIMIT 100;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*Higher employee risk scores were associated with significantly higher attrition rates, indicating that workload pressure, low satisfaction, and lack of growth opportunities strongly contribute to employee resignations.*/

WITH scored AS (
SELECT attrition,
(CASE WHEN overtime = 1  THEN 20 ELSE 0 END
+ CASE WHEN work_life_balance IN ('Poor','Fair')THEN 18 ELSE 0 END
+ CASE WHEN job_satisfaction IN ('Low','Medium') THEN 16 ELSE 0 END
+ CASE WHEN employee_recognition IN ('Low','Medium') THEN 14 ELSE 0 END
+ CASE WHEN number_of_promotions = 0 THEN 12 ELSE 0 END
+ CASE WHEN distance_from_home > 60  THEN 10 ELSE 0 END
+ CASE WHEN performance_rating IN ('Low','Below Average') THEN 6 ELSE 0 END
) AS cari
FROM employees_info
), banded AS (
SELECT attrition,
CASE
WHEN cari <= 20  THEN 'Low (0–20)'
WHEN cari <= 40  THEN 'Medium (21–40)'
WHEN cari <= 60  THEN 'High (41–60)'
ELSE  'Critical (61+)'
END AS risk_tier
FROM scored)
SELECT
risk_tier,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM banded
GROUP BY risk_tier
ORDER BY attrition_rate_pct DESC;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*Entry-level employees across all job roles show the highest attrition levels, indicating that early-career workforce retention is the organization’s biggest stability challenge.*/
SELECT
  job_level,
  job_role,
  COUNT(*) AS headcount,
  MIN(monthly_income)  AS min_income,
  MAX(monthly_income)  AS max_income,
  MAX(monthly_income) - MIN(monthly_income) AS income_spread,
  ROUND(AVG(monthly_income), 0) AS avg_income,
  ROUND(100.0 * STDDEV(monthly_income) / AVG(monthly_income), 2) AS income_cv_pct,
  ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM employees_info
GROUP BY job_level, job_role
HAVING COUNT(*) >= 10
ORDER BY income_spread DESC;


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 
Analyze how attrition behavior changes across different age groups and job levels to identify workforce segments experiencing the highest career-stage instability and retention risk.
*/

SELECT
CASE
WHEN age BETWEEN 18 AND 29 THEN '18–29 (Early career)'
WHEN age BETWEEN 30 AND 39 THEN '30–39 (Mid career)'
WHEN age BETWEEN 40 AND 49 THEN '40–49 (Established)'
ELSE  '50–59 (Senior)'
END AS age_band,
job_level,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct,
ROUND(AVG(monthly_income), 0) AS avg_income
FROM employees_info
GROUP BY age_band, job_level
ORDER BY attrition_rate_pct DESC;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 
Analyze attrition patterns among highly educated employees to identify how job level and performance influence retention of advanced-skilled talent.
*/

SELECT
education_level,
job_level,
performance_rating,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM employees_info
WHERE education_level IN ('Master’s Degree', 'PhD')
GROUP BY education_level, job_level, performance_rating
ORDER BY attrition_rate_pct DESC;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/* Measure how combined workplace pressure and growth opportunity factors contribute to overall 
company attrition across different employee risk score levels.*/
-- page 
with score as(
select attrition,
       (overtime+leadership_opportunities+innovation_opportunities) as sc
from employees_info
)
select sc , 
sum(case when attrition = 'Left' then 1 else 0 end )as left_emp,
sum(case when attrition = 'Left' then 1 else 0 end ) /
(select count (*) from employees_info where attrition = 'Left') * 100 as left_emp_pct
from score
group by sc
order by 3 desc

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*Higher job levels showed greater estimated replacement costs despite lower attrition rates, indicating that employee resignations at senior positions create a much larger financial impact for the organization.*/

SELECT
  job_level,
  COUNT(CASE WHEN attrition='Left' THEN 1 END) AS attritors,
  ROUND(AVG(CASE WHEN attrition='Left' THEN monthly_income END)*12,0) AS avg_annual_salary,
  ROUND(AVG(CASE WHEN attrition='Left' THEN monthly_income END)*12*
  CASE job_level WHEN 'entry' THEN 0.75 WHEN 'mid' THEN 1.5 ELSE 2.0 END,0) AS est_replacement_cost,
  ROUND(100.0*SUM(CASE WHEN attrition='Left' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_rate_pct
FROM employees_info
GROUP BY job_level
ORDER BY est_replacement_cost DESC;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*Employees in the High and Critical risk tiers showed much higher attrition rates, indicating that overtime, poor work-life balance, and low job satisfaction are major drivers of employee resignations.*/

WITH scored AS (
SELECT  attrition,
(CASE WHEN overtime = 1 THEN 25 ELSE 0 END
+ CASE WHEN work_life_balance IN ('Poor','Fair') THEN 25 ELSE 0 END
+ CASE WHEN job_satisfaction IN ('Low','Medium') THEN 25 ELSE 0 END ) AS cari
FROM employees_info
order by 2 desc 
), banded AS (
SELECT attrition,
CASE
WHEN cari <= 20  THEN 'Low (0–20)'
WHEN cari <= 40  THEN 'Medium (21–40)'
WHEN cari <= 60  THEN 'High (41–60)'
ELSE 'Critical (61+)'
END AS risk_tier
FROM scored
)
SELECT
risk_tier,
COUNT(*) AS headcount,
SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) AS attrited,
ROUND(100.0 * SUM(CASE WHEN attrition = 'Left' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM banded
GROUP BY risk_tier
ORDER BY attrition_rate_pct DESC;