Create Database My_Biz
create table Employee(
Emp_id nvarchar (20) Primary Key not null,
First_Name varchar (40),
Last_Name varchar (40),
Contact_Address varchar (200),
Phone int ,
State_of_Origin varchar (50),
Department varchar(70),
Salary float,
);

Create Table Customer(
Customer_id nvarchar (20) Primary Key Not null,
First_FName varchar (100),
Last_Name varchar (100),
Emp_id nvarchar (20) not null,
State_of_Origin varchar (40),
Phone int,
);
ALTER TABLE Customer ADD Product_id nvarchar(20);

Alter Table Customer
ADD FOREIGN KEY (Product_id) References Products (Product_id)

Create Table Orders(
Order_id nvarchar (10) Primary Key not null,
Order_Date date,
Quantity int,
Unit_Price float,
Total_Price float,
Cost_Price float,
Revenue float,
Emp_id nvarchar (20) not null,
);
ALTER TABLE Orders ADD Customer_id nvarchar(20);

Alter Table Orders
Add Foreign Key (Customer_id) References Customer (Customer_id)

Create Table Products(
Product_id nvarchar (20) Primary Key Not null,
Product_Name varchar (50),
Emp_id nvarchar (20),
Order_id nvarchar (20),
Order_Date date,
);


ALTER TABLE Products ADD Ship_id nvarchar(20);

Alter Table Products
Add Foreign Key (Ship_id) References Products (Ship_id);

Create Table Ship(
Ship_id nvarchar (20) Primary Key Not null,
Ship_Mode varchar (30),
Ship_Date date,
Emp_id nvarchar (20),
Customer_id nvarchar (20),
Ship_Destination varchar (50),
);
alter table Ship add Product_id nvarchar (20) not null;

Alter table Ship add foreign key (Product_id) References Products (Product_id)

select * from INFORMATION_SCHEMA.TABLES