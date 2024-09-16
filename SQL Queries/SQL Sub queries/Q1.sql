# 1. List the top 3 and bottom 3 makers for the fiscal years 2023 and 2024 in terms of the number of 2-wheelers sold.

# Top 3 makers by fiscal_year 2023
SELECT 
    maker, 
    SUM(electric_vehicles_sold) as Ev_sold_2023
FROM
    electric_vehicle_sales_by_makers
        JOIN
    dim_date d USING (date)
WHERE
	vehicle_category = "2-wheelers" and fiscal_year in (2023,2024)
group by maker
order by ev_sold_2023 desc
limit 3;