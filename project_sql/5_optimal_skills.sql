/*
What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst?
- skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
 offering strategic insights for career development in data analysis
*/


SELECT
    skills_dim.skill_id,
	skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg) , 0) AS avg_salary
FROM
    job_postings_fact
	INNER JOIN
	skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN
	skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;


/*
-Cloud and Big Data Technologies: Snowflake, Azure, AWS, and Hadoop are in high demand, 
reflecting the importance of cloud computing and big data processing in data analysis.
-Programming Languages: Python, Java, R, and JavaScript are essential, underscoring their role in data manipulation and analysis.
-Data Visualization and BI Tools: Tableau, Looker, and Qlik indicate the significance of data visualization and business intelligence in deriving actionable insights.

Additional observations include the importance of database management systems, data integration tools like SSIS, 
and project management tools like Jira and Confluence.

In summary, expertise in cloud computing, programming, data visualization, 
and project management are crucial for success in data analysis roles.
*/
WITH skill_data AS (
    SELECT 8 AS skill_id, 'go' AS skills, 27 AS demand_count, 115320 AS avg_salary
    UNION ALL SELECT 234, 'confluence', 11, 114210
    UNION ALL SELECT 97, 'hadoop', 22, 113193
    UNION ALL SELECT 80, 'snowflake', 37, 112948
    UNION ALL SELECT 74, 'azure', 34, 111225
    UNION ALL SELECT 77, 'bigquery', 13, 109654
    UNION ALL SELECT 76, 'aws', 32, 108317
    UNION ALL SELECT 4, 'java', 17, 106906
    UNION ALL SELECT 194, 'ssis', 12, 106683
    UNION ALL SELECT 233, 'jira', 20, 104918
    UNION ALL SELECT 79, 'oracle', 37, 104534
    UNION ALL SELECT 185, 'looker', 49, 103795
    UNION ALL SELECT 2, 'nosql', 13, 101414
    UNION ALL SELECT 1, 'python', 236, 101397
    UNION ALL SELECT 5, 'r', 148, 100499
    UNION ALL SELECT 78, 'redshift', 16, 99936
    UNION ALL SELECT 187, 'qlik', 13, 99631
    UNION ALL SELECT 182, 'tableau', 230, 99288
    UNION ALL SELECT 197, 'ssrs', 14, 99171
    UNION ALL SELECT 92, 'spark', 13, 99077
    UNION ALL SELECT 13, 'c++', 11, 98958
    UNION ALL SELECT 186, 'sas', 63, 98902
    UNION ALL SELECT 7, 'sas', 63, 98902
    UNION ALL SELECT 61, 'sql server', 35, 97786
    UNION ALL SELECT 9, 'javascript', 20, 97587
)
SELECT skills, REPEAT('#', demand_count / 5) AS bar, demand_count
FROM skill_data
ORDER BY demand_count DESC;
