# 5. How do the EV sales and penetration rates in Delhi compare to Karnataka for 2024? 
SELECT 
    state,
    SUM(electric_vehicles_sold) AS Ev_sales,
    SUM(total_vehicles_sold) as Total_veh_sales,
    (SUM(electric_vehicles_sold) / SUM(total_vehicles_sold)) * 100 AS Penetration_rate
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date d USING (date)
WHERE
    state IN ('delhi' , 'karnataka')
        AND d.fiscal_year = 2024
GROUP BY state
