CREATE DEFINER=`root`@`localhost` PROCEDURE `top n makers`(
in veh_cat varchar(25),
in f_year year,
in limit_n tinyint
)
BEGIN
SELECT 
    maker, 
    SUM(electric_vehicles_sold)/1000 as Ev_sold
FROM
    electric_vehicle_sales_by_makers
        JOIN
    dim_date d USING (date)
WHERE
	vehicle_category = veh_cat and fiscal_year = f_year
group by maker
order by ev_sold desc
limit limit_n;
END