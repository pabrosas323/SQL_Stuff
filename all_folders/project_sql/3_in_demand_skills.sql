/*
1. What are the top-paying jobs for my role?
2. What are the skills required for these top paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the optimal skills to learn?
    a. Optimal: high-demand skills
*/

/*
- Join job postings to skill_job_dim table
- identify top 10 in demand skills for data analysts
- Focus on all job postings
*/

WITH job_skills AS (
    SELECT
        DISTINCT skill_id,
        COUNT(skill_id) as skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
    
)

SELECT
    skills AS skill_name,
    skill_count
FROM
    job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 11;