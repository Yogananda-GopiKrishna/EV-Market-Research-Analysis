# 10. 
-- Estimate the revenue growth rate of 4-wheeler and 2-wheelers 
-- EVs in India for 2022 vs 2024 and 2023 vs 2024, assuming an average 
-- unit price.
-- 2 wheelers --> 85000 & 4 wheelers ---> 1500000

with cte1 as (SELECT 
    state,
    SUM(CASE
        WHEN
            fiscal_year = 2022
                AND vehicle_category = '4-wheelers'
        THEN
            electric_vehicles_sold * 1500000
        ELSE NULL
    END) '4_wheel_rev_2022',
    SUM(CASE
        WHEN
            fiscal_year = 2023
                AND vehicle_category = '4-wheelers'
        THEN
            electric_vehicles_sold * 1500000
        ELSE NULL
    END) '4_wheel_rev_2023',
    SUM(CASE
        WHEN
            fiscal_year = 2024
                AND vehicle_category = '4-wheelers'
        THEN
            electric_vehicles_sold * 1500000
        ELSE NULL
    END) '4_wheel_rev_2024',
    SUM(CASE
        WHEN
            fiscal_year = 2022
                AND vehicle_category = '2-wheelers'
        THEN
            electric_vehicles_sold * 85000
        ELSE NULL
    END) '2_wheel_rev_2022',
    SUM(CASE
        WHEN
            fiscal_year = 2023
                AND vehicle_category = '2-wheelers'
        THEN
            electric_vehicles_sold * 85000
        ELSE NULL
    END) '2_wheel_rev_2023',
    SUM(CASE
        WHEN
            fiscal_year = 2024
                AND vehicle_category = '2-wheelers'
        THEN
            electric_vehicles_sold * 85000
        ELSE NULL
    END) '2_wheel_rev_2024'
FROM
    electric_vehicle_sales_by_state
        JOIN
    dim_date USING (date)
WHERE
    fiscal_year IN (2022 , 2023, 2024)
GROUP BY state
)
SELECT 
    state,
    ((2_wheel_rev_2024 - 2_wheel_rev_2022) / 2_wheel_rev_2022) * 100 AS 2_wheel_rev_22vs24,
    ((2_wheel_rev_2024 - 2_wheel_rev_2023) / 2_wheel_rev_2023) * 100 AS 2_wheel_rev_23vs24,
    ((4_wheel_rev_2024 - 4_wheel_rev_2022) / 4_wheel_rev_2022) * 100 AS 4_wheel_rev_22vs24,
    ((4_wheel_rev_2024 - 4_wheel_rev_2023) / 4_wheel_rev_2023) * 100 AS 4_wheel_rev_23vs24
FROM
    cte1
WHERE
    2_wheel_rev_2022 != 0
        AND 2_wheel_rev_2023 != 0
        AND 4_wheel_rev_2022 != 0
        AND 4_wheel_rev_2023 != 0

