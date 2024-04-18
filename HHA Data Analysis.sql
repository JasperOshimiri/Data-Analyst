-----This data set was scrapped from Google Cloud's Google Trend Data through the 
-----website:    tps://console.cloud.google.com/bigquery?p=bigquery-public-data&d=google_
-----analytics_sample&page=dataset&project=pelagic-region-331808&ws=!1m10!1m4!4m3!1sbigquery-
-----public-data!2scms_codes!3sicd10_procedures_2019!1m4!4m3!1sbigquery-public-data!2scm
-----s_medicare!3shome_health_agencies_2013)

--------------------------------HOME HEALTH AGENCY (USA) EXPLAINED----------------------------------------------
----- It is all about the expenses made by the US governement under the Human Health Agency in year
----- year 2013. Note:Home Health Agency (HHA) in the United States refers to an organization or entity 
----- that provides healthcare services to individuals in their homes. These services are 
----- typically for patients who require medical care, nursing care, rehabilitation therapy,
----- or assistance with activities of daily living but can receive these services in a 
----- home setting rather than in a hospital or other healthcare facility.

-----------------------------FEATURES EXPLAINED---------------------------------------------
---- The data set features or columns are eplained below:
---- Provider_id: This column likely contains a unique identifier for each home health agency.

---- agency_name: This column contains the name of each home health agency.

---- street_address: This column stores the street address of each home health agency.

---- city: The city column contains the city or locality where each home health agency is located.

---- state: This column indicates the state in which each home health agency is situated, using the two-letter 
--------abbreviation for US states (e.g., CA for California, NY for New York).

---- zip_code: The  ZIP code associated with the address of each home health agency.

---- total_episodes_non_lupa: Total number of episodes of care provided by each home health agency under 
---------the LUPAs (Low Utilization Payment Adjustment) system.

---- distinct_users_non_lupa: Distinct users or patients who received services from each home health 
---------agency NOT the LUPAs system during their episodes of care.

---- total_hha_charge_amount_non_lupa: Total charge amount billed by each home health agency for services 
--------- provided to patients who were not classified under LUPAs.

---- total_hha_medicare_payment_amount_non_lupa: Medicare payment amount received by each home health 
--------- agency for services provided to patients who were not classified under LUPAs.

---- total_hha_medicare_standard_payment_amount_non_lupa: Total tandard Medicare payment amount 
---------- received by each home health agency for services provided to patients NOT under LUPAs.

---- outlier_payments_as_a_percent_of_medicare_payment_amount_non_lupa: Percentage of outlier payments 
---------- compared to the Medicare payment amount for services provided to patients NOT under Lupa

---- total_lupa_episodes: Total number of episodes of care provided by each home health agency that 
---------- are classified under the LUPAs system.

---- total_hha_medicare_payment_amount_for_lupas: Total Medicare payment amount received by each home 
----------- health agency for services provided to patients NOT under LUPAs system.

--------------------------------------------QUESTIONS----------------------------------------------------------

1---- In this data analysis project, there are certain concerns I feel stakeholders will have and would like 
---- that light be shed on them. They are as follows:

2---- Total Service Utilization: Stakeholders would be interested in the overall utilization of services by distinct 
-------------users and episodes, both under LUPAs and non-LUPAs categories.

3---- Payment Patterns: Understanding payment amounts, standard payments, and outlier payments as a percentage of 
--------------Medicare payments provides insights into financial aspects.

4----  Analyzing data by state can reveal regional differences in service utilization and payment patterns.

5---- Outlier Analysis: Identifying agencies with outlier payments and understanding the characteristics of 
-------------these outliers is crucial for financial monitoring and decision-making.

6---- Comparison with LUPAs: Comparing data between LUPAs and non-LUPAs episodes helps in understanding the 
--------------impact of low utilization on payments.

7---- Stakeholders may want to see trends over time, if available, to identify any significant changes or patterns.

8---- Comparing agency performance metrics against benchmarks or industry standards provides context for evaluation.

9---- Impact of Standard Payments: Analyzing the average standard Medicare payment amount across states can reveal 
--------------disparities or trends in reimbursement rates.

10---- Financial Health of Agencies: Understanding the total charge amount, Medicare payments, and outlier payments 
--------------as a percentage helps in assessing the financial health of agencies.

11---- Policy Implications: Data analysis can also shed light on the impact of policy changes or regulations 
--------------on service utilization and payments.
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM HHA;

------- 1. Total distinct users who are not classified under LUPAs
SELECT COUNT(DISTINCT distinct_users_non_lupa) AS total_distinct_users_non_lupa 
	FROM hha;
	
------ 2. Number of episodes and average Medicare payment for LUPAs
SELECT total_lupa_episodes AS lupa_episodes, 
	AVG(total_hha_medicare_payment_amount_for_lupas) AS avg_medicare_payment_for_lupas 
	FROM hha
	GROUP BY total_lupa_episodes
	ORDER BY AVG(total_hha_medicare_payment_amount_for_lupas) DESC
	LIMIT 10;

----- 3. Top 5 states with the highest number of non-LUPAs episodes
SELECT state, SUM(total_episodes_non_lupa) AS total_non_lupa_episodes 
	FROM hha 
	GROUP BY state 
	ORDER BY total_non_lupa_episodes DESC 
	LIMIT 5;

----- 4. Average outlier payment percentage for non-LUPAs episodes
SELECT AVG(outlier_payments_as_a_percent_of_medicare_payment_amount_non_lupa) AS avg_outlier_percentage 
FROM hha;

---- 5. Correlation between total episodes and total charge amount for non-LUPAs episodes
SELECT CORR(total_episodes_non_lupa, total_hha_charge_amount_non_lupa) AS correlation 
	FROM hha;

---- 6. Identify outliers in total_hha_medicare_payment_amount_non_lupa column
SELECT * FROM hha 
	WHERE total_hha_medicare_payment_amount_non_lupa > (
			SELECT AVG(total_hha_medicare_payment_amount_non_lupa) + 
		3 * STDDEV(total_hha_medicare_payment_amount_non_lupa) 
		FROM hha);
		
---- 7. Average standard Medicare payment amount for non-LUPAs episodes across states
SELECT state, AVG(total_hha_medicare_standard_payment_amount_non_lupa) AS avg_standard_payment 
	FROM hha 
	GROUP BY state
	ORDER BY AVG(total_hha_medicare_standard_payment_amount_non_lupa) DESC;


----- 8. Geographical trends in total_hha_medicare_payment_amount_non_lupa
SELECT state, 
	SUM(total_hha_medicare_payment_amount_non_lupa) AS total_medicare_payment 
		FROM hha 
		GROUP BY state 
		ORDER BY total_medicare_payment DESC;

----- 9. Number of agencies with outlier payments exceeding a certain threshold
SELECT COUNT(*) AS agencies_with_outliers 
	FROM hha 
	WHERE outlier_payments_as_a_percent_of_medicare_payment_amount_non_lupa > 5;


---- 10. Total Medicare payment amount and percentage contribution from non-LUPAs and LUPAs episodes
SELECT STATE,
    SUM(total_hha_medicare_payment_amount_non_lupa) AS total_non_lupa_payment,
    SUM(total_hha_medicare_payment_amount_for_lupas) AS total_lupa_payment
FROM hha
GROUP BY STATE;

----- Top 10 Most patronized Agencies under Medicare None Lupa Care Option
SELECT "Agency", SUM(total_hha_medicare_payment_amount_non_lupa) AS Total_Medicare_Payemnt_NonLupa
from HHA
GROUP BY "Agency"
ORDER BY SUM(total_hha_medicare_payment_amount_non_lupa) DESC
LIMIT 10;

----- Top 10 Most patronized Agencies under Medicare None Lupa Care Option expressed in Percentage
WITH agency_totals AS (
    SELECT "Agency", SUM(total_hha_medicare_payment_amount_non_lupa) AS total_medicare_payment_non_lupa
    FROM HHA
    GROUP BY "Agency"
)
SELECT
    "Agency",
    total_medicare_payment_non_lupa,
    (total_medicare_payment_non_lupa / SUM(total_medicare_payment_non_lupa) OVER ()) * 100 AS percentage_of_total
FROM agency_totals
ORDER BY total_medicare_payment_non_lupa DESC
LIMIT 10;

----- Top 10 Most patronized Agencies under Medicare Standard None Lupa Care Option
SELECT "Agency", SUM(total_hha_medicare_standard_payment_amount_non_lupa) AS Total_Medicare_Standard_Payemnt_NonLupa
from HHA
GROUP BY "Agency"
ORDER BY SUM(total_hha_medicare_standard_payment_amount_non_lupa) DESC
LIMIT 10;

----- Top 10 Most patronized Agencies under Medicare Lupa Care Option
SELECT "Agency", SUM(total_hha_medicare_payment_amount_for_lupas) AS Total_Medicare_Payment_Lupa
from HHA
GROUP BY "Agency"
ORDER BY SUM(total_hha_medicare_payment_amount_for_lupas) DESC
LIMIT 10;