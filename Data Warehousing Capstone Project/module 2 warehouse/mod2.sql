-- Task 5 - Create a grouping sets query
select 
	b.country,
	c.category,
	sum(a.amount) as totalsales
from "FactSales" as a
left join "DimCountry" as b
on a.countryid = b.countryid
left join "DimCategory" as c
on a.categoryid = c.categoryid
group by grouping sets(b.country, c.category, a.amount)
order by sum(a.amount) desc;

-- Task 6 - Create a rollup query
select
	b.Year,
	c.country,
	sum(a.amount) as totalsales
from "FactSales" as a
left join "DimDate" as b
on a.dateid = b.dateid
left join "DimCountry" as c
on a.countryid = c.countryid
group by rollup(b.year, c.country, a.amount)
order by b.year, SUM(a.amount) desc;


-- Task 7 - Create a cube query
select
	b.Year,
	c.country,
	avg(a.amount) as totalsales
from "FactSales" as a
left join "DimDate" as b
on a.dateid = b.dateid
left join "DimCountry" as c
on a.countryid = c.countryid
group by cube(b.year, c.country, a.amount)
order by b.year, avg(a.amount) desc;

-- Task 8 - Create an MQT
create table total_sales_per_country (country, total_sales) as
(select
	b.country
	sum(a.amount) as total_sales
from "FactSales" as a
left join "DimCountry" as b
on a.countryid = b.countryid
group by b.country
)


-- data initially deferred refresh deferred;

-- refresh table total_sales_per_country;


-- DATA INITIALLY DEFERRED REFRESH DEFERRED;

-- refresh table total_sales_per_country;

