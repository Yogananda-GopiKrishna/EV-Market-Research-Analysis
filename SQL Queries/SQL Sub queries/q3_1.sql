# # 3. List the states with negative penetration (decline) in EV sales from 2022 to 2024? 

with cte as (select state,
(case when fiscal_year = 2022 then (electric_vehicles_sold)/(total_vehicles_sold) else 0 end) "penetration_rate_2022",
(case when fiscal_year = 2023 then (electric_vehicles_sold)/(total_vehicles_sold) else 0 end) "penetration_rate_2023",
(case when fiscal_year = 2024 then (electric_vehicles_sold)/(total_vehicles_sold) else 0 end) "penetration_rate_2024"
from electric_vehicle_sales_by_state
join dim_date using (date)
where fiscal_year in (2022,2023,2024)),
cte2 as (
select
 state ,
 sum(penetration_rate_2022) as pent_rate_2022,
 sum(penetration_rate_2023) as pent_rate_2023,
 sum(penetration_rate_2024) as pent_rate_2024 
 from cte
group by state)

select 
state,
pent_rate_2022,
pent_rate_2023,
pent_rate_2024,
pent_rate_2023-pent_rate_2022,
pent_rate_2024-pent_rate_2023,
pent_rate_2024-pent_rate_2022
from cte2
group by state
order by pent_rate_2024 asc