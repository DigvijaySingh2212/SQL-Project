# Introduction
Dived into the data job market! Focusing on data analyst role in India, this project explore whats the 💰 top paying jobs, 🔥 in-demand skill(in top paying jobs), and where 📈 high demand is meeting the high monetary perks in Data Analytics.


🔍 SQl Queries? Check them out here:[project_sql folder](/project_sql/)

#  Background
Driven by quest to find out Data Anaylst job market in India more effectively, this project was born from desire to pinpoint 💰top-paid and 📈in-demand skills.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are mos in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

#  Tools I Used
For deep dive into Data Analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and uncover critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

#  The Analysis
### 1. Top Paying Data Analyst Jobs
To identify the highest-paying rolesI I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND
    job_location = 'Bengaluru, Karnataka, India' and 
    salary_year_avg is not NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name as company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst' AND
        job_location = 'Bengaluru, Karnataka, India' and 
        salary_year_avg is not NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10 
)

SELECT 
    top_paying_jobs.*,
    skills
from top_paying_jobs
INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
    Quick Insights:
- SQL and Python lead the pack—confirming their foundational role in data analysis.

- BI tools (Tableau, Power BI) are also prominent, highlighting the need for data visualization.

- A mix of database (MongoDB, Oracle, SAP) and cloud/big data (Spark, Azure) skills also appears.

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to the areas with high demand.

```sql
SELECT 
      skills,
      count(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst' AND
      job_location = 'Bengaluru, Karnataka, India'
GROUP BY  
      skills
ORDER BY
      demand_count DESC
limit 5
```
**Insights**
| Skill   | Demand Count |
| ------- | ------------ |
| SQL     | 240          |
| Python  | 205          |
| Tableau | 120          |
| R       | 110          |
| SAS     | 92           |

### 4. Skills based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
      skills,
      Round(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL AND
      job_location = 'Bengaluru, Karnataka, India'
GROUP BY  
      skills
ORDER BY
      avg_salary DESC
limit 25
```
**Insights**
| Rank | Skill      | Average Salary (INR) |
| ---- | ---------- | -------------------- |
| 1    | SQL Server | ₹16,50,000           |
| 2    | Mongo      | ₹16,50,000           |
| 3    | MongoDB    | ₹16,50,000           |
| 4    | MySQL      | ₹16,50,000           |
| 5    | PostgreSQL | ₹16,50,000           |
| 6    | Spark      | ₹12,32,580           |
| 7    | Azure      | ₹12,32,580           |
| 8    | AWS        | ₹12,21,000           |
| 9    | Hadoop     | ₹12,21,000           |
| 10   | Oracle     | ₹11,85,000           |

### 5. Most Optimal Skills to Learn
Combining inisghts from demand and salary data, this query aimed to pinpoint skills that are both high paying and high demand, offering a strategic focus for skills development.
```sql
SELECT  
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL AND
      job_location = 'Bengaluru, Karnataka, India'
GROUP BY
    skills_dim.skill_id
Having
    count(skills_job_dim.job_id) >= 2
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
***Insights**\
| Rank | Skill      | Demand Count | Avg. Salary (INR) |
| ---- | ---------- | ------------ | ----------------- |
| 1    | Azure      | 3            | ₹12,32,580        |
| 2    | Spark      | 3            | ₹12,32,580        |
| 3    | AWS        | 2            | ₹12,21,000        |
| 4    | Hadoop     | 2            | ₹12,21,000        |
| 5    | Oracle     | 4            | ₹11,85,000        |
| 6    | Power BI   | 4            | ₹11,66,380        |
| 7    | Redshift   | 3            | ₹10,78,000        |
| 8    | SAP        | 4            | ₹10,50,440        |
| 9    | PowerPoint | 2            | ₹10,23,880        |
| 10   | SQL        | 12           | ₹10,13,650        |



#  What I Learned
As someone completely new to SQL, this project was a hands-on introduction to writing and understanding SQL queries. I learned how to extract insights from a relational database by performing joins, using aggregate functions, filtering data, and structuring nested queries. By exploring real-world data related to data analyst jobs in India, I gained confidence in querying databases to uncover trends like high-paying roles and in-demand skills. This project not only helped me understand the technical side of SQL but also how it can be used to drive data-driven career decisions.

#  Conclusion 
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis  serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.