# Introduction
Welcome to my SQL Portfolio Project, where I delve into the data job market with a focus on data analyst roles. This project is a personal exploration into identifying the top-paying jobs, in-demand skills, and the intersection of high demand with high salary in the field of data analytics.

Check out my SQL queries here: [project_sql folder](/project_sql/)
# Background
The motivation behind this project stemmed from my desire to understand the data analyst job market better. I aimed to discover which skills are paid the most and in demand, making my job search more targeted and effective. 

The data for this analysis is from Luke Barousse’s SQL Course . This data includes details on job titles, salaries, locations, and required skills. 

The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for a data analyst looking to maximize job market value?

# Tools I Used
In this project, I utilized a variety of tools to conduct my analysis:

- **SQL** (Structured Query Language): Enabled me to interact with the database, extract insights, and answer my key questions through queries.
- **PostgreSQL**: As the database management system, PostgreSQL allowed me to store, query, and manipulate the job posting data.
- **Visual Studio Code:** This open-source administration and development platform helped me manage the database and execute SQL queries.

# The Analysis
Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:
### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE
    job_title = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

 Variety of High-Paying Roles

1. Salaries range from $650,000 for a Data Analyst at Mantys to $184,000 for an ERM Data Analyst at Get It Recruit. Higher-level positions like Director of Analytics at Meta ($336,500) and Associate Director-Data Insights at AT&T ($255,829.5) command higher salaries.
Flexibility in Job Location

2. All jobs are remote or hybrid, indicating a strong trend towards flexible work arrangements.
Industry Diversity

3. Employers include Meta, AT&T, Pinterest, UCLA Health, and SmartAsset, showing demand for data analysis across tech, healthcare, finance, and marketing.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
-- Gets the top 10 paying Data Analyst jobs

```
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM
    top_paying_jobs
    INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;
```

1. Top positions include Associate Director-Data Insights at AT&T ($255,829.5) and Data Analyst, Marketing at Pinterest ($232,423). Salaries vary based on skills, such as SQL, Python, R, Tableau, and Azure.
Common Skill Requirements

2. SQL, Python, R, Tableau, and Azure are frequently mentioned skills, indicating their high demand in data analyst roles.
Diverse Company Representation

3. Companies hiring include AT&T, Pinterest, UCLA Healthcare, SmartAsset, and Inclusively, showing a wide industry demand for data analytics.

### 3.In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```
SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
  INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
  skills_dim.skills
ORDER BY
  demand_count DESC
LIMIT 5;
```

```
Skills Demand:
SQL      | ██████████████████████████████████████████████████████ 7291
Excel    | ██████████████████████████████████████ 4611
Python   | █████████████████████████████████ 4330
Tableau  | ████████████████████████████ 3745
Power BI | ████████████████████ 2609
```
SQL (7,291) leads in skill demand for data analyst roles, followed by Excel (4,611) and Python (4,330). Tableau (3,745) and Power BI (2,609) also show substantial demand. These skills are essential for data analysts across various industries.

### 4. Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```
SELECT
  skills_dim.skills AS skill,
  ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM
  job_postings_fact
INNER JOIN
  skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
  skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
  AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
  skills_dim.skills
ORDER BY
  avg_salary DESC;
```

1. High Demand for Advanced AI and Machine Learning Skills
Expertise in machine learning and AI frameworks such as DataRobot, MXNet, Keras, PyTorch, TensorFlow, and Hugging Face is highly valued. 
These skills are critical for developing sophisticated models and algorithms that drive innovation and efficiency in data-driven industries.
2. Emphasis on Cloud Infrastructure and Automation Tools
Skills in cloud infrastructure management and automation tools like VMware, Terraform, Puppet, and Ansible are crucial. 
As organizations increasingly migrate to cloud environments, the ability to efficiently manage and automate these systems is essential.
3. Importance of NoSQL Databases and Big Data Technologies
Proficiency in NoSQL databases and big data tools, including Couchbase, Cassandra, and Kafka, is highly sought after.
These skills are important for handling large-scale data storage and processing needs, enabling businesses to manage and analyze vast amounts of data effectively.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```
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
```
1. Cloud and Big Data Technologies: Snowflake, Azure, AWS, and Hadoop are in high demand, 
reflecting the importance of cloud computing and big data processing in data analysis.
2. Programming Languages: Python, Java, R, and JavaScript are essential, underscoring their role in data manipulation and analysis.
3. Data Visualization and BI Tools: Tableau, Looker, and Qlik indicate the significance of data visualization and business intelligence in deriving actionable insights.

Additional observations include the importance of database management systems, data integration tools like SSIS, 
and project management tools like Jira and Confluence.

In summary, expertise in cloud computing, programming, data visualization, 
and project management are crucial for success in data analysis roles.

# What I Learned
Throughout this project, I honed several key SQL techniques and skills:

- **Complex Query Construction**: Learning to build advanced SQL queries that combine multiple tables and employ functions like **`WITH`** clauses for temporary tables.
- **Data Aggregation**: Utilizing **`GROUP BY`** and aggregate functions like **`COUNT()`** and **`AVG()`** to summarize data effectively.
- **Analytical Thinking**: Developing the ability to translate real-world questions into actionable SQL queries that got insightful answers.

# Conclusions
### **Insights**

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.


This project really helped me improve my SQL skills and gave me a lot of useful information about the data analyst job market. By analyzing the data, I discovered which skills are most in demand and which ones offer the highest salaries. This can really help aspiring data analysts, like me, to focus on developing the right skills and searching for jobs more effectively. This project also showed me how important it is to keep learning and stay updated with the latest trends in data analytics.