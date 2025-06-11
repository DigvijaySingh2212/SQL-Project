/*
Answer: What are the most optimal skills to learn(i.e its in high demand and high-paying skill)?
    - Identify skills in high demand and associated with high average salaries for Data Analyst roles
    - Why? targets skills that offer job security(high demand) and finacial benefits(High salaries),
     offering stratergic insights for career development in data analysis\
*/

WITH skills_demand AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
      count(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst' AND
      job_location = 'Bengaluru, Karnataka, India' AND
      salary_year_avg IS NOT NULL
GROUP BY  
      skills_dim.skill_id
), average_salary as (
SELECT 
    skills_job_dim.skill_id,
      Round(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL AND
      job_location = 'Bengaluru, Karnataka, India'
GROUP BY  
      skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE 
    demand_count>2
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25

-- rewriting this query in consice manner

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
    