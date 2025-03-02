/*

Question: What are the top-paying data analyst jobs?
    - Identify the top 10 highest-paying Data Analyst roles that are available remotely.
    - Focuses on job postings with specified salaries (remove nulls).
    - Why? Highlight the top-paying opportunities for DAta Analysts.

*/

SELECT
    job_id,
    job_title,
    name AS company_name, -- comes from company dim table
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact

LEFT JOIN company_dim -- including company_dim data to grab company name
    ON job_postings_fact.company_id  = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home IS TRUE -- checking for remote jobs
    AND salary_year_avg IS NOT NULL 

ORDER BY
    salary_year_avg DESC -- ordering from greatest to least

LIMIT 10; -- looking at only the top 10 roles
