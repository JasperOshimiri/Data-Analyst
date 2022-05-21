/*THIS IS THE ANALYSIS OF SUICIDE ATTACKS ALL OVER THE WORLD FROM 1974 TO 2019*/

/*To load the tables in the database*/
SELECT * FROM INFORMATION_SCHEMA.TABLES 

/*Loading the Column names and Data Types of the various columns in the data set*/
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'NSD';

/*View the data set*/
SELECT * FROM NSD;

/*In the Process of recreating and wrangling the data set, dropping tables became necessary hence this*/
DROP TABLE NSD
DROP TABLE NSDATA

/*Selecting important columns of the data into a new table. In order to avoid bloated figures, the low aspect of the columns were picked against the high estimations*/
SELECT ID,  GROUPS, CLAIM, STATUS, DATE_YEAR, DATE_MONTH, DATE_DAY, statistics_wounded_low, statistics_killed_low, statistics_killed_low_civilian,
statistics_killed_low_political, statistics_killed_low_security, statistics_belt_bomb, statistics_truck_bomb, statistics_car_bomb, statistics_weapon_oth,
statistics_weapon_unk, target_weapon, target_region, target_subregion, target_country, target_province, target_city, target_location, target_desc,
target_nationality, target_type, statistics_attackers, statistics_female_attackers, statistics_male_attackers, statistics_unknown_attackers,attacker_gender
INTO NSDATA
FROM NSD;

/*Discovering Duplicate Rows in the Table*/
WITH ROW_NUM_CTE AS (
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY GROUPS, CLAIM, STATUS, DATE_YEAR, DATE_MONTH, DATE_DAY, statistics_wounded_low, statistics_killed_low, statistics_killed_low_civilian,
statistics_killed_low_political, statistics_killed_low_security, statistics_belt_bomb, statistics_truck_bomb, statistics_car_bomb, statistics_weapon_oth,
statistics_weapon_unk, target_weapon, target_region, target_subregion, target_country, target_province, target_city, target_location, target_desc,
target_nationality, target_type, statistics_attackers, statistics_female_attackers, statistics_male_attackers, statistics_unknown_attackers,attacker_gender ORDER BY ID) ROW_NUM
FROM NSDATA
)
SELECT * FROM ROW_NUM_CTE
WHERE ROW_NUM > 1
ORDER BY DATE_YEAR


/*Deleting duplicate values from the table*/
WITH ROW_NUM_CTE AS (
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY GROUPS, CLAIM, STATUS, DATE_YEAR, DATE_MONTH, DATE_DAY, statistics_wounded_low, statistics_killed_low, statistics_killed_low_civilian,
statistics_killed_low_political, statistics_killed_low_security, statistics_belt_bomb, statistics_truck_bomb, statistics_car_bomb, statistics_weapon_oth,
statistics_weapon_unk, target_weapon, target_region, target_subregion, target_country, target_province, target_city, target_location, target_desc,
target_nationality, target_type, statistics_attackers, statistics_female_attackers, statistics_male_attackers, statistics_unknown_attackers,attacker_gender ORDER BY ID) ROW_NUM
FROM NSDATA
)
DELETE
FROM ROW_NUM_CTE
WHERE ROW_NUM > 1

/*Sum of Casualty*/
SELECT SUM(statistics_wounded_low+statistics_killed_low)
FROM NSDATA

/*To find the grouping of terrorists and claims*/
SELECT groups, CLAIM, COUNT(GROUPS) 
OVER (PARTITION BY GROUPS ORDER BY GROUPS) AS GROUPCOUNT
FROM NSDATA

/*Count of claims*/
SELECT CLAIM, COUNT(CLAIM) AS CLAIMS
FROM NSDATA
GROUP BY CLAIM

/*First and Last Year on Record- The Data set*/
SELECT MIN(DATE_YEAR) AS FIRST_YEAR_ON_RECORD FROM NSDATA 
SELECT MAX(DATE_YEAR) LAST_YEAR_ON_RECORD FROM NSDATA

/*Groupings of the Terrorists by Year that Claimed Responsibility for Terror*/
SELECT GROUPS, DATE_YEAR, COUNT(GROUPS) AS NO_OF_GROUPS
FROM NSDATA
WHERE CLAIM IN ('CLAIMED')
GROUP BY GROUPS, DATE_YEAR;

/*Count of Groups that claimed Responsibility for Terror*/
SELECT GROUPS, COUNT(GROUPS) AS NO_OF_GROUPS
FROM NSDATA
WHERE CLAIM IN ('CLAIMED')
GROUP BY GROUPS;

/*Count of Groups that Denied Responsibility for Terror*/
SELECT GROUPS, COUNT(GROUPS) AS NO_OF_GROUPS
FROM NSDATA
WHERE CLAIM IN ('DENIED')
GROUP BY GROUPS;

/*Count of Groups that are Suspected to be Responsible for Terrorism*/
SELECT GROUPS, COUNT(GROUPS) AS NO_OF_GROUPS
FROM NSDATA
WHERE CLAIM IN ('SUSPECTED')
GROUP BY GROUPS;

/*Count of Groups that unclaimed Responsibility*/
SELECT GROUPS, COUNT(GROUPS) AS NO_OF_GROUPS
FROM NSDATA
WHERE CLAIM IN ('UNCLAIMED')
GROUP BY GROUPS;

/*Partitioning of Terrorism Status by Groups of Terror*/
SELECT GROUPS, CLAIM, STATUS, COUNT(STATUS)
OVER (PARTITION BY STATUS ORDER BY GROUPS) AS STATUS_PARTITIONING
FROM NSDATA

/*Total wounded by Group and Date by Partitioning*/
SELECT GROUPS, DATE_YEAR, SUM(statistics_wounded_low)
OVER (PARTITION BY DATE_YEAR ORDER BY statistics_wounded_low) AS SUM_OF_WOUNDED_LOW
FROM NSDATA

/*Total wounded by Group and Date*/
SELECT GROUPS, DATE_YEAR, SUM(statistics_wounded_low) AS SUM_OF_WOUNDED_LOW
FROM NSDATA
GROUP BY statistics_wounded_low, DATE_YEAR, GROUPS
ORDER BY statistics_wounded_low DESC

/*Counting of Dates by Year with Highest Terror Record*/
SELECT DATE_YEAR, COUNT(DATE_YEAR) AS COUNT_OF_YEAR
FROM NSDATA
GROUP BY DATE_YEAR
ORDER BY 2 DESC;

/*To find the Month with Most Terrorism Record*/
SELECT DATE_MONTH, COUNT(DATE_MONTH) AS COUNT_OF_MONTH
FROM NSDATA
GROUP BY DATE_MONTH
ORDER BY 2 DESC;

/*To find the Target Country, Month with Most Terrorism Record*/
SELECT target_country, DATE_MONTH, COUNT(target_country) AS COUNT_OF_MONTH
FROM NSDATA
GROUP BY DATE_MONTH, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year with Most Wounded People due to Terrorism among Top Five Countries*/
SELECT target_country, DATE_YEAR, SUM(statistics_wounded_low) AS SUM_OF_WOUNDED_LOW_IN_SELECTED_COUNTRIES
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year with Most  People Killed  due to Terrorism among Top Five Countries*/
SELECT target_country, DATE_YEAR, SUM(statistics_killed_low) AS SUM_OF_KILLED_LOW_IN_SELECTED_COUNTRIES_TOP5
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year with Total Sum  Civilians Killed  due to Terrorism among Top Five Countries*/
SELECT target_country, DATE_YEAR, SUM(statistics_killed_low_civilian) AS SUM_OF_LOW_CIVILIAN_KILLED_IN_SELECTED_COUNTRIES_TOP5
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year with Total Sum  Politicians Killed  due to Terrorism among Top Five Countries*/
SELECT target_country, DATE_YEAR, SUM(statistics_killed_low_political) AS SUM_OF_killed_low_political_IN_SELECTED_COUNTRIES_TOP5
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year with Total Sum  Security Personnel Killed  due to Terrorism among Top Five Countries*/
SELECT target_country, DATE_YEAR, SUM(statistics_killed_low_security) AS SUM_OF_killed_low_security_IN_SELECT_COUNTRIES_TOP5
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year Where Belt Bomb was used for Terrorism among Top Five Countries*/
/*The statistics_Belt_Bomb column is in Bit Data Type so I had to Cast it*/
SELECT target_country, DATE_YEAR, SUM(CAST(statistics_belt_bomb AS INT)) AS SUM_OF_statistics_belt_bomb_TOP5
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*Change the Data Type of the Below Referenced Table*/
ALTER TABLE NSDATA
ALTER COLUMN statistics_truck_bomb INT 

/*To find the Target Country, Year Where Truck Bomb was used for Terrorism among Top Five Countries*/
SELECT target_country, DATE_YEAR, SUM(statistics_truck_bomb) AS SUM_OF_truck_bomb_IN_SELECTED_COUNTRIES
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year Where Car Bomb was used for Terrorism among Top Five Countries*/
/*The statistics_Belt_Bomb column is in Bit Data Type so I had to Cast it*/
SELECT target_country, DATE_YEAR, SUM(CAST(statistics_car_bomb AS INT)) AS SUM_OF_CAR_bomb_IN_SELECTED_COUNTRIES
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*To find the Target Country, Year Where Unknown Items were used for Terrorism among Top Five Countries*/
/*The statistics_Belt_Bomb column is in Bit Data Type so I had to Cast it*/
SELECT target_country, DATE_YEAR, SUM(CAST(statistics_weapon_unk AS INT)) AS SUM_OF_UNKNOWN_WEAPON_IN_SELECTED_COUNTRIES
FROM NSDATA
WHERE target_country IN ('IRAQ','AFGHANISTAN','SYRIA','PAKISTAN', 'NIGERIA')
GROUP BY DATE_YEAR, target_country
ORDER BY 3 DESC;

/*Count of Types of Target Weapons by Countries*/
SELECT target_country, target_weapon, COUNT(target_weapon) COUNT_OF_TARGET_WEAPONS_USED_IN_COUNTRIES
FROM NSDATA
GROUP BY target_country, target_weapon
ORDER BY 3 DESC;

/*Count of Types of Target Weapons by Subregion*/
SELECT target_subregion, target_weapon, COUNT(target_weapon) COUNT_OF_WEAPONS_SUBREGION_TARGETED
FROM NSDATA
GROUP BY target_subregion, target_weapon
ORDER BY 3 DESC;

/*Count of Types of Target Weapons by Province*/
SELECT target_province, target_weapon, COUNT(target_weapon) COUNT_OF_WEAPONS_PROVINCE_TARGETED
FROM NSDATA
GROUP BY target_province, target_weapon
ORDER BY 3 DESC;

/*Count of Types of Target Weapons by City*/
SELECT target_city, target_weapon, COUNT(target_weapon) COUNT_OF_WEAPONS_TARGET_CITY
FROM NSDATA
GROUP BY target_city, target_weapon
ORDER BY 3 DESC;

/*Count of Types of Target Weapons by Country*/
SELECT * FROM NSDATA
SELECT target_country, target_type, COUNT(target_type) COUNT_OF_TARGET_TYPE_BY_COUNTRY
FROM NSDATA
GROUP BY target_country, target_type
ORDER BY 3 DESC;

/*Total Casualty by Target Country and Attacker Gender By Partitioning*/
SELECT TARGET_COUNTRY, attacker_gender, SUM(statistics_wounded_low+statistics_killed_low) 
OVER (PARTITION BY TARGET_COUNTRY ORDER BY ATTACKER_GENDER) AS TOTAL_CASUALITY
FROM NSDATA

/*Total Casualty by Target Country and Attacker Gender*/
SELECT TARGET_COUNTRY, attacker_gender, SUM(statistics_wounded_low+statistics_killed_low) AS TOTAL_CASUALITY
FROM NSDATA
GROUP BY TARGET_COUNTRY, attacker_gender
ORDER BY 3 DESC

/*TOTAL_CASUALITY_BY_ATTACKER_GENDER*/
SELECT attacker_gender, SUM(statistics_wounded_low+statistics_killed_low) AS TOTAL_CASUALITY_BY_ATTACKER_GENDER
FROM NSDATA
GROUP BY attacker_gender
ORDER BY 2 DESC;

/*Total Casualty by Attacker Gender and Target Nationality*/
SELECT target_nationality, attacker_gender, SUM(statistics_wounded_low+statistics_killed_low) AS TOTAL_CASUALITY
FROM NSDATA
GROUP BY target_nationality, attacker_gender
ORDER BY 3 DESC

/*Count of Target Description*/
SELECT target_desc, COUNT(target_desc) AS COUNT_TARGET_DESCIPTION
FROM NSDATA
GROUP BY target_desc
ORDER BY 2 DESC;

/*Total Casualty by Target Weapon Referencing the September 2011 Attack in United States*/
SELECT target_weapon, SUM(statistics_wounded_low+statistics_killed_low) AS SUM_OF_CASUALTIES_TAREGT_WEAPON_BY_0911
FROM NSDATA
WHERE target_desc LIKE '%Trade%'
GROUP BY target_weapon
ORDER BY 2 desc;

/*Total Casualty by Target Description Referencing the September 2011 Attack in United States*/
SELECT SUM(statistics_wounded_low+statistics_killed_low) AS SUM_OF_CASUALTIES_TAREGT_WEAPON_BY_0911
FROM NSDATA
WHERE target_desc LIKE '%Trade%'
ORDER BY 1 desc;

SELECT SUM(statistics_wounded_low+statistics_killed_low) FROM NSDATA

/* A case Comparison of Total Casualty by Target Country for Terrrorism*/
SELECT TARGET_COUNTRY, SUM(statistics_wounded_low+statistics_killed_low) AS RRR,
CASE
WHEN SUM(statistics_wounded_low+statistics_killed_low) > 40000 THEN 'Most Vulnerable'
WHEN SUM(statistics_wounded_low+statistics_killed_low) BETWEEN  20000 AND 40000 THEN 'More Vulnerable'
ELSE 'Less Vulnerable'
END AS GGG
FROM NSDATA
GROUP BY TARGET_COUNTRY

/*THIS IS THE END, OTHERS CAN CONTINUE THE ANALYSIS*/



SELECT * FROM NSDATA







