# Data Analyst Job Market Analysis — SQL Project

## Introduction

This project dives into the data analyst job market using SQL to uncover what skills are most in demand, which ones pay the best, and where the two intersect. The goal was to answer a practical question: _if you want to become a data analyst, what should you actually focus on learning?_

The analysis was built entirely in SQL, querying a real-world dataset of job postings to extract meaningful insights about salaries, skill demand, and optimal skills to develop.

SQL queries -> [project_sql foler](/project_sql/)

---

## Background

As someone working toward breaking into data analytics, I wanted to go beyond just learning SQL syntax — I wanted to use it to answer a question that directly affects my own career decisions. This project was a way to practice SQL while simultaneously researching the field I'm trying to enter.

The dataset used contains job postings from across the industry, including job titles, salaries, required skills, company names, and posting dates. All queries were written and tested in PostgreSQL via VS Code.

---

## Tools Used

- **PostgreSQL** — the database engine used to run all queries
- **VS Code** with the SQL extension — for writing and executing queries
- **GitHub** — for version control and sharing the project

---

## Analysis

The project was structured around five core questions, each answered with a dedicated SQL query:

### 1. Top Paying Data Analyst Jobs

Identified the top 10 highest-paying remote Data Analyst roles by filtering for non-null salaries and sorting by average yearly salary. This gave a clear picture of the salary ceiling in the field and which companies are willing to pay the most.

```sql
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
```

### 2. Skills Behind the Top Paying Jobs

Built on the first query using a CTE to join skill data onto the top-paying job results. This revealed what technical skills the best-paid roles actually require — moving beyond job titles to the real requirements.

```sql
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
```

### 3. Most In-Demand Skills

Used JOINs across three tables to count how many job postings list each skill, identifying the top 5 most requested skills across all Data Analyst postings. This highlights what employers are consistently looking for regardless of salary.

```sql
SELECT skills,
    count(skills_to_job.job_id) as Demand_Count
from job_postings_fact as jobs
    inner JOIN skills_job_dim as skills_to_job ON jobs.job_id = skills_to_job.job_id
    inner JOIN skills_dim as skills ON skills.skill_id = skills_to_job.skill_id
WHERE jobs.job_title_short = 'Data Analyst' --  AND jobs.job_work_from_home = true -- If I wanted only remove working jobs
group by skills
order BY Demand_Count desc
limit 5
```

### 4. Top Paying Skills

Calculated the average yearly salary associated with each skill across Data Analyst roles. The results showed that niche technical skills — particularly in data engineering, machine learning, and cloud platforms — command significantly higher salaries than traditional analyst tools.

```sql
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
```

### 5. Optimal Skills (High Demand + High Pay)

Combined queries 3 and 4 using two CTEs joined together, filtering for skills with over 10 job postings to ensure statistical relevance. This final query answers the core question: which skills are both frequently requested _and_ well compensated?

```sql
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
```

![Top Paying Roles](/assets/25%20highest%20paying%20skills%20-%20Horizontal%20graph%20chart.png)

- Horizontal Graph Chart of the highest paying skills for Data Analysts
-

| Priority | Skill Area         | Reason                                     |
| -------- | ------------------ | ------------------------------------------ |
| 1        | SQL                | Required in every top-paying role          |
| 2        | Python             | Nearly universal among high earners        |
| 3        | Tableau / Power BI | Most common business-facing tools          |
| 4        | Snowflake          | Strong presence in modern analytics stacks |
| 5        | AWS / Azure        | Associated with higher average salaries    |
| 6        | Pandas & NumPy     | Enables advanced analytics and automation  |
| 7        | Databricks         | Emerging premium skill in data platforms   |

| Competency Area   | Evidence                                                |
| ----------------- | ------------------------------------------------------- |
| SQL Mastery       | Appears in 100% of highest-paying jobs                  |
| Programming       | Python appears in 87.5% of jobs                         |
| Visualization     | Tableau appears in 75% of jobs                          |
| Cloud Knowledge   | AWS/Azure frequently appear in the highest salary tiers |
| Modern Data Stack | Snowflake and Databricks are recurring technologies     |
| Analytics Depth   | R, Pandas, NumPy indicate advanced analytical work      |

---

## Knowledge Acquired

Through this project I strengthened my understanding of several key SQL concepts:

- **JOINs** — including LEFT, INNER, and multi-table joins across related tables
- **CTEs (Common Table Expressions)** — using `WITH` clauses to break complex queries into readable, reusable parts
- **Aggregate functions** — `COUNT()`, `AVG()`, `ROUND()` and understanding when `GROUP BY` is required
- **CASE statements** — for categorising data conditionally within a query
- **Subqueries and filtering** — using `WHERE`, `IS NOT NULL`, and date filtering to clean results
- **Window functions and date extraction** — using `EXTRACT()` and `AT TIME ZONE` for time-based analysis
- **Query structure and debugging** — learning to read SQL error messages and fix issues around aliases, clause ordering, and syntax

---

## Conclusion

This project reinforced that SQL is a genuinely powerful tool for answering real questions — not just a box to tick on a CV. The final analysis points to a clear takeaway: the most valuable skills for a Data Analyst in today's market sit at the intersection of traditional data work and modern data engineering. Tools like Python (pandas, PySpark), cloud platforms (GCP, Databricks), and workflow tools (Airflow) consistently appear in both the high-demand and high-salary categories.

For anyone on a similar path, the data suggests that going beyond Excel and basic SQL — and picking up at least one programming language and one cloud platform — meaningfully increases both your employability and your earning potential.
