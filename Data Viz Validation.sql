/* 
The purpose of the following SQL queries is to validate the values and ensure the accuracy of the formulas used in the data visualization
produced in Tableau. 
Data Visualization: https://public.tableau.com/app/profile/edgar.orong/viz/Callcenter_16871849236670/Overview

Project Name: Analysis of Attrition Data in the Human Resources Department
Data Source: https://data.world/markbradbourne/rwfd-real-world-fake-data/workspace/file?filename=Call+Center.csv

*/


--DASHBOARD 1: OVERVIEW

-- Reason
SELECT 
	reason,
	ROUND((COUNT(reason)::numeric/(SELECT COUNT(*)::numeric FROM call_center))*100, 2) AS percentage
FROM call_center
GROUP BY reason
ORDER BY percentage DESC
	

-- CSAT Score
SELECT
	ROUND(AVG(csat_score), 1) AS avg_CSAT_score
FROM call_center


-- Total Calls Received
SELECT 
	COUNT(*)
FROM call_center


-- Total Calls Duration
SELECT 
	SUM(call_duration) AS total_call_duration
FROM call_center


-- Average Calls Duration
SELECT
	ROUND(AVG(call_duration), 0) AS avg_call_duration
FROM call_center


-- Calls by City
SELECT 
	city,
	COUNT(*) AS total_calls
FROM call_center
GROUP BY city
ORDER BY total_calls DESC


-- Calls by State
SELECT
	state,
	COUNT(*) AS total_calls
FROM call_center
GROUP BY state
ORDER BY total_calls DESC


-- Calls by Day
SELECT 
	to_char(call_timestamp, 'Day') AS day,
	COUNT(*) AS total_calls
FROM call_center
GROUP BY day


-- Calls by Channel
SELECT
	channel,
	COUNT(*) AS total_calls,
	ROUND((COUNT(channel)::numeric/(SELECT COUNT(*)::numeric FROM call_center))*100, 2) AS percentage
FROM call_center
GROUP BY channel
ORDER BY total_calls DESC


-- % Response Time
SELECT
	response_time,
	COUNT(*) AS total_calls,
	ROUND((COUNT(response_time)::numeric / (SELECT COUNT(*)::numeric FROM call_center))*100, 2) AS percentage
FROM call_center
GROUP BY response_time
ORDER BY percentage DESC


-- Calls by Sentiment
SELECT
	sentiment,
	ROUND((COUNT(sentiment)::numeric / (SELECT COUNT(*)::numeric FROM call_center))*100, 2) AS percentage
FROM call_center
GROUP BY sentiment
ORDER BY percentage DESC


-- DASHBOARD 2: CALL LOGS

SELECT
	id, 
	call_timestamp AS date,
	CONCAT(state, ', ', city) AS location,
	call_duration AS duration,
	call_center,
	reason,
	sentiment
FROM call_center
ORDER BY id
	


-- NOW LET'S ADD FILTER TO SEE IF THE MAIN FILTER (call center filter) is WORKING ACCURATELY

-- Reason
SELECT 
	reason,
	ROUND((COUNT(reason)::numeric/(SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY reason
ORDER BY percentage DESC
	

-- CSAT Score
SELECT
	ROUND(AVG(csat_score), 1) AS avg_CSAT_score
FROM call_center
WHERE call_center = 'Baltimore/MD'


-- Total Calls Received
SELECT 
	COUNT(*)
FROM call_center
WHERE call_center = 'Baltimore/MD'


-- Total Calls Duration
SELECT 
	SUM(call_duration) AS total_call_duration
FROM call_center
WHERE call_center = 'Baltimore/MD'


-- Average Calls Duration
SELECT
	ROUND(AVG(call_duration), 0) AS avg_call_duration
FROM call_center
WHERE call_center = 'Baltimore/MD'


-- Calls by City
SELECT 
	city,
	COUNT(*) AS total_calls
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY city
ORDER BY total_calls DESC


-- Calls by State
SELECT
	state,
	COUNT(*) AS total_calls
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY state
ORDER BY total_calls DESC


-- Calls by Day
SELECT 
	to_char(call_timestamp, 'Day') AS day,
	COUNT(*) AS total_calls
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY day


-- Calls by Channel
SELECT
	channel,
	COUNT(*) AS total_calls,
	ROUND((COUNT(channel)::numeric/(SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY channel
ORDER BY total_calls DESC


-- % Response Time
SELECT
	response_time,
	COUNT(*) AS total_calls,
	ROUND((COUNT(response_time)::numeric / (SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY response_time
ORDER BY percentage DESC


-- Calls by Sentiment
SELECT
	sentiment,
	ROUND((COUNT(sentiment)::numeric / (SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD'
GROUP BY sentiment
ORDER BY percentage DESC


-- DASHBOARD 2: CALL LOGS

SELECT
	id, 
	call_timestamp AS date,
	CONCAT(state, ', ', city) AS location,
	call_duration AS duration,
	call_center,
	reason,
	sentiment
FROM call_center
WHERE call_center = 'Baltimore/MD'
ORDER BY id
	

-- Now let's add the action filters on top of the main filter to see if the values produced are correct

-- Reason
SELECT 
	reason,
	ROUND((COUNT(reason)::numeric/(SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY reason
ORDER BY percentage DESC
	

-- CSAT Score
SELECT
	ROUND(AVG(csat_score), 1) AS avg_CSAT_score
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'


-- Total Calls Received
SELECT 
	COUNT(*)
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'


-- Total Calls Duration
SELECT 
	SUM(call_duration) AS total_call_duration
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'


-- Average Calls Duration
SELECT
	ROUND(AVG(call_duration), 0) AS avg_call_duration
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'


-- Calls by City
SELECT 
	city,
	COUNT(*) AS total_calls
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY city
ORDER BY total_calls DESC


-- Calls by State
SELECT
	state,
	COUNT(*) AS total_calls
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY state
ORDER BY total_calls DESC


-- Calls by Day
SELECT 
	to_char(call_timestamp, 'Day') AS day,
	COUNT(*) AS total_calls
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY day


-- Calls by Channel
SELECT
	channel,
	COUNT(*) AS total_calls,
	ROUND((COUNT(channel)::numeric/(SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY channel
ORDER BY total_calls DESC


-- % Response Time
SELECT
	response_time,
	COUNT(*) AS total_calls,
	ROUND((COUNT(response_time)::numeric / (SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY response_time
ORDER BY percentage DESC


-- Calls by Sentiment
SELECT
	sentiment,
	ROUND((COUNT(sentiment)::numeric / (SELECT COUNT(*)::numeric FROM call_center WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'))*100, 2) AS percentage
FROM call_center
WHERE call_center = 'Baltimore/MD' AND state = 'Texas' AND city = 'Houston' AND channel = 'Call-Center'
GROUP BY sentiment
ORDER BY percentage DESC





