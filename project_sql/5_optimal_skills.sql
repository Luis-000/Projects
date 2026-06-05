/*
 Question: What are the most optimal skills (High-demand + High-pay)to develop?
 - Identify skills associated to high-demand and high-paying jobs for data analysts
 - Filter for remote positions with specified salaries
 This targets skills that provide higher security (due to demand) and financial benefits (Higher salaries)
 Offers valuable insights on course of action
 */
WITH skills_demand as (
    SELECT skills.skill_id,
        skills.skills,
        count(skills_to_job.job_id) as Demand_Count
    from job_postings_fact as jobs
        inner JOIN skills_job_dim as skills_to_job ON jobs.job_id = skills_to_job.job_id
        inner JOIN skills_dim as skills ON skills.skill_id = skills_to_job.skill_id
    WHERE jobs.job_title_short = 'Data Analyst'
        and salary_year_avg is not NULL
        AND jobs.job_work_from_home = true -- If I wanted only remove working jobs
    group by skills.skill_id
),
average_salary as (
    SELECT skills.skill_id,
        skills.skills,
        round(avg(salary_year_avg), 2) as Average_Yearly_Salary
    from job_postings_fact as jobs
        inner JOIN skills_job_dim as skills_to_job ON jobs.job_id = skills_to_job.job_id
        inner JOIN skills_dim as skills ON skills.skill_id = skills_to_job.skill_id
    WHERE jobs.job_title_short = 'Data Analyst'
        and salary_year_avg is not NULL
        and jobs.job_work_from_home = true -- If I wanted only remove working jobs
    group by skills.skill_id
)
select skills_demand.skill_id,
    skills_demand.skills,
    Demand_Count,
    Average_Yearly_Salary
from skills_demand
    inner join average_salary on average_salary.skill_id = skills_demand.skill_id
WHERE Demand_Count > 10
ORDER BY Average_Yearly_Salary desc,
    Demand_Count desc
LIMIT 25