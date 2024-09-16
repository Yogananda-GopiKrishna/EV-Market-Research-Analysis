WITH cte AS (
    SELECT 
        state,
        fiscal_year,
        vehicle_category,
        SUM(electric_vehicles_sold) AS ev_sold,
        SUM(total_vehicles_sold) AS total_sold
    FROM 
        electric_vehicle_sales_by_state
    JOIN 
        dim_date USING (date)
    WHERE 
        fiscal_year IN (2022, 2023, 2024)
    GROUP BY 
        state, fiscal_year,vehicle_category
),
penetration_rates AS (
    SELECT
        state,
        vehicle_category,
        fiscal_year,
        (ev_sold / total_sold) AS penetration_rate
    FROM
        cte
),
pivoted_penetration AS (
    SELECT
        state,
        MAX(CASE WHEN fiscal_year = 2022 and vehicle_category = "2-wheelers" THEN penetration_rate ELSE NULL END) AS penetration_rate_2022,
        MAX(CASE WHEN fiscal_year = 2023 and vehicle_category = "2-wheelers" THEN penetration_rate ELSE NULL END) AS penetration_rate_2023,
        MAX(CASE WHEN fiscal_year = 2024 and vehicle_category = "2-wheelers" THEN penetration_rate ELSE NULL END) AS penetration_rate_2024
    FROM
        penetration_rates
    GROUP BY
        state
),
states_with_decline AS (
    SELECT 
        state,
        penetration_rate_2022,
        penetration_rate_2023,
        penetration_rate_2024,
        penetration_rate_2023 - penetration_rate_2022 AS change_2022_2023,
        penetration_rate_2024 - penetration_rate_2023 AS change_2023_2024,
        penetration_rate_2024 - penetration_rate_2022 AS change_2022_2024
    FROM 
        pivoted_penetration
)
SELECT 
    state,
    penetration_rate_2022,
    penetration_rate_2023,
    penetration_rate_2024,
    change_2022_2023,
    change_2023_2024,
    change_2022_2024
FROM 
    states_with_decline
where change_2022_2023 < 0 or change_2023_2024 < 0 or change_2022_2024 < 0
ORDER BY 
    change_2022_2024 ASC
