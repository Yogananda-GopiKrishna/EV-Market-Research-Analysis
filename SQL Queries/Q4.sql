# 4. What are the quarterly trends based on sales volume for the top 5 EV makers (4-wheelers) from 2022 to 2024? 

WITH cte_top5_makers AS (
    SELECT 
         maker, 
        SUM(electric_vehicles_sold) AS total_sales_volume
    FROM 
        electric_vehicle_sales_by_makers
    JOIN 
        dim_date d USING(date)
    WHERE 
        vehicle_category = '4-wheelers' 
    GROUP BY 
        maker
    ORDER BY 
        total_sales_volume DESC
    LIMIT 5
),
cte_quarterly_sales AS (
    SELECT 
        maker,
        d.fiscal_year,
        d.quarter,
        SUM(electric_vehicles_sold) AS quarterly_sales_volume
    FROM 
        electric_vehicle_sales_by_makers
    JOIN 
        dim_date d USING(date)
    WHERE 
        vehicle_category = '4-wheelers'
        AND d.fiscal_year in (2022,2023,2024)
    GROUP BY 
        maker, d.fiscal_year, d.quarter
)

SELECT 
    q.maker,
    q.fiscal_year,
    q.quarter,
    q.quarterly_sales_volume
FROM 
    cte_quarterly_sales q
JOIN 
    cte_top5_makers t
ON 
    q.maker = t.maker
ORDER BY 
    q.maker, q.fiscal_year, q.quarter;
