CREATE DEFINER=`root`@`localhost` PROCEDURE `top n penetration states`(
  IN vehicle_category varchar(25),
  IN fiscal_year year,
  IN n tinyint
)
BEGIN
SELECT 
    state,
    SUM(electric_vehicles_sold) as ev_sold,
    SUM(total_vehicles_sold) as total_veh_sold,
   (SUM(electric_vehicles_sold) / SUM(total_vehicles_sold)) AS pentration_rate
FROM
    electric_vehicle_sales_by_state evs
        JOIN
    dim_date d USING (date)
WHERE
    vehicle_category = vehicle_category
        AND fiscal_year = fiscal_year
GROUP BY state
ORDER BY pentration_rate DESC
LIMIT n;

END