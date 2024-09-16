#2. Identify the top 5 states with the highest penetration rate in 2-wheeler and 4-wheeler EV sales in FY 2024. 

SELECT 
    state,
    SUM(electric_vehicles_sold) as ev_sold,
    SUM(total_vehicles_sold) as total_veh_sold,
    SUM(electric_vehicles_sold) / SUM(total_vehicles_sold)
			AS pentration_rate
FROM
    electric_vehicle_sales_by_state evs
        JOIN
    dim_date d USING (date)
WHERE
    vehicle_category = '4-wheelers'
        AND fiscal_year = 2024
GROUP BY state
ORDER BY pentration_rate DESC
LIMIT 5;