-- creating a new database
create database finance_project;
-- making the created database as a default schema
use finance_project;
-- creating table before loading the clean data into sql
create table finance_data (
Date date,
Transaction_Type varchar(20),
Category varchar(50),
Amount float,
Remark varchar(255),
Year int,
Month_Year varchar(20)
);

-- importing clean data into MySQL Workbench into the created finace_data table through table import wizard
-- fetching of data from the table
select * from finance_data;
-- checking the total records present in the table
select count(*) from finance_data;
-- fetching the first 5 rows from the table
select * from finance_data limit 5;
-- filtering the expense category from the data
select * from finance_data where Transaction_Type = 'Expense';
-- filtering the high expense 
select * from finance_data where Transaction_Type = 'Expense' and Amount < -2000;
-- filtering only the food and snacks category
select * from finance_data where Category = 'Food' or Category = 'Snacks';
-- fetching unique records from the category column
select distinct Category from finance_data;


-- Validating the dashboard KPI's using SQL aggregation queries
-- using WHERE
-- Checking Total Income
select sum(Amount) as Total_Income from finance_data where Transaction_Type = 'Income';
-- Checking Total Expense
select sum(Amount) as Total_Expense from finance_data where Transaction_Type = 'Expense';
-- using CASE WHEN
-- Checking the Total of Income, Expense and the Net Savings 
select sum(case 
when Transaction_Type = 'Income' then amount 
else 0 
end) as Total_Income, sum( case 
when Transaction_Type = 'Expense' then amount 
else 0 
end) as Total_Expense, sum(amount) as Net_Savings from finance_data; 


-- Validating overall analysis
-- Total Income Vs Expense
select Transaction_Type, sum(Amount) as Total from finance_data Group by Transaction_Type;
-- Category- wise Expense
select Category, sum(Amount) as Total_Expense from finance_data where Transaction_Type = 'Expense' Group By Category order by Total_Expense desc;
-- Split Income vs expense monthly
select date_format (Date, '%Y-%m') as Month, sum( case
when Transaction_Type ='Income'then amount
else 0
end) as Income, sum(case
when Transaction_Type = 'Expense' then amount
else 0
end) as Expense from finance_data group by Month;
