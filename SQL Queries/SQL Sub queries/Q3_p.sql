# 3. List the states with negative penetration (decline) in EV sales from 2022 to 2024? 

with cte1 as (
select state,sum(electric_vehicles_sold) as ev_sold_2022,sum(total_vehicles_sold) as total_ev_sold_2022
from electric_vehicle_sales_by_state evs 
join dim_date d using(date)
where d.fiscal_year = 2022
group by state),
cte2 as (
select state,sum(electric_vehicles_sold) as ev_sold_2024,sum(total_vehicles_sold) as total_ev_sold_2024
from electric_vehicle_sales_by_state evs 
join dim_date d using(date)
where d.fiscal_year = 2024
group by state)
select 
c2.state ,
c1.ev_sold_2022,
c1.total_ev_sold_2022,
c2.ev_sold_2024,
c2.total_ev_sold_2024,
c2.ev_sold_2024 - c1.ev_sold_2022,
c2.total_ev_sold_2024 - c1.total_ev_sold_2022,
((c2.ev_sold_2024 - c1.ev_sold_2022)/(c2.total_ev_sold_2024 - c1.total_ev_sold_2022)) as pentration_rate
from cte1 c1
join cte2 c2
using (state)