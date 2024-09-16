# 9. What is the projected number of EV sales (including 2-wheelers and 4
-- wheelers) for the top 10 states by penetration rate in 2030, based on the 
-- compounded annual growth rate (CAGR) from previous years?

with cte1 as (
select state ,(sum(electric_vehicles_sold)/sum(total_vehicles_sold))*100 as penetration_rate
 from electric_vehicle_sales_by_state
 join dim_date using (date)
 where vehicle_category in ("2-wheelers","4-wheelers") and fiscal_year in (2022,2023,2024)
 group by state 
 order by penetration_rate desc
 limit 10),
cte2 as (
SELECT 
    state, SUM(electric_vehicles_sold) AS elec_veh_sold_2022
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date d USING (date)
WHERE
    fiscal_year = 2022
GROUP BY state
),
cte3 as (
SELECT 
    state, SUM(electric_vehicles_sold) AS elec_veh_sold_2024
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date d USING (date)
WHERE
    fiscal_year = 2024
GROUP BY state),
cte4 as (
SELECT 
    cte1.state,
    elec_veh_sold_2022,
    elec_veh_sold_2024,
    elec_veh_sold_2024 / cte2.elec_veh_sold_2022,
    POWER((cte3.elec_veh_sold_2024 / cte2.elec_veh_sold_2022),
                    0.5) - 1
             AS CAGR
FROM
    cte2
        JOIN
    cte3 USING (state)
    join 
    cte1 using (state))
    
select 
state,
concat(round(penetration_rate,2),"%") as Penetration_Rate,
CONCAT(round(CAGR*100,2), "%") as CAGR_EV,
concat(round(elec_veh_sold_2024/1000000,2),"M") as elec_veh_sold_2024,
concat(round((power(1 + cagr,6)*elec_veh_sold_2024)/1000000,2),"M") as Estimation_2030,
round((power(1 + cagr,6)*elec_veh_sold_2024)/1000000,2) AS est
from cte4
join cte1 using (state)
order by est desc