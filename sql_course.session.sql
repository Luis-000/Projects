select quarter1_job_postings.job_title_short,
    quarter1_job_postings.salary_year_avg,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::Date
from (
        SELECT *
        from january_jobs
        union all
        SELECT *
        from february_jobs
        union all
        SELECT *
        from march_jobs
    ) as quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg > 70000
    AND quarter1_job_postings.job_title_short = 'Data Analyst'
order BY quarter1_job_postings.salary_year_avg DESC