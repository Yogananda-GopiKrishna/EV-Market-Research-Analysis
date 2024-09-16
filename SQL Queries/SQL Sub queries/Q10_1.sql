# 10. 
-- Estimate the revenue growth rate of 4-wheeler and 2-wheelers 
-- EVs in India for 2022 vs 2024 and 2023 vs 2024, assuming an average 
-- unit price.
-- 2 wheelers --> 85000 & 4 wheelers ---> 1500000

with cte1 as (
select vehicle_category,
sum(case when vehicle_category = "2-wheelers" then electric_vehicles_sold*85000 else electric_vehicles_sold*1500000 end ) wheeler_ev_sold_2022
from electric_vehicle_sales_by_state join dim_date using (date)
where fiscal_year = 2022
group by vehicle_category),
cte2 as 
(select vehicle_category,
sum(case when vehicle_category = "2-wheelers" then electric_vehicles_sold*85000 else electric_vehicles_sold*1500000 end ) wheeler_ev_sold_2023
from electric_vehicle_sales_by_state join dim_date using (date)
where fiscal_year = 2023
group by vehicle_category),
cte3 as 
(select vehicle_category,
sum(case when vehicle_category = "2-wheelers" then electric_vehicles_sold*85000 else electric_vehicles_sold*1500000 end ) wheeler_ev_sold_2024
from electric_vehicle_sales_by_state join dim_date using (date)
where fiscal_year = 2024
group by vehicle_category)

select vehicle_category,
(wheeler_ev_sold_2024 - wheeler_ev_sold_2022)/wheeler_ev_sold_2022 as 2022_vs_2024,
(wheeler_ev_sold_2024 - wheeler_ev_sold_2023)/wheeler_ev_sold_2023 as 2023_vs_2024
 from cte1
 join cte2 using (vehicle_category)
 join cte3 using (vehicle_category)
 