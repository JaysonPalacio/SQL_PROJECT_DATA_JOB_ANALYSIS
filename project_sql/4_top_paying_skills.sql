/*
What are the top skills based on salary?
- Looking at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
  skills_dim.skills AS skill, 
  ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
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
  skills
ORDER BY
  avg_salary DESC
LIMIT 25 ;

/*
- High Demand for Advanced AI and Machine Learning Skills
Expertise in machine learning and AI frameworks such as DataRobot, MXNet, Keras, PyTorch, TensorFlow, and Hugging Face is highly valued. 
These skills are critical for developing sophisticated models and algorithms that drive innovation and efficiency in data-driven industries.
- Emphasis on Cloud Infrastructure and Automation Tools
Skills in cloud infrastructure management and automation tools like VMware, Terraform, Puppet, and Ansible are crucial. 
As organizations increasingly migrate to cloud environments, the ability to efficiently manage and automate these systems is essential.
- Importance of NoSQL Databases and Big Data Technologies
Proficiency in NoSQL databases and big data tools, including Couchbase, Cassandra, and Kafka, is highly sought after.
These skills are important for handling large-scale data storage and processing needs, enabling businesses to manage and analyze vast amounts of data effectively.
*/