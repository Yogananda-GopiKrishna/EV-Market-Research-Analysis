# 7. List down the top 10 states that had the 
# highest compounded annual growth rate (CAGR) from 2022 to 2024 in total vehicles sold.
with cte1 as (
SELECT 
    state, SUM(total_vehicles_sold) AS total_veh_sold_2022
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date d USING (date)
WHERE
    fiscal_year = 2022
GROUP BY state
),
cte2 as (
SELECT 
    state, SUM(total_vehicles_sold) AS total_veh_sold_2024
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date d USING (date)
WHERE
    fiscal_year = 2024
GROUP BY state)
SELECT 
    state,
    cte1.total_veh_sold_2022,
    cte2.total_veh_sold_2024,
    round((POWER((cte2.total_veh_sold_2024 / cte1.total_veh_sold_2022),
                    0.5) - 1
            ),4) AS CAGR
FROM
    cte1
        JOIN
    cte2 USING (state)
ORDER BY cagr DESC
LIMIT 10;