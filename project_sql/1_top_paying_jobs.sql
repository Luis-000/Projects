/*
 Question: What are the top paying Data Analyst Jobs?
 - Identify the top 10 highest-paying Data Analyst jobs that are available remotely;
 - Focuses on job postings with specified salaries (Ignore Nulls)
 - Highlight the top-paying opportunities for Data Analysts. 
 
 */
SELECT job_id,
    job_title,
    companies.name as company_name,
    salary_year_avg as yearly_salary,
    job_location,
    job_schedule_type,
    job_posted_date
from job_postings_fact as jobs
    LEFT JOIN company_dim as companies ON companies.company_id = jobs.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg is not null
ORDER BY salary_year_avg desc
limit 10