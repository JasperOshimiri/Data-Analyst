
/*Analysis of Airline Loyalty Program In Canada from 2012 to 2018
This dataset was downloaded from 'https://mavenanalytics.io/data-playground'and had been cleaned.
The dataset of of two tables but worked with the two using the Join function (Inner Join)
Several questions were answered in the analysis process and these have been qouted as comments on each code block*/

select * from clH
select * from cla

/*Task 1*/
/*Average flight booked per province*/
select ch.Province, avg(ca.FlightsBooked)
from clh as ch
join cla as ca
on ch.LoyaltyNumber = ca.LoyaltyNumber
group by ch.Province
order by Province

/*Task 2*/
/*Total flights booked by each province*/
select p.province, sum(t.TotalFlights)
from clh p
inner join cla t
on p.LoyaltyNumber = t.LoyaltyNumber
group by p.Province
order by p.Province

/*Task 3*/
/*Total flights booked per province with companions. that is dependents*/
select clh.Province, sum(cla.FlightswithCompanions)
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.Province
order by Province

/*Task 4*/
/*Average distance covered in each province*/
select clh.Province, Avg(cla.Distance) AvgDistance
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.Province
order by 2 desc

/*Task 5*/
/*Average dollar cost redeemed flights per province*/
select clh.Province, avg(cla.DollarCostRedeemed) as AvgDollarCost
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.Province
order by 2 desc

/*Task 6*/
/*Sum of dollar cost redeemed by flights per province*/
select clh.Province, sum(cla.DollarCostRedeemed) as SumDollarCost
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.Province
order by 2 desc

/*Task 7*/
/*Year with highest count of flight booked */
select clh.EnrolYear, count(EnrolYear) as bookingYear
from clh
group by EnrolYear
order by EnrolYear desc

/*Task 8*/
/*Month with highest count of flight booked */
select clh.EnrolMonth, count(EnrolMonth) as bookingMonth
from clh
group by EnrolMonth
order by EnrolMonth desc

/*Task 9*/
/*Year with highest count of flight cancelled */
select clh.CancelYear, count(CancelYear) as bookingYear
from clh
where CancelYear not in ('0')
group by CancelYear
order by CancelYear desc

/*Task 10*/
/*Year with highest count of flight cancelled */
select clh.CancelMonth, count(CancelMonth) as bookingMonth
from clh
where CancelMonth not in ('0')
group by CancelMonth
order by CancelMonth desc

/*Task 11*/
/*Average flight booked per city*/
select ch.City, avg(ca.FlightsBooked) Avg_City_Flight_Booked
from clh as ch
join cla as ca
on ch.LoyaltyNumber = ca.LoyaltyNumber
group by ch.City
order by 2 desc

/*Task 12*/
/*Total flights booked by each City*/
select p.City, sum(t.TotalFlights) Total_FlightsBooked_PerCity
from clh p
inner join cla t
on p.LoyaltyNumber = t.LoyaltyNumber
group by p.City
order by 2 desc

/*Task 13*/
/*Total flights booked per City with companions. that is dependents*/
select clh.City, sum(cla.FlightswithCompanions)
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.City
order by 2 desc

/*Task 14*/
/*Average distance covered in each City*/
select clh.City, Avg(cla.Distance) AvgDistance
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.City
order by 2 desc

/*Task 15*/
/*Average dollar cost redeemed per flight per City*/
select clh.City, avg(cla.DollarCostRedeemed) as AvgDollarCost
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.City
order by 2 desc

/*Task 16*/
/*Sum of dollar cost redeemed per flight per City*/
select clh.City, sum(cla.DollarCostRedeemed) as SumDollarCost
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.City
order by 2 desc

/*Task 17*/
/*Average Salary by Gender*/
select clh.Gender, avg(clh.Salary) Gender_With_HigherSalary
from clh
group by clh.Gender
order by 2 desc

/*Task 18*/
/*Total flights booked per Gender*/
select clh.Gender, sum(cla.flightsbooked) Gender_With_HighestFlightBooked
from clh
inner join cla
on clh.LoyaltyNumber = cla.LoyaltyNumber
group by clh.Gender
order by 2 desc

/*Task 19*/
/*Percentage of Gender per flights booked*/
SELECT Gender, count(*) * 100.0 / (SELECT count(*) from cla) as 'Gender Percentage'
FROM clh
GROUP BY gender

/*Task 20*/
/*Count of Customer educational qualification*/
select Education, count(education)
from clh
group by Education
order by 2 desc

/*Task 21*/
/*Count of Customer educational qualification where customer = Male*/
select Education, count(education)
from clh
where Gender = 'Male'
group by Education
order by 2 desc

/*Task 22*/
/*Count of Customer educational qualification where customer = Female*/
select Education, count(education)
from clh
where Gender = 'Female'
group by Education
order by 2 desc

/*Task 23*/
/*Average salary per city*/
select City, avg(Salary) as Average_SalaryPer_City
from clh
group by City
order by 2 desc

/*Task 24*/
/*Count of Marital Status*/
select MaritalStatus, count(MaritalStatus) CountofMaritalStatus
from clh
group by MaritalStatus
order by 2 desc

/*Task 25*/
/*Count of Marital Status per Province*/
SELECT Province, MaritalStatus, COUNT(MaritalStatus) 
OVER (PARTITION BY Province ORDER BY MaritalStatus) AS Cuntof_MaritalStatusbyProvince
FROM clh

/*Task 26*/
SELECT city, MaritalStatus, COUNT(MaritalStatus) 
OVER (PARTITION BY City ORDER BY MaritalStatus) AS Cuntof_MaritalStatusbyCity
FROM clh

/*Task 28*/
/*To find if there is a r/ship between edu quali and Salary*/
select Education, avg(Salary) Avg_SalaryPer_Edu_Qualification
from clh
group by Education
order by 2 desc

/*Task 29*/
select EnrolType, count(EnrolType) CountofEnrollmentTypes
from clh
group by EnrolType
order by 2 desc


