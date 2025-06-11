/*
Questions: What are the most in demand skills for data analyst?
 - Join job posting to inner join table similar query 2
 - Identify the top 5 in demand skills for data analyst
 - Focus on all job postings.
 - Why? Retrieve the top 5 skills with the highest demand in the job market,
  providing inights into the most valuabe skills for job seekers.
*/


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
