
ALTER TABLE electric_vehicle_sales_by_state
CHANGE COLUMN ï»¿date date TEXT NULL DEFAULT NULL ;

ALTER TABLE electric_vehicle_sales_by_makers
CHANGE COLUMN ï»¿date date TEXT NULL DEFAULT NULL ;

ALTER TABLE dim_date
CHANGE COLUMN ï»¿date date TEXT NULL DEFAULT NULL ;


UPDATE electric_vehicle_sales_by_state
SET date = STR_TO_DATE(date, '%d-%b-%y')
WHERE STR_TO_DATE(date, '%d-%b-%y') IS NOT NULL;

UPDATE electric_vehicle_sales_by_makers
SET date = STR_TO_DATE(date, '%d-%b-%y')
WHERE STR_TO_DATE(date, '%d-%b-%y') IS NOT NULL;

UPDATE dim_date
SET date = STR_TO_DATE(date, '%d-%b-%y')
WHERE STR_TO_DATE(date, '%d-%b-%y') IS NOT NULL;

UPDATE electric_vehicle_sales_by_state
SET state = "Andaman & Nicobar"
WHERE state = "Andaman & Nicobar Island";


