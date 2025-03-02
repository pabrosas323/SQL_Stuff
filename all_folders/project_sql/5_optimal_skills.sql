/*
What are the most optimal skills to learn? (AKA what is the most in-demand and highest paying skills?)
 - Identify skills in high demand and associated with high average salaries for Data Analyst roles?
 - Concentrates on remote positions with specified salaries
*/


WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills AS skill_name,
        COUNT(skills_job_dim.skill_id) as skill_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
         AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills AS skill_name,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skill_name,
    skill_count,
    avg_salary

FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id

WHERE
    skill_count > 10 -- did this to limit the number of high paying but low count skills
ORDER BY
    avg_salary DESC, 
    skill_count DESC

