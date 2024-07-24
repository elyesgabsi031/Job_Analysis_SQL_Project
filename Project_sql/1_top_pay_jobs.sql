-- Query1: What are the top paying Jobs for my role? (Entry level Analyst)

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



