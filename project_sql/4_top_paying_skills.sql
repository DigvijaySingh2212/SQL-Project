/*
Answer: What are the top skills based on salary?
- look at the avg salary associated with each skill for Data Analyst position
- Focuses on the roles with the specified salaries, Location India
- Why? Reveals how different skills impact salary levels for Data Analyst and 
    identify the most financialy rewarding skills to acquire or improve
*/

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

/*
1. Dominance of Database Skills at the Top
-The highest paying skills (₹165,000) are SQL Server, MongoDB (including "mongo"), MySQL, and PostgreSQL.
-These are core database technologies, suggesting that strong database expertise is highly valued.

2. Cloud and Big Data Skills are Highly Rewarded
-Tools like Spark, Azure, AWS, Hadoop show avg salaries in the ₹122k–₹123k range.
-Indicates a premium for cloud platforms and distributed computing—a key trend in modern data infrastructures.

3. BI and Visualization Tools Pay Well
-Power BI, Looker, DAX show strong salaries (₹111k–₹116k), reinforcing the demand for data storytelling and dashboarding skills.
-Suggests that visualization is a crucial skill set alongside technical analysis.

4. Engineering/DevOps Tools Feature Prominently
-Tools like Docker, Kubernetes, Git, GitHub appear with good salaries (₹102k–₹111k).
-Highlights a trend where data analysts benefit from CI/CD and software engineering practices.

5. Even Basic Tools Matter
-Tools like PowerPoint, Sheets, Slack still appear, though at the lower end of this list (around ₹102k–₹105k), 
showing that communication and collaboration tools are part of the analyst workflow.

*/

