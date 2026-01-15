CREATE OR REPLACE SCHEMA  GOLD;


SELECT * FROM silver.car_sales;

-----------------SALES DAILY --------------------
CREATE OR REPLACE TABLE gold.sales_daily AS
SELECT
    sale_date,
    COUNT(*)                  AS total_sales,
    SUM(final_price)          AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_ticket
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY sale_date
ORDER BY sale_date;

------------------SALES MONTHLY-------------------------
CREATE OR REPLACE TABLE gold.sales_monthly
AS
SELECT
    sale_year,
    sale_month,
    COUNT(*)         AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_ticket
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;



-------------SALES BY CITY ------------
CREATE OR REPLACE TABLE gold.sales_by_city
AS
SELECT
    location_city,
    COUNT(*)          AS total_sales,
    SUM(final_price)  AS total_revenue,
    AVG(final_price)  AS avg_ticket
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY location_city
ORDER BY total_revenue DESC;


SELECT * FROM silver.car_sales;

------ CAR SALES BY CHANNEL--------------

CREATE OR REPLACE TABLE gold.car_sales_by_model AS
SELECT 
    car_brand,
    car_model,
    COUNT(*)         AS total_sales,
    SUM(final_price) AS total_revenue,
    AVG(final_price) AS avg_ticket,
    MAX(final_price) AS max_ticket,
    MIN(final_price) AS min_ticket
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY sale_channel;

-----------CAR SALES BY MODEL--------------
CREATE OR REPLACE TABLE gold.car_sales_by_model AS
SELECT 
    car_brand,
    car_model,
    COUNT(*)         AS total_sales,
    SUM(final_price) AS total_revenue,
    AVG(final_price) AS avg_ticket,
    MAX(final_price) AS max_ticket,
    MIN(final_price) AS min_ticket
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY car_brand, car_model;

-----------------------------

SELECT
    sale_year,
    sale_month,
    AVG(final_price) OVER(
        PARTITION BY sale_year 
        ORDER BY sale_month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS avg_ticket_3_month
FROM silver.car_sales;

------------Monthly Revenue Variation-----------------
CREATE OR REPLACE TABLE gold.monthly_revenue_variation AS
SELECT
    sale_year,
    sale_month,
    SUM(final_price) AS total_revenue,
    SUM(final_price) - LAG(SUM(final_price)) OVER(
        PARTITION BY sale_year ORDER BY sale_month
    ) AS revenue_variation
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;


--------------CAR SALES BY Channel---------------
CREATE OR REPLACE TABLE gold.car_sales_by_channel AS
SELECT 
    sale_channel,
    COUNT(*)         AS total_sales,
    SUM(final_price) AS total_revenue,
    AVG(final_price) AS avg_ticket,
    MAX(final_price) AS 
    MIN(final_price) AS 
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY sale_channel;




SELECT 
    DISTINCT(seller_name)
FROM silver.car_sales;

---------------ranking de faturamento por vendedor.--------------------

CREATE OR REPLACE TABLE gold.seller_ranking AS
SELECT
    seller_name,
    COUNT(*)          AS total_sales,
    SUM(final_price)  AS total_revenue,
    RANK() OVER(ORDER BY SUM(final_price) DESC) AS seller_rank
FROM silver.car_sales
WHERE booking_status = 'Confirmed'
GROUP BY seller_name
ORDER BY seller_rank;


CREATE OR REPLACE TABLE gold.car_sales_clean
AS 
SELECT
    *
FROM silver.car_sales;








