

/* Exploratory Data Analysis for Call Center Dataset
Data source: https://data.world/markbradbourne/rwfd-real-world-fake-data/workspace/file?filename=Call+Center.csv
Purpose: To explore the dataset to answer basic business questions as well as provide data-driven insights to guide decision makers in making business decisions.

Link to Tableau Visualization: https://public.tableau.com/app/profile/edgar.orong/viz/Callcenter_16871849236670/Overview


Some of the questions I want to answer by doing this analysis:

1. Which call center is the busiest?
2. What day of the week is the busiest?
3. What state/city does most callers come from?
4. What are the reasons why customers call? What is their number 1 concern?
5. Which call center performs poorly in terms of response time? Is it always a busy branch that they took long to answer the call?
6. Which call center performs best in terms of response time? What factors affect their good result?
7. Which call center performs best in terms of csat score? Does the number of calls they receive affect their csat score?
8. Which call center performs worst in terms of csat score? 
9. Average call duration
10. Best performing call center in terms of avg. call duration. 

*/



--Let's first import the dataset to SQL

CREATE TABLE IF NOT EXISTS call_center
		(
			id varchar,
			customer_name text,
			sentiment text,
			csat_score numeric,
			call_timestamp date,
			reason text,
			city text,
			state text,
			channel text,
			response_time text,
			call_duration numeric,
			call_center text	
		)
		
SELECT *
FROM call_center




--Q1. Which call center is the busiest in terms of number of calls?

SELECT
	call_center,
	COUNT(*) AS num_of_calls
FROM call_center
GROUP BY call_center
ORDER BY num_of_calls DESC



-- Q2. What day is the busiest?
SELECT
	DISTINCT to_char(call_timestamp, 'Day') AS day,
	COUNT(*) AS num_of_calls
FROM call_center
GROUP BY day
ORDER BY num_of_calls DESC



-- Q3. What state/city does most callers come from?

--State
SELECT 
	DISTINCT state,
	COUNT(*) AS num_of_calls
FROM call_center
GROUP BY state
ORDER BY num_of_calls DESC


-- City
SELECT 
	DISTINCT city,
	COUNT(*) AS num_of_calls
FROM call_center
GROUP BY city
ORDER BY num_of_calls DESC



--Q4. What are the reasons why customers call? What is their number 1 concern?

SELECT 
	reason,
	COUNT(*) AS num_of_calls
FROM call_center
GROUP BY reason
ORDER BY num_of_calls DESC



--Q5. Which call center performs poorly in terms of response time? Is it always a busy branch that they took long to answer the call?

SELECT
	call_center,
	SUM(CASE WHEN response_time = 'Below SLA' THEN 1 ELSE 0 END) AS below_SLA
FROM call_center
GROUP BY call_center
ORDER BY below_SLA DESC

-- Let's compare the result versus the number of calls they received for the month

SELECT
	call_center,
	SUM(CASE WHEN response_time = 'Below SLA' THEN 1 ELSE 0 END) AS below_SLA,
	COUNT(*) AS total_calls_received,
	ROUND((SUM(CASE WHEN response_time = 'Below SLA' THEN 1 ELSE 0 END)::numeric / COUNT(*))*100, 2) AS below_SLA_percent
FROM call_center
GROUP BY call_center
ORDER BY below_SLA_percent DESC



-- Q6. Which call center performs best in terms of response time? Is it not a busy branch?

SELECT
	call_center,
	SUM(CASE WHEN response_time IN ('Within SLA', 'Above_SLA') THEN 1 ELSE 0 END) AS met_SLA
FROM call_center
GROUP BY call_center
ORDER BY met_SLA DESC

-- Let's compare the result versus the number of calls they received for the month

SELECT 
	call_center,
	SUM(CASE WHEN response_time IN ('Within SLA', 'Above SLA') THEN 1 ELSE 0 END) AS met_SLA,
	COUNT(*) AS total_calls_received,
	ROUND((SUM(CASE WHEN response_time IN ('Within SLA', 'Above_SLA') THEN 1 ELSE 0 END)::numeric / COUNT(*))*100, 2) AS met_SLA_percent
FROM call_center
GROUP BY call_center
ORDER BY met_SLA_percent DESC



--Q7. Which call center performs best in terms of csat score? Does the number of calls they receive affect their csat score?

SELECT 
	call_center,
	ROUND(AVG(csat_score), 2) AS avg_csat,
	COUNT(*) AS total_calls_received
FROM call_center
GROUP BY call_center
ORDER BY avg_csat DESC, total_calls_received DESC


-- Q8. Which call center performs worst in terms of csat score? 

SELECT 
	call_center,
	ROUND(AVG(csat_score), 2) AS avg_csat
FROM call_center
GROUP BY call_center
ORDER by avg_csat ASC



-- Q9. Average call duration for all call centers

SELECT
	ROUND(AVG(call_duration), 2) AS avg_call_duration
FROM call_center



-- Q10. Average call duration per call center

SELECT 
	call_center,
	ROUND(AVG(call_duration), 2) AS avg_call_duration
FROM call_center
GROUP BY call_center
ORDER BY avg_call_duration DESC



