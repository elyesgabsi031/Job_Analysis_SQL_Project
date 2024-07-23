-- First Question : What are the top paying Jobs for my role?

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
WHERE 
    (job_title like '%Junior%Analyst%' OR 
    job_title like '%Jr%Analyst%')
    AND salary_year_avg is NOT NULL 
ORDER BY 
    salary_year_avg DESC


