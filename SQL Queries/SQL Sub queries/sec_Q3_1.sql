with cte as (select state,
fiscal_year,
sum(electric_vehicles_sold) as ev_sold ,
sum(total_vehicles_sold) as total_veh_sold 
from electric_vehicle_sales_by_state
join dim_date using (date)
where fiscal_year in (2022,2023,2024)
group by state,fiscal_year
order by ev_sold desc)
select 
state,
max(Charging_stations) as charging_stations,
ev_sold as  ev_sold_2022,
ev_sold/ total_veh_sold  as Penetration_rate 
from 
mcs_2022 join cte using (state)
group by state 
order by EV_SOLD_2022 desc
