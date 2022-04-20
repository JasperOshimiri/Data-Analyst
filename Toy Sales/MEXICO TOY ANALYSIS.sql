/* The analysis of Sales & inventory data for a fictitious chain of toy stores in Mexico called Maven Toys, including information about products, stores, daily sales transactions, and current inventory levels at each location.

The following insights were sought in the data.
Which product categories drive the biggest profits? Is this the same across store locations?

Seasonal trends or patterns in the sales data?

Are sales being lost with out-of-stock products at certain locations?

How much money is tied up in inventory at the toy stores? How long will it last?*/

/*To display all tables in the Database*/
select *  from INFORMATION_SCHEMA.TABLES

/*To show the column names and the data types of the target table*/
select COLUMN_NAME, DATA_TYPE
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='MAVINC'

/*Displaying all the data set*/
select * from mavinc

/*NOTE: PROFITS AND PRICE ARE USED INTERCHANGEABLY HERE TO REFER TO THE PRODUCT_PRICE COLUMN*/

/*Counting the total rows of the table*/
select COUNT ( distinct Store_Name ) as "Number of Stores" 
from mavinc;

select COUNT (Store_Name ) as "Number of Stores" 
from mavinc;

/*Profit by Product Name, sorted in descending order*/
select Product_Name, sum(Product_Price) as Sum_of_Profit
from mavinc
group by Product_Name, Product_Price
order by 2 desc

/*Profit by Product Name and Store Location, sorted in descending order*/
select product_name, store_location, sum(Product_Price) as Sum_of_Profit
from mavinc
group by product_name, store_location, Product_Price
order by Product_Price, Product_Name desc

/*Profit by Product Name and Store Location, sorted in descending order using the PARTITION METHOD*/
SELECT product_name, store_location, Product_Price,
COUNT(product_name) OVER (PARTITION BY store_location) AS CountofProducts,
count(store_location) OVER (PARTITION BY store_location) AS CountofStoreLoc,
SUM(Product_Price) OVER (PARTITION BY store_location) AS Total_Profit
FROM mavinc

/*Profit by Product Category and Store Location, sorted in descending order*/
select product_category,store_location, (
select sum(floor(product_price))) as SumOfPriceByCategory
from mavinc
group by product_category, store_location
order by 3 desc

/*Profit by Product Name and Store Location, sorted in descending order where filtered to 'LEGO BRICKS'*/
select product_name, store_location, SUM(Product_price)
from mavinc
where product_name = 'Lego BRICKS'
group by product_name, store_location

select * from mavinc

/*Profits by Date*/
select date, sum(product_price) as ProfitInYears
from mavinc
group by date
order  by 2 desc

/*Profits by Year 2017*/
select date, sum(product_price) as ProfitInYears
from mavinc
where  date like '%2017%'
group by date
order  by 2 desc

/*Profits by Year 2018*/
select date, sum(product_price) as ProfitInYears
from mavinc
where  date like '%2018%'
group by date
order  by 2 desc


select date, sum(product_price) as ProfitInYears
from mavinc
group by Date
order  by 1, 2 desc

/*Extracting the Year, Month and Day columns from Date Column*/
select Date,
parsename(replace(Date, '-', '.'),3) as YearofP
,parsename(replace(Date, '-', '.'),2) as MonthofP
,parsename(replace(Date, '-', '.'),1) as DayofP
from mavinc;

/*Making new columns (YEAR, MONTH & DAY) from the Date Column*/
alter table mavinc
add YearofP int;

alter table mavinc
add MonthofP int;

alter table mavinc
add DayofP int;

/*Populating the Table with the newly created columns (YAER, MONTH & BDAY)*/
update mavinc
set YearofP = parsename(replace(Date, '-', '.'),3)
from mavinc

update mavinc
set MonthofP = parsename(replace(Date, '-', '.'),2)
from mavinc

update mavinc
set DayofP = parsename(replace(Date, '-', '.'),1)
from mavinc

/*Profit By Year*/
select YearofP, sum(Product_Price) as ProfitByYear
from mavinc
group by YearofP
order  by 2 desc

/*Profit By Month*/
select MonthofP, sum(Product_Price) as ProfitByMonth
from mavinc
group by MonthofP
order  by 2 desc

/*Profit By Day*/
select DayofP, sum(Product_Price) as ProfitByDay
from mavinc
group by DayofP
order  by 2 desc

/*Available stock by Store location and product id*/
select store_location, product_id, sum(stock_on_hand) as Total_Stuck
from mavinc
where stock_on_hand = 0
group by product_id, stock_on_hand, store_location
order by 1

/*Profit by Product Category where store deals basically on toys*/
select product_category, sum(product_price) as PricebYToyProdcut
from mavinc
where product_category like '%toy%'
group by product_category
order by 2

/*Sum of Product price by product name, store location and year*/
select product_name, store_location, yearofp, sum(product_price)
from mavinc
group by product_name, store_location, yearofp
order by 4 desc

/*Average of Product price by product name, store location and year*/
select product_name, store_location, yearofp, avg(product_price) as AvgProductPrice
from mavinc
group by product_name, store_location, yearofp
order by 4 desc

/*Average Price by Month*/
select Monthofp, avg(Product_price) AvgPriceByMonth
from mavinc
group by Monthofp
order by 2 desc

/*Average Price by Month and Year*/
select Monthofp, avg(product_price) AvgPriceByMonth, Yearofp, 
avg(product_price)as  AvgPriceByYear
from mavinc
group by Yearofp, Monthofp
order by 2 desc

/*Product price by Store City. To know what store sells most expensive items*/
select store_city, sum(product_price) as PriceByCity
from mavinc
group by store_city
order by 2

/*selecting and grouping product cost by store name*/
select store_name, sum(product_cost) ProdCostByStore_Name 
from mavinc
group by store_name
order by 2 desc

/*Store Out of Stock*/
select store_name, count(stock_on_hand) as NoSTOCK
FROM mavinc
WHERE Stock_On_Hand <1
GROUP BY Store_Name
ORDER BY 1

/*Finding stock_in / Stock_out Stores*/
select stock_on_hand,
case
when stock_on_hand >1 then 'Stock In'
else 'Out of Stock'
end
from mavinc

select count(distinct store_name) from mavinc

/*Product Price Greater than its Average*/
SELECT PRODUCT_NAME, UNITS, PRODUCT_COST, PRODUCT_PRICE
FROM MAVINC
WHERE PRODUCT_PRICE > (
SELECT AVG(PRODUCT_PRICE)
FROM MAVINC)
GROUP BY PRODUCT_NAME,PRODUCT_NAME, UNITS, PRODUCT_COST, PRODUCT_PRICE;



