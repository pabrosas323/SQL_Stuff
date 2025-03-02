/*
1. What are the top-paying skills for my role?
2. What are the skills required for this role?
3. What are the most in-demand skills for this role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
    a. Optimal: high-demand and high-paying

*/

WITH job_skills AS (
    SELECT
        skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skill_id
    
)

SELECT
    job_skills.skill_id,
    skills AS skill_name,
    avg_salary
FROM
    job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = job_skills.skill_id
ORDER BY
    avg_salary DESC
LIMIT 10;

/*
Insights:
 - AI, Machine Learning & Big Data Dominate – High salaries for skills
  like DataRobot, MXNet, Keras, PyTorch, TensorFlow, Hugging Face, 
  and Kafka highlight the growing demand for AI-driven analytics.

 - Cloud, DevOps & Automation Are Increasingly Valuable – Skills like 
 Terraform, Ansible, Puppet, GitLab, and Airflow 
 show that modern data analysts benefit from cloud infrastructure, automation, and workflow orchestration.

 - Blockchain, NoSQL & Legacy Tech Offer Niche Opportunities – Solidity (crypto), 
 Couchbase & Cassandra (NoSQL), Perl & SVN (legacy systems)
  demonstrate that specialized expertise in emerging or older technologies can lead to high salaries.
*/
