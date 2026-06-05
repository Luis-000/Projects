/*
 Question: What're the most indemand Skills for Data Analysts?
 - Join job postings to inner join table similar to Query 2
 - Identify the top 5 in demand skills for a data analyst
 - Focus on all job postings.
 By doing this we provide insights into what're the most
 valuable skills to develop in order to get a job
 */
SELECT skills,
    count(skills_to_job.job_id) as Demand_Count
from job_postings_fact as jobs
    inner JOIN skills_job_dim as skills_to_job ON jobs.job_id = skills_to_job.job_id
    inner JOIN skills_dim as skills ON skills.skill_id = skills_to_job.skill_id
WHERE jobs.job_title_short = 'Data Analyst' --  AND jobs.job_work_from_home = true -- If I wanted only remove working jobs
group by skills
order BY Demand_Count desc
limit 5