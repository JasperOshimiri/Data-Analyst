/*This is the analysis of AirCargo Activities around Major Regions of the world from 2005 to 2021*/

/*To see all tables in the database*/
select * from INFORMATION_SCHEMA.TABLES

/* To see all columns and datatpyes of the columns in the table*/
select COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Air_Cargo'


select * from Air_Cargo


select Operating_Airline, Count(Operating_Airline)as Operation_times_Opertaing_Airlines
from Air_Cargo Group by Operating_Airline
order by 2 DESC;



select GEO_Summary, Count(GEO_Summary) as Summary_of_GEO
from Air_Cargo Group by GEO_Summary
order by 2 DESC;


select GEO_Region, Count(GEO_Region) as CountofRegions_Destination
from Air_Cargo 
group by GEO_Region 
order by 2 DESC

select Activity_Type_Code, Count(Activity_Type_Code) as CountofActivity_Type_Code
from Air_Cargo 
group by Activity_Type_Code 
order by 2 DESC

select Cargo_Type_Code, Count(Cargo_Type_Code) as CountofCargo_Type_Code
from Air_Cargo 
group by Cargo_Type_Code 
order by 2 DESC

select Cargo_Aircraft_Type , Count(Cargo_Aircraft_Type ) as CountofCargo_Aircraft_Type 
from Air_Cargo 
group by Cargo_Aircraft_Type 
order by 2 desc


update AIR_Cargo
set Cargo_Aircraft_Type  = 'Combination'
where Cargo_Aircraft_Type  = 'Combi';


select Year, Count(Year) as CountofYears 
from Air_Cargo 
group by Year 
order by 2 desc
<---By the result shown by the above query where general activity in 2021 was lesser than 2019, it means the luckdown affected air businesses.


select Month, Count(Month) as CountofMonths_ActivityLevels
from Air_Cargo 
group by Month 
order by 2 desc


select Year, Month, Count(Month) as CountofMonths 
from Air_Cargo 
group by Year,Month 
order by 2 desc

Alter table Air_Cargo
add Converted_Cargo_Weight_LBS FLOAT

Alter table Air_Cargo
DROP COLUMN Cargo_Weight_LBS


select cast(Cargo_Weight_LBS as FLOAT) as Converted_Cargo_Weight_LBS from Air_Cargo

update Air_cargo
set Converted_Cargo_Weight_LBS = cast(Cargo_Weight_LBS as FLOAT)
from Air_Cargo


select sum(Cargo_Metric_TONS)
from Air_Cargo


SELECT * FROM AIR_CARGO


select GEO_Region, (
select SUM(FLOOR(Cargo_Metric_TONS))) as Metric_Tons_By_Region
from Air_Cargo group by Geo_Region 
order by 2 DESC

select Operating_Airline, (
select sum(floor(Cargo_Metric_tons))) as Metric_Tons_By_Airline
from Air_Cargo
group by Operating_Airline
order by 2 desc

select GEO_Region, Operating_Airline


/*Fetching top performing Airlines from the Regions*/
select *
from
(
     select GEO_Region, 
            [Operating_Airline],
            rank() over(partition by GEO_Region order by sum(Cargo_Metric_TONS) desc) as ranking
     from Air_CARGO 
     group by GEO_Region, [Operating_Airline] 
) temp
where ranking between 1 and 20


select * from Air_Cargo

select Operating_Airline, (
SELECT sum(floor(Cargo_Metric_tons))) AS SumOf_MetrTons_Intern
from Air_Cargo where GEO_Summary = 'International' 
group by Operating_Airline
order by 2 desc



select Operating_Airline, (
SELECT AVG(Cargo_Metric_tons)) AS AVG_MetrTons_Intern
from Air_Cargo where GEO_Summary = 'International' 
group by Operating_Airline
order by 2 desc


select Cargo_Aircraft_Type, ( 
select sum(floor(Cargo_Metric_TONS))) as Metric_TONS_By_AircraftType
from Air_Cargo
group by Cargo_Aircraft_Type
order by 2 desc

select Year, (
select sum(floor(Cargo_Metric_TONS)))as  Metric_TonsBy_Year
from Air_Cargo
group by Year
order by 2 desc


select Month, (
select sum(floor(Cargo_Metric_TONS)))as  Metric_TonsBy_Month
from Air_Cargo
group by Month
order by 2 desc

select * from Air_Cargo

select Operating_Airline, (
select sum(floor(Converted_Cargo_Weight_LBS)))as  Cargo_Weight_LBSby_Airline
from Air_Cargo
group by Operating_Airline
order by 2 desc


select Cargo_Type_Code, (
select sum(floor(Cargo_Metric_TONS)))as  CargoMetricTons_By_CargoType
from Air_Cargo
group by Cargo_Type_Code
order by 2 desc


select Published_Airline, Cargo_Aircraft_Type, (
select sum( Cargo_Metric_Tons)) 
from Air_Cargo where GEO_Region = 'Europe' and Year = '2021' 
group by Published_Airline, Cargo_Aircraft_Type



select Year, (
select avg(FLOOR(Cargo_Metric_Tons))) as AvgMetricTonstoUS/Europe
from Air_Cargo where GEO_Region IN ('Europe' ,'US') and Year = '2021' 
group by Year
order by 2


select GEO_Region, (
select avg(Cargo_Metric_Tons)) from Air_Cargo
group by GEO_Region
order by 2 desc

SELECT Cargo_Metric_TONS FROM Air_Cargo
order by Cargo_Metric_TONS

/*Lets do something funny with the case statement*/
select Cargo_Metric_TONS, 
CASE
WHEN Cargo_Metric_TONS > 5000 then 'Wow, that is huge'
WHEN Cargo_Metric_TONS > 3500  then 'Wow, just doing well'
WHEN Cargo_Metric_TONS > 2500  then 'Still good anyways'
WHEN Cargo_Metric_TONS > 1800 then 'Hey, up your game'
else 'Bad'
end
from Air_Cargo
order by Cargo_Metric_TONS DESC

/*THE END THANKS */





















































