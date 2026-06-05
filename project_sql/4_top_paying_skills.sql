/*
 Question: What are the top paying skills?
 - Look at the avg salary associated to each skill for Data Analyst positions
 - Focus on roles with specified salaries (Regardless of location)
 This helps understand how different skillsets impact 
 The salary of a Data Analyst 
 */
SELECT skills,
    round(avg(salary_year_avg), 2) as Average_Yearly_Salary
from job_postings_fact as jobs
    inner JOIN skills_job_dim as skills_to_job ON jobs.job_id = skills_to_job.job_id
    inner JOIN skills_dim as skills ON skills.skill_id = skills_to_job.skill_id
WHERE jobs.job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL -- and jobs.job_work_from_home = true -- If I wanted only remove working jobs
group by skills
order BY Average_Yearly_Salary desc
limit 25
    /*
     
     -- This query identifies the highest-paying skills for 
     Data Analysts by calculating the average salary a
     ssociated with each skill. The results reveal that 
     advanced data engineering, machine learning, cloud, 
     and DevOps technologies command the highest 
     compensation, highlighting the growing demand for 
     analysts who can work beyond traditional reporting 
     and contribute to scalable data and AI solutions.
     
     Data from this Query: 
     
     [
     {
     "skills": "pyspark",
     "average_yearly_salary": "208172.25"
     },
     {
     "skills": "bitbucket",
     "average_yearly_salary": "189154.50"
     },
     {
     "skills": "couchbase",
     "average_yearly_salary": "160515.00"
     },
     {
     "skills": "watson",
     "average_yearly_salary": "160515.00"
     },
     {
     "skills": "datarobot",
     "average_yearly_salary": "155485.50"
     },
     {
     "skills": "gitlab",
     "average_yearly_salary": "154500.00"
     },
     {
     "skills": "swift",
     "average_yearly_salary": "153750.00"
     },
     {
     "skills": "jupyter",
     "average_yearly_salary": "152776.50"
     },
     {
     "skills": "pandas",
     "average_yearly_salary": "151821.33"
     },
     {
     "skills": "elasticsearch",
     "average_yearly_salary": "145000.00"
     },
     {
     "skills": "golang",
     "average_yearly_salary": "145000.00"
     },
     {
     "skills": "numpy",
     "average_yearly_salary": "143512.50"
     },
     {
     "skills": "databricks",
     "average_yearly_salary": "141906.60"
     },
     {
     "skills": "linux",
     "average_yearly_salary": "136507.50"
     },
     {
     "skills": "kubernetes",
     "average_yearly_salary": "132500.00"
     },
     {
     "skills": "atlassian",
     "average_yearly_salary": "131161.80"
     },
     {
     "skills": "twilio",
     "average_yearly_salary": "127000.00"
     },
     {
     "skills": "airflow",
     "average_yearly_salary": "126103.00"
     },
     {
     "skills": "scikit-learn",
     "average_yearly_salary": "125781.25"
     },
     {
     "skills": "jenkins",
     "average_yearly_salary": "125436.33"
     },
     {
     "skills": "notion",
     "average_yearly_salary": "125000.00"
     },
     {
     "skills": "scala",
     "average_yearly_salary": "124903.00"
     },
     {
     "skills": "postgresql",
     "average_yearly_salary": "123878.75"
     },
     {
     "skills": "gcp",
     "average_yearly_salary": "122500.00"
     },
     {
     "skills": "microstrategy",
     "average_yearly_salary": "121619.25"
     }
     ]
     
     */