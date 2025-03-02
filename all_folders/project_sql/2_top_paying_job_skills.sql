/*
Questions to Answer:
    - What are the top-paying skills for my role?
    - What are the skills required for these top paying roles?
    - What are the most in-demand skills for my role?
    - What are the top skills based on salary for my role?
    - What are the most optimal skills to learn?
*/
WITH top_paying_jobs AS (
    SELECT
       job_id,
        job_title,
        job_title_short,
        name AS company_name, -- comes from company dim table
        salary_year_avg
    FROM 
    job_postings_fact

LEFT JOIN company_dim -- including company_dim data to grab company name
    ON job_postings_fact.company_id  = company_dim.company_id


WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home IS TRUE -- checking for remote jobs
    AND salary_year_avg IS NOT NULL
)

SELECT 
    top_paying_jobs.*,
    skills AS job_skills

FROM 
    top_paying_jobs
LEFT JOIN skills_job_dim -- including company_dim data to grab company name
    ON top_paying_jobs.job_id = skills_job_dim.job_id -- joining these tables in order to get skill id 
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id -- we can then connect skill id to corresponding skill name

ORDER BY
    salary_year_avg DESC -- ordering from greatest to least

LIMIT 10;