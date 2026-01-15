CREATE OR REPLACE STORAGE INTEGRATION gcs_car_sales_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = GCS
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('gcs://meu-bucket-car-sales/');

  

CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL', 'null');


CREATE OR REPLACE STAGE stg_dealership
  URL = '----------storage cloud url--------------'
  STORAGE_INTEGRATION = gcs_car_sales
  FILE_FORMAT = csv_format;


CREATE OR REPLACE TABLE bronze.car_sales (
	sale_id STRING,
	sale_date STRING,
	customer_name STRING,
	customer_email STRING,
	customer_gender STRING,
	location_city STRING,
	location_state STRING,
	car_brand STRING,
	car_model STRING,
	car_year STRING,
	car_color STRING,
	engine_type STRING,
	seller_name STRING,
	sale_channel STRING,
	price STRING,
	discount_percentage STRING,
	final_price STRING,
	warranty_plan STRING,
	payment_type STRING,
	num_installments STRING,
	booking_status STRING
);

COPY INTO bronze.car_sales
FROM @stg_dealership
ON_ERROR = 'CONTINUE';

SELECT * FROM BRONZE.CAR_SALES;


