
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

/*
    Quick Insights:
SQL and Python lead the pack—confirming their foundational role in data analysis.

BI tools (Tableau, Power BI) are also prominent, highlighting the need for data visualization.

A mix of database (MongoDB, Oracle, SAP) and cloud/big data (Spark, Azure) skills also appears.
*/