---CREATING THE TABLE TO IMPORT THE DATA SET INTO.

CREATE TABLE NETFLIX(
	SHOW_ID VARCHAR(10),
	TYPE_ VARCHAR(1000),
	TITLE VARCHAR(1000),
	DIRECTOR VARCHAR(1000),
	CAST_ VARCHAR(1000),
	COUNTRY VARCHAR(1000),
	DATE_ADDED VARCHAR(100),
	RELEASE_YEAR VARCHAR(100),
	RATING VARCHAR(100),
	DURATION VARCHAR(100),
	LISTED_IN VARCHAR(500)	
);

ALTER TABLE NETFLIX
ALTER COLUMN RELEASE_YEAR TYPE VARCHAR(100);


SELECT * FROM NETFLIX;

----How many movies and TV shows are available in the dataset?
SELECT type_, COUNT(*) AS count FROM netflix GROUP BY type_;

-----What are the top 10 countries with the most content available?
SELECT country, COUNT(*) AS count 
FROM netfliX 
WHERE COUNTRY IS NOT NULL
GROUP BY country 
ORDER BY count DESC LIMIT 10;

----How has the number of Netflix releases evolved over the years?
SELECT CAST(release_year AS INT) AS release_year_int, COUNT(*) AS count 
FROM netflix 
GROUP BY release_year 
ORDER BY 2 DESC 
LIMIT 10;

----What is the distribution of content ratings?
SELECT rating, COUNT(*) AS count 
FROM netflix GROUP BY rating
ORDER BY 2 DESC LIMIT 10;

----Which director has the most content on Netflix?
SELECT director, COUNT(*) AS count 
FROM netflix 
WHERE DIRECTOR IS NOT NULL
GROUP BY director 
ORDER BY count DESC LIMIT 10;

----What are the top 10 genres of Netflix content?
SELECT listed_in, COUNT(*) AS count 
FROM netflix 
GROUP BY listed_in 
ORDER BY count DESC LIMIT 10;


----How long is the average duration of movies and TV shows on Netflix?
----Extract Minutes from duration, put into a new column; Minutes.
-- Add a new column to store the extracted numbers
ALTER TABLE netflix
ADD COLUMN Minutes INT;
-- Update the new column with the extracted numbers
UPDATE netflix
SET Minutes = 
  CASE 
    WHEN duration ~ '\d+' THEN CAST(REGEXP_REPLACE(duration, '\D', '', 'g') AS INT)
    ELSE NULL
  END;
-------------------------------------------------------------------------
SELECT type_, AVG(Minutes) AS avg_Minutes 
FROM netflix GROUP BY type_
ORDER BY 2 DESC LIMIT 10;

----What is the percentage of movies vs. TV shows in the dataset?
SELECT type_, (COUNT(*) * 100.0 / (SELECT COUNT(*) 
FROM netflix)) AS percentage 
FROM netflix GROUP BY type_;

------Which are the oldest and newest releases on Netflix?
SELECT title, release_year FROM netflix ORDER BY release_year ASC LIMIT 1; -- Oldest

SELECT title, release_year FROM netflix ORDER BY release_year DESC LIMIT 1; -- Newest

----How has the number of content additions varied over different months and years?
SELECT EXTRACT(YEAR FROM date_added::timestamp) AS year_added, 
       EXTRACT(MONTH FROM date_added::timestamp) AS month_added, 
       COUNT(*) AS count 
FROM netflix
GROUP BY year_added, month_added
ORDER BY 3 desc;
----------------------------------------END-------------------------------------------