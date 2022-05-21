

/*To check the column names and data types of the variables*/
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DRUGSDATA';

/*To load the data set*/
SELECT * FROM drugsdata

/*To check for the presence of null values in the data set. There are no NULL values detected*/
WHERE State IS NULL AND Year IS NULL AND Pop_Twelve_to_Seventeen IS NULL AND Pop_Eighteen_to_Twentyfive IS NULL AND Pop_26_and_Above IS NULL AND Totals_AUD_Pst_Yr12_17 IS NULL AND Totals_AUD_Pst_Yr18_25 IS NULL AND Totals_AUPstMth_18_25 IS NULL AND TotalsAUPstMth_26_and_Above IS NULL AND Totals_Tobacco_Use_Past_Month_12_17 IS NULL AND Totals_TobaccoCigaretPstMth_18_25 IS NULL AND Totals_Cocaine_Used_Past_Year_26_and_Above IS NULL AND Totals_Tobacco_Use_Past_Month_18_25 IS NULL;

/*States with the highest leves of abuses in all drugs category*/
SELECT STATE, SUM (TotalsAUPst_Mth12_17 + Totals_AUPstMth_18_25+ TotalsAUPstMth_26_and_Above+ Totals_TobaccCigaretPstMth_12_17+Totals_Tobacco_Use_Past_Month_18_25+Totals_TobaccoCigaretPstMth_26_and_Above+[Totals_Cocaine _Used_Past_Year12_17]+Totals_Cocaine_Used_Past_Year_18_25+Totals_Cocaine_Used_Past_Year_26_and_Above+Totals_Marijuana_New_Users_12_17+ Totals_Marijuana_New_Users_18_25+Totals_Marijuana_New_Users_26_and_Above+ Totals_Marijuana_New_Users_12_17+ Totals_Marijuana_New_Users_18_25+Totals_Marijuana_New_Users_26_and_Above + Totals_TobaccCigaretPstMth_12_17+Totals_Tobacco_Use_Past_Month_12_17+Totals_Tobacco_Use_Past_Month_26_and_Above+Totals_TobaccoCigaretPstMth_18_25) AS SUM_OF_ABUSES_OF_DRUGS
FROM DRUGSDATA
GROUP BY STATE
ORDER BY 2 DESC;

SELECT MAX(YEAR) FROM DRUGSDATA
SELECT MIN(YEAR) FROM DRUGSDATA

SELECT Year, SUM (TotalsAUPst_Mth12_17 + Totals_AUPstMth_18_25+ TotalsAUPstMth_26_and_Above+ Totals_TobaccCigaretPstMth_12_17+Totals_Tobacco_Use_Past_Month_18_25+Totals_TobaccoCigaretPstMth_26_and_Above+[Totals_Cocaine _Used_Past_Year12_17]+Totals_Cocaine_Used_Past_Year_18_25+Totals_Cocaine_Used_Past_Year_26_and_Above+Totals_Marijuana_New_Users_12_17+ Totals_Marijuana_New_Users_18_25+Totals_Marijuana_New_Users_26_and_Above+ Totals_Marijuana_New_Users_12_17+ Totals_Marijuana_New_Users_18_25+Totals_Marijuana_New_Users_26_and_Above + Totals_TobaccCigaretPstMth_12_17+Totals_Tobacco_Use_Past_Month_12_17+Totals_Tobacco_Use_Past_Month_26_and_Above+Totals_TobaccoCigaretPstMth_18_25) AS SUM_OF_ABUSES_OF_DRUGS
FROM DRUGSDATA
GROUP BY Year
ORDER BY 2 DESC;

SELECT Year, ROUND(AVG(TotalsAUPst_Mth12_17 + Totals_AUPstMth_18_25+ TotalsAUPstMth_26_and_Above+ Totals_TobaccCigaretPstMth_12_17+Totals_Tobacco_Use_Past_Month_18_25+Totals_TobaccoCigaretPstMth_26_and_Above+[Totals_Cocaine _Used_Past_Year12_17]+Totals_Cocaine_Used_Past_Year_18_25+Totals_Cocaine_Used_Past_Year_26_and_Above+Totals_Marijuana_New_Users_12_17+ Totals_Marijuana_New_Users_18_25+Totals_Marijuana_New_Users_26_and_Above+ Totals_Marijuana_New_Users_12_17+ Totals_Marijuana_New_Users_18_25+Totals_Marijuana_New_Users_26_and_Above + Totals_TobaccCigaretPstMth_12_17+Totals_Tobacco_Use_Past_Month_12_17+Totals_Tobacco_Use_Past_Month_26_and_Above+Totals_TobaccoCigaretPstMth_18_25),2) AS SUM_OF_ABUSES_OF_DRUGS
FROM DRUGSDATA
GROUP BY Year
ORDER BY 2 DESC;

SELECT * FROM DRUGSDATA

SELECT YEAR, SUM(Totals_AUD_Pst_Yr12_17+Totals_AUD_Pst_Yr18_25+TotalsAUPstMth_26_and_Above) AS SUM_OF_ALCHOHOL_ABUSE
FROM DRUGSDATA
GROUP BY YEAR;

SELECT YEAR, SUM([Totals_Cocaine _Used_Past_Year12_17] + Totals_Cocaine_Used_Past_Year_18_25+ Totals_Cocaine_Used_Past_Year_26_and_Above) AS SUM_OF_COCAINE_ABUSE
FROM DRUGSDATA
GROUP BY YEAR;

SELECT YEAR, SUM(Totals_Marijuana_New_Users_12_17 + Totals_Marijuana_New_Users_18_25 + Totals_Marijuana_New_Users_26_and_Above) AS SUM_OF_MARIJUANA_ABUSE
FROM DRUGSDATA
GROUP BY Year
ORDER BY 2;

SELECT YEAR, SUM(Pop_Twelve_to_Seventeen) AS SUM_OF_12_17
FROM DRUGSDATA
GROUP BY YEAR
ORDER BY 2

SELECT YEAR, SUM(Pop_Eighteen_to_Twentyfive) AS SUM_OF_18_25
FROM DRUGSDATA
GROUP BY YEAR
ORDER BY 2

SELECT YEAR, SUM(Pop_26_and_Above) AS SUM_OF_26_AND_ABOVE
FROM DRUGSDATA
GROUP BY YEAR
ORDER BY 2

SELECT YEAR, Totals_AUD_Pst_Yr12_17, Totals_AUD_Pst_Yr18_25, TotalsAUDPstYr26_and_Above
FROM DRUGSDATA
GROUP BY YEAR, Totals_AUD_Pst_Yr12_17, Totals_AUD_Pst_Yr18_25, TotalsAUDPstYr26_and_Above
ORDER BY 2 DESC

SELECT * FROM DRUGSDATA

SELECT STATE, NULLIF(Totals_AUD_Pst_Yr12_17,0)*1000/Pop_Twelve_to_Seventeen as RATE_OF_AUD_PST_YR_12_17
FROM DRUGSDATA
GROUP BY STATE, Totals_AUD_Pst_Yr12_17, Pop_Twelve_to_Seventeen
ORDER BY STATE;

SELECT State, Year, Pop_Twelve_to_Seventeen, 
Pop_Eighteen_to_Twentyfive,
SUM(Pop_Eighteen_to_Twentyfive) OVER (PARTITION BY STATE ORDER BY YEAR) As SUM_OF_12_25_BY_YR_STATE
FROM DRUGSDATA

SELECT * FROM DRUGSDATA

SELECT YEAR, STATE, Totals_TobaccoCigaretPstMth_26_and_Above, Totals_TobaccoCigaretPstMth_18_25, 
SUM(Totals_Cocaine_Used_Past_Year_26_and_Above)
OVER (PARTITION BY STATE  ORDER BY YEAR) AS SUMaBOVEt26tOBBACO
FROM DRUGSDATA
WHERE STATE IN ('ARIZONA', 'CALIFONIA', 'DELAWARE', 'FLORIDA') AND YEAR IN (2005,2010,2015)

SELECT * FROM DRUGSDATA

SELECT STATE, YEAR, Totals_Marijuana_Used_Past_Year_12_17, Totals_Marijuana_Used_Past_Year_18_25, Totals_Marijuana_Used_Past_Year_26_and_Above, SUM(Totals_Marijuana_Used_Past_Year_12_17+Totals_Marijuana_Used_Past_Year_18_25+Totals_Marijuana_Used_Past_Year_26_and_Above)
OVER (PARTITION BY STATE ORDER BY STATE) AS MARIJUANA_USE_TOTALS
FROM DRUGSDATA
WHERE STATE IN ('CALIFONIA', 'GEORGIA', 'KANSAS', 'MARYLAND', 'NEW YORK') AND YEAR > 2010;


SELECT STATE, YEAR, [Totals_Cocaine _Used_Past_Year12_17], Totals_Cocaine_Used_Past_Year_18_25, Totals_Cocaine_Used_Past_Year_26_and_Above,
ROW_NUMBER() OVER (PARTITION BY STATE ORDER BY YEAR) AS NUM_OF_STATE_OCCURANCES
FROM DRUGSDATA


