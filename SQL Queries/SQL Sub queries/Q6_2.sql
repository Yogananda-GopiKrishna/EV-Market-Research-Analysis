# 6. List down the compounded annual growth rate (CAGR) in 4-wheeler 
-- units for the top 5 makers from 2022 to 2024. 

with cte1 as (
select maker,sum(electric_vehicles_sold) as ev_sold_2022 from electric_vehicle_sales_by_makers
join dim_date using (date)
where fiscal_year = 2022
and vehicle_category = "4-Wheelers"
group by maker)
, cte2 as (
select maker,sum(electric_vehicles_sold) as ev_sold_2024 from electric_vehicle_sales_by_makers
join dim_date using (date)
where fiscal_year = 2024
and vehicle_category = "4-Wheelers"
group by maker
),
cte3 as (
select maker,sum(electric_vehicles_sold) as ev_sold from electric_vehicle_sales_by_makers
join dim_date using (date)
where vehicle_category = "4-Wheelers"
group by maker
order by ev_sold desc
limit 5)

SELECT 
    cte3.maker,
    cte2.ev_sold_2024,
    cte1.ev_sold_2022,
    (ROUND(POWER((cte2.ev_sold_2024 / cte1.ev_sold_2022),
                    0.5) - 1,
            4))*100 AS CAGR
FROM
    cte1 join cte2 using (maker)
        JOIN
    cte3 USING (maker)
ORDER BY cagr DESC
LIMIT 5;