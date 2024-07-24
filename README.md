# Introduction

📊 Exploring the data job market! This project delves into entry-level data & business analyst roles, highlighting 💰 top-paying positions, 🔥 in-demand skills, and 📈 the intersection of high demand and lucrative salaries for junior analysts.


🔍 Check out sql queries here: [project_folder](/project_sql/)

# Background
Driven by a desire to master SQL and to effectively navigate the data job market as a fresh graduate, this project emerged from my pursuit to identify top-paying and in-demand skills for junior-level analyst roles. The data leveraged from  [Luke Barousse's SQL course](https://lukebarousse.com/sql), includes massive insights on job titles, salaries, locations, and the essential skills related to tech jobs.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying entry-level analyst jobs?
2. What skills are most in demand for junior analysts?
3. Which skills are associated with higher salaries?
4. What are the most optimal skills to learn? 

# Tools Used
For my work, I utilized several key tools:

- **SQL**: The main tool of my analysis, enabling me to query the database and uncover vital insights.
- **PostgreSQL**: The selected database management system, perfect for managing larger data.
- **Visual Studio Code**: My go to IDE for all projects.
- **Git & GitHub**: Crucial for version control and sharing my SQL scripts and analysis.

# Analysis
Each query in this project was aimed at investigating a specific aspect of the junior data/business analyst job market. Here’s how I approached each question:

### 1. Top Paying Analyst Jobs
To identify the highest-paying roles, I filtered Business/data analyst positions by average yearly salary. I also made sure that these positions are intended for junior candidates only. This query highlights the high paying opportunities in the field.

```sql
SELECT  
        c.name AS company_name,
        job_title, job_location, 
        job_schedule_type, 
        salary_year_avg
FROM 
    job_postings_fact AS j
LEFT JOIN 
    company_dim AS c
ON 
    c.company_id = j.company_id
WHERE  (LOWER(job_title) LIKE '%jr%' 
       OR LOWER(job_title) LIKE '%jnr%' 
       OR LOWER(job_title) LIKE '%jun%' 
       OR LOWER(job_title) LIKE '%entry%level%')
AND job_title_short in ('Data Analyst', 
'Business Analyst')
    AND salary_year_avg is NOT NULL 
ORDER BY 
    salary_year_avg DESC

```
Here's the breakdown of the top jobs in 2023:
- **Wide Salary Range:** Top paying junior analyst roles span from $35,000 to $163,000, with nearly 95% of salaries closer to the lower end.
- **Diverse Employers:** Companies from all sorts of industries offer data jobs for junior analysts. The list includes giants like Amazon.com, Bosch Group, SAP, Ubisoft, and NielsenIQ.
- **Job Title Variety:** There's a high diversity in job titles, from Data consultant to BI Analyst, reflecting varied roles and specializations within data analytics.


### 2. In-Demand Skills for junior Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT skills, count(skills) AS Demand_on_skill 
FROM (With top_jobs AS (SELECT  
        c.name AS company_name,
        job_id,
        job_title, job_location, 
        job_schedule_type, 
        salary_year_avg
FROM 
    job_postings_fact AS j
LEFT JOIN 
    company_dim AS c
ON 
    c.company_id = j.company_id
WHERE  (LOWER(job_title) LIKE '%jr%' 
       OR LOWER(job_title) LIKE '%jnr%' 
       OR LOWER(job_title) LIKE '%jun%' 
       OR LOWER(job_title) LIKE '%entry%level%')
AND job_title_short in ('Data Analyst', 
'Business Analyst')
    AND salary_year_avg is NOT NULL 
ORDER BY 
    salary_year_avg DESC
)
    SELECT company_name,
        job_title, job_location, 
        job_schedule_type, 
        salary_year_avg, skill.skills from top_jobs
    INNER JOIN ( SELECT sj.skill_id, sj.job_id,s.skills  
                from skills_job_dim As sj
                INNER JOIN skills_dim AS s
                ON sj.skill_id = s.skill_id) AS skill 
                ON skill.job_id = top_jobs.job_id)
GROUP BY skills
Order by Demand_on_skill DESC
LIMIT 6
```
Here's the breakdown of the most demanded skills for entry-level analysts in 2023

- **SQL** and **Excel** are fundamental and most in demand, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**,**R**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand  |
|----------|---------|
| SQL      | 122     |
| Excel    | 99      |
| Tableau  | 61      |
| Python   | 58      |
| Power BI | 34      |
| r        | 30      |
*Table of the demand for the top 6 skills in the job postings*

### 3. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT skills, ROUND(AVG(salary_year_avg),1) as average_salary_for_skill
from skills_job_dim AS sj
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id 
INNER JOIN job_postings_fact AS p ON p.job_id = sj.job_id
WHERE 
    (LOWER(job_title) LIKE '%jr%' 
    OR LOWER(job_title) LIKE '%jnr%' 
    OR LOWER(job_title) LIKE '%jun%' 
    OR LOWER(job_title) LIKE '%entry%level%')
    AND job_title_short in ('Data Analyst', 'Business Analyst')
    AND salary_year_avg is NOT NULL
GROUP BY skills
HAVING 
    COUNT(skills) > 10
ORDER BY average_salary_for_skill DESC
```
Here's a breakdown of the results for top paying skills for,Analysts:

**High Demand for Programming Languages:** Analysts skilled in programming languages such as Java, SAS, and JavaScript command the highest average salaries, reflecting the industry's valuation of robust programming capabilities. Java tops the list with an average salary of $85,542.1, followed closely by SAS at $83,461.5 and JavaScript at $80,800.0. These skills are essential for developing complex applications and performing sophisticated data analysis.

**Database and Big Data Proficiency:** Knowledge in database technologies such as Oracle and NoSQL is highly valued, with average salaries of $76,931.8 and $70,153.8 respectively. This underscores the importance of managing and analyzing large datasets efficiently. Skills in SQL Server and SQL, although lower in the ranking, still reflect significant earning potential with average salaries of $65,674.1 and $64,926.8.

**Data Visualization and Reporting Tools:** Proficiency in data visualization tools such as Tableau and Power BI also yields competitive salaries, averaging $66,732.8 and $65,562.6. These tools are critical for transforming data into actionable insights and effectively communicating findings to stakeholders.

**Statistical Analysis and Business Intelligence:** Skills in R and VBA are also in demand, with average salaries of $65,928.3 and $66,356.3. These skills highlight the need for strong statistical analysis and automation capabilities within business intelligence contexts.

**General Software and Productivity Tools:** While skills in general software such as Microsoft Word, Excel, and PowerPoint have lower average salaries, they are still crucial for day-to-day operations. The average salaries for these skills are $69,678.6, $63,640.8, and $63,594.9 respectively. Knowledge of Google Sheets, with an average salary of $62,638.8, also highlights the importance of versatility in different software environments.



Here is the table displaying the top paying skills for analysts along with their average salaries:

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| java          |            85,542.1 |
| sas           |            83,461.5 |
| javascript    |            80,800.0 |
| oracle        |            76,931.8 |
| nosql         |            70,153.8 |
| word          |            69,678.6 |
| python        |            68,292.9 |
| tableau       |            66,732.8 |
| vba           |            66,356.3 |
| r             |            65,928.3 |
| ssrs          |            65,757.2 |
| ssis          |            65,698.9 |
| sql server    |            65,674.1 |
| power bi      |            65,562.6 |
| sql           |            64,926.8 |
| excel         |            63,640.8 |
| powerpoint    |            63,594.9 |
| sheets        |            62,638.8 |
*Table of the average salary for the top paying skills for jr analysts*

### 4. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT skills, COUNT(skills) AS Demand_on_skill, ROUND(AVG(salary_year_avg)) as average_salary_for_skill
from skills_job_dim AS sj
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id 
INNER JOIN job_postings_fact AS p ON p.job_id = sj.job_id
WHERE 
    (LOWER(job_title) LIKE '%jr%' 
    OR LOWER(job_title) LIKE '%jnr%' 
    OR LOWER(job_title) LIKE '%jun%' 
    OR LOWER(job_title) LIKE '%entry%level%')
    AND job_title_short in ('Data Analyst', 'Business Analyst')
    AND salary_year_avg is NOT NULL
GROUP BY skills
HAVING 
    COUNT(skills) > 25
ORDER BY Demand_on_skill DESC, average_salary_for_skill DESC

```

### Analysis of Optimal Skills for Junior Analysts

| Skills  | Demand on Skill | Average Salary ($) |
|---------|-----------------:|-------------------:|
| sql     |              122 |            64,927  |
| excel   |               99 |            63,641  |
| tableau |               61 |            66,733  |
| python  |               58 |            68,293  |
| power bi|               34 |            65,563  |
| r       |               30 |            65,928  |
| sas     |               26 |            83,462  |

#### High Demand and High Salary Skills:
1. **SQL**: With the highest demand at 122 job postings and a competitive average salary of $64,927, SQL is a fundamental skill for data manipulation and querying databases. It is essential for data analysts to interact with large datasets and perform complex queries.

2. **Excel**: Known for its versatility in data analysis, Excel is in high demand (99 postings) with an average salary of $63,641. Proficiency in Excel is crucial for tasks such as data cleaning, analysis, and visualization.

3. **Tableau**: This data visualization tool has a demand of 61 postings and an average salary of $66,733. Tableau is valuable for creating interactive and easy-to-understand dashboards and reports.

4. **Python**: Python's versatility and its application in data analysis, machine learning, and automation make it a high-demand skill (58 postings) with an average salary of $68,293. It is widely used for data manipulation, statistical analysis, and creating data pipelines.

5. **Power BI**: With 34 postings and an average salary of $65,563, Power BI is another powerful data visualization tool. It allows analysts to create reports and dashboards, and integrate data from various sources.

#### Additional Valuable Skills:
- **R**: With 30 postings and an average salary of $65,928, R is essential for statistical analysis and data visualization. It is particularly popular in academic and research settings.
- **SAS**: Although it has a lower demand (26 postings), SAS commands a high average salary of $83,462. It is widely used in industries such as healthcare and finance for advanced analytics and predictive modeling.

# Conclusions:
### Insights
For aspiring junior data analysts or business analysts, focusing on skills like SQL, Excel, Python, Tableau, and Power BI can significantly enhance job prospects and salary potential. These skills are not only in high demand but also offer competitive salaries, making them strategic choices for skill development.



### Closing Thoughts

This project significantly improved my SQL skills and offered valuable insights into the data job market for a fresh graduate. The analysis results act as a guide for prioritizing skill development and job search strategies. By concentrating on high-demand, high-salary skills, young aspiring analysts can enhance their positioning in a competitive job market. This exploration underscores the importance of continuous learning and adapting to emerging trends in data analytics.