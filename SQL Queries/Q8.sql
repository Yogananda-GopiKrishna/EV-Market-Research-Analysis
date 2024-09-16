# 8. What are the peak and low season months for EV sales based on the 
-- data from 2022 to 2024? 

SELECT 
    YEAR(DATE_ADD(date, INTERVAL 9 MONTH)) AS year,
    MONTHNAME(date) AS month,
    sum(electric_vehicles_sold) as ev_sales
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date USING (date)
WHERE
    fiscal_year BETWEEN 2022 AND 2024
GROUP BY year,month;