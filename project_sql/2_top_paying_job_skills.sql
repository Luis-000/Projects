/*
 Question: Required skills for the top paying Data Analyst jobs
 - Use the top 10 highest paying Data Analyst jobs from the 1st query
 - Add the required skills' values for these jobs
 - This provides a detailed look at which high-paying jobs demand certain skills
 Which helps job seekers to understand most important skills to develop 
 */
with top_paying_jobs as (
    SELECT job_id,
        job_title,
        companies.name as company_name,
        salary_year_avg as yearly_salary,
        job_posted_date
    from job_postings_fact as jobs
        LEFT JOIN company_dim as companies ON companies.company_id = jobs.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg is not null
    ORDER BY salary_year_avg desc
    limit 10
)
select top_paying_jobs.*,
    skills.skills as skills
from top_paying_jobs
    inner JOIN skills_job_dim as skills_to_job ON top_paying_jobs.job_id = skills_to_job.job_id
    inner JOIN skills_dim as skills ON skills.skill_id = skills_to_job.skill_id
order BY yearly_salary DESC
    /*
     
     -- By analyzing the skills associated with the 
     highest-paying Data Analyst jobs, this query 
     identifies the technologies most frequently linked to 
     premium compensation. The results show that SQL, 
     Python, and Tableau form the foundational skill stack 
     for elite Data Analyst roles, while cloud and modern 
     data platform expertise provide additional salary 
     advantages.
     
     Results from the Query --->
     [
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "sql"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "python"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "r"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "azure"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "databricks"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "aws"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "pandas"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "pyspark"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "jupyter"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "excel"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "tableau"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "power bi"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "company_name": "AT&T",
     "yearly_salary": "255829.5",
     "job_posted_date": "2023-06-18 16:03:12",
     "skills": "powerpoint"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "company_name": "Pinterest Job Advertisements",
     "yearly_salary": "232423.0",
     "job_posted_date": "2023-12-05 20:00:40",
     "skills": "sql"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "company_name": "Pinterest Job Advertisements",
     "yearly_salary": "232423.0",
     "job_posted_date": "2023-12-05 20:00:40",
     "skills": "python"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "company_name": "Pinterest Job Advertisements",
     "yearly_salary": "232423.0",
     "job_posted_date": "2023-12-05 20:00:40",
     "skills": "r"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "company_name": "Pinterest Job Advertisements",
     "yearly_salary": "232423.0",
     "job_posted_date": "2023-12-05 20:00:40",
     "skills": "hadoop"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "company_name": "Pinterest Job Advertisements",
     "yearly_salary": "232423.0",
     "job_posted_date": "2023-12-05 20:00:40",
     "skills": "tableau"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "company_name": "Uclahealthcareers",
     "yearly_salary": "217000.0",
     "job_posted_date": "2023-01-17 00:17:23",
     "skills": "sql"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "company_name": "Uclahealthcareers",
     "yearly_salary": "217000.0",
     "job_posted_date": "2023-01-17 00:17:23",
     "skills": "crystal"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "company_name": "Uclahealthcareers",
     "yearly_salary": "217000.0",
     "job_posted_date": "2023-01-17 00:17:23",
     "skills": "oracle"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "company_name": "Uclahealthcareers",
     "yearly_salary": "217000.0",
     "job_posted_date": "2023-01-17 00:17:23",
     "skills": "tableau"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "company_name": "Uclahealthcareers",
     "yearly_salary": "217000.0",
     "job_posted_date": "2023-01-17 00:17:23",
     "skills": "flow"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "sql"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "python"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "go"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "snowflake"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "pandas"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "numpy"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "excel"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "tableau"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "company_name": "SmartAsset",
     "yearly_salary": "205000.0",
     "job_posted_date": "2023-08-09 11:00:01",
     "skills": "gitlab"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "sql"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "python"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "azure"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "aws"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "oracle"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "snowflake"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "tableau"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "power bi"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "sap"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "jenkins"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "bitbucket"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "atlassian"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "jira"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "company_name": "Inclusively",
     "yearly_salary": "189309.0",
     "job_posted_date": "2023-12-07 15:00:13",
     "skills": "confluence"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "sql"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "python"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "r"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "git"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "bitbucket"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "atlassian"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "jira"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "company_name": "Motional",
     "yearly_salary": "189000.0",
     "job_posted_date": "2023-01-05 00:00:25",
     "skills": "confluence"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "sql"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "python"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "go"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "snowflake"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "pandas"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "numpy"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "excel"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "tableau"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "company_name": "SmartAsset",
     "yearly_salary": "186000.0",
     "job_posted_date": "2023-07-11 16:00:05",
     "skills": "gitlab"
     },
     {
     "job_id": 387860,
     "job_title": "ERM Data Analyst",
     "company_name": "Get It Recruit - Information Technology",
     "yearly_salary": "184000.0",
     "job_posted_date": "2023-06-09 08:01:04",
     "skills": "sql"
     },
     {
     "job_id": 387860,
     "job_title": "ERM Data Analyst",
     "company_name": "Get It Recruit - Information Technology",
     "yearly_salary": "184000.0",
     "job_posted_date": "2023-06-09 08:01:04",
     "skills": "python"
     },
     {
     "job_id": 387860,
     "job_title": "ERM Data Analyst",
     "company_name": "Get It Recruit - Information Technology",
     "yearly_salary": "184000.0",
     "job_posted_date": "2023-06-09 08:01:04",
     "skills": "r"
     }
     ]
     
     */