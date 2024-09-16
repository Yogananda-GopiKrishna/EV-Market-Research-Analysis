WITH cte AS (
    SELECT 
        state,
        SUM(CASE WHEN fiscal_year = 2022 THEN electric_vehicles_sold ELSE 0 END) AS ev_sold_2022,
        SUM(CASE WHEN fiscal_year = 2022 THEN total_vehicles_sold ELSE 0 END) AS total_sold_2022,
        SUM(CASE WHEN fiscal_year = 2023 THEN electric_vehicles_sold ELSE 0 END) AS ev_sold_2023,
        SUM(CASE WHEN fiscal_year = 2023 THEN total_vehicles_sold ELSE 0 END) AS total_sold_2023,
        SUM(CASE WHEN fiscal_year = 2024 THEN electric_vehicles_sold ELSE 0 END) AS ev_sold_2024,
        SUM(CASE WHEN fiscal_year = 2024 THEN total_vehicles_sold ELSE 0 END) AS total_sold_2024
    FROM 
        electric_vehicle_sales_by_state
    JOIN 
        dim_date USING (date)
    WHERE 
        fiscal_year IN (2022, 2023, 2024)
    GROUP BY 
        state
), cte2 as (
SELECT 
    state,
    (ev_sold_2022 / NULLIF(total_sold_2022, 0)) * 100 AS penetration_rate_2022,
    (ev_sold_2023 / NULLIF(total_sold_2023, 0)) * 100 AS penetration_rate_2023,
    (ev_sold_2024 / NULLIF(total_sold_2024, 0)) * 100 AS penetration_rate_2024
FROM 
    cte
ORDER BY 
    state)
    
select state ,
penetration_rate_2023 - penetration_rate_2022 as diff_23_22,
penetration_rate_2024 - penetration_rate_2023 as diff_24_23,
penetration_rate_2024 - penetration_rate_2022 as diff_24_22
from cte2

