create database Manufacture;
use manufacture;
select * from fact_Production;
select * from dim_operation;
select * from dim_machine;
select * from dim_item;
select * from dim_employee;
select  * from dim_department;
select * from dim_date;
select * from dim_customer;
select * from dim_buyer;
-- Q.1) Manufacture Qty
select concat(round(sum(Today_Manufactured_Qty)/1000000.0,2), "M") as Total_Manufactured_Qty
from fact_Production;
-- Q.2) Rejected Qty
select concat(round(sum(Rejected_Qty)/1000.0,0),"K") as Total_Rejected_Qty
from fact_Production;
-- Q.3) Processed Qty
select concat(round(sum(Processed_Qty)/1000000.0,2),"M") as Total_Processed_Qty
from fact_Production;
-- Q.4) Production Efficiency (%)
select round((sum(Today_Manufactured_Qty-Rejected_Qty)*100.0)/
sum(Today_Manufactured_Qty),2) as Production_Efficiency_Percentage
from fact_Production;
-- Q.5) Employee-wise Rejected Qty 
select e.employee_name,sum(f.Rejected_Qty) as Rejected_Qty
from dim_employee e
join fact_Production f
on e.employee_code=f.employee_code
group by  e.employee_name
order by Rejected_Qty desc;
-- Q.6) Machine-wise Rejected Qty
select m.Machine_Type,sum(f.Rejected_Qty) as Rejected_Qty
from dim_machine m
join fact_Production f
on m.Machine_Code=f.Machine_Code
group by m.Machine_Type
order by Rejected_Qty desc;
-- Q.7) Production Trend
select d.Month_Num,d.Month_Name,sum(f.Today_Manufactured_Qty) as Monthly_Production
from dim_date d
join fact_Production f
on d.date=f.Date_FK
group by d.Month_Num,d.Month_Name
order by d.Month_Num asc;
-- Q.8) Manufacture vs Rejected
select concat(round(sum(Today_Manufactured_Qty)/1000000.0,2), "M") as Total_Manufactured,
concat(round(sum(Rejected_Qty)/1000.0,2), "K") as Total_Rejected
from fact_Production;
-- Q.9) Department-wise Manufacture vs Rejected 
select d.Dept_Name,sum(f.Today_Manufactured_Qty) as Total_Manufactured,
sum(f.Rejected_Qty) as Total_Rejected
from dim_department d
join fact_Production f
on d.Dept_ID=f.Dept_ID
group by d.dept_name;


