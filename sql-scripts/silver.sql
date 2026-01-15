CREATE OR REPLACE TABLE silver.car_sales AS
SELECT
    TRY_CAST(sale_id AS STRING) AS sale_id,

    TRY_TO_DATE(sale_date) AS sale_date,
    YEAR(TRY_TO_DATE(sale_date)) AS sale_year,

    /* Mês por extenso */
    CASE 
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 1  THEN 'January'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 2  THEN 'February'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 3  THEN 'March'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 4  THEN 'April'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 5  THEN 'May'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 6  THEN 'June'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 7  THEN 'July'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 8  THEN 'August'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 9  THEN 'September'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 10 THEN 'October'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 11 THEN 'November'
        WHEN MONTH(TRY_TO_DATE(sale_date)) = 12 THEN 'December'
        ELSE 'Invalid date'
    END AS sale_month,

    INITCAP(TRIM(customer_name)) AS customer_name,

    /* Validação de e-mail */
    CASE 
        WHEN customer_email LIKE '%@%.%' THEN LOWER(customer_email)
        ELSE 'N/A'
    END AS customer_email,

    /* Gênero */
    CASE
        WHEN UPPER(customer_gender) IN ('F', 'FEMALE') THEN 'F'
        WHEN UPPER(customer_gender) IN ('M', 'MALE')   THEN 'M'
        ELSE 'N/A'
    END AS customer_gender,


    INITCAP(location_city) AS location_city,
    INITCAP(location_state) AS location_state,

    INITCAP(car_brand) AS car_brand,
    INITCAP(car_model) AS car_model,
    TRY_CAST(car_year AS INTEGER) AS car_year,

    /* Cor do carro */
    CASE 
        WHEN car_color IS NULL OR TRIM(car_color) = '' THEN 'N/A'
        ELSE INITCAP(car_color)
    END AS car_color,

    INITCAP(engine_type) AS engine_type,
    INITCAP(seller_name) AS seller_name,
    INITCAP(sale_channel) AS sale_channel,

    /* Valores */
    TRY_CAST(price AS DECIMAL(10,2)) AS price,
    TRY_CAST(discount_percentage AS FLOAT) AS discount_percentage,
    TRY_CAST(final_price AS DECIMAL(10,2)) AS final_price,

    INITCAP(warranty_plan) AS warranty_plan,
    INITCAP(payment_type) AS payment_type,
    TRY_CAST(num_installments AS INTEGER) AS num_installments,

    INITCAP(booking_status) AS booking_status

FROM bronze.car_sales
WHERE 
    TRY_TO_DATE(sale_date) IS NOT NULL
    AND TRY_CAST(final_price AS DECIMAL(10,2)) IS NOT NULL;







    
