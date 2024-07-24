-- Query 4: Most optimal skills to learn for my role ? (high pay, high demand)


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