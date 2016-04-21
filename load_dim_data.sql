##################################################################################
#SCRIPT TO LOAD INITIAL AND TEST DATA
#NOTE: MySql needs ownership of the local server file where csv files are stored
#/var/tmp/mysql_import in this case
#once you 'chown mysql:mysql' with the folder, you can 'chmod g+s /folder' to auto inherit new files that are copied in
##################################################################################

use reporting2;

#truncate table calendar;

LOAD DATA INFILE '/var/tmp/mysql_import/tblCAL.csv'
INTO TABLE calendar
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/tmp/mysql_import/product.csv'
INTO TABLE product
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

#LOAD SAMPLE CUSTOMER LIST
INSERT INTO `customer` (`customer_number`, `customer_name`, `channel`, `region`) VALUES ('1001', 'TARGET', 'RETAIL', 'US');
INSERT INTO `customer` (`customer_number`, `customer_name`, `channel`, `region`) VALUES ('1002', 'BEST BUY', 'RETAIL', 'US');
INSERT INTO `customer` (`customer_number`, `customer_name`, `channel`, `region`) VALUES ('1003', 'WALMART', 'RETAIL', 'US');
INSERT INTO `customer` (`customer_number`, `customer_name`, `channel`, `region`) VALUES ('1004', 'AMAZON', 'ONLINE', 'US');

#LOAD SAMPLE STORE LIST
INSERT INTO `customer_store` (store_number, store_name, customer_id) VALUES (0, 'CHAIN', 1);
INSERT INTO `customer_store` (store_number, store_name, customer_id) VALUES (0, 'CHAIN', 2);
INSERT INTO `customer_store` (store_number, store_name, customer_id) VALUES (0, 'CHAIN', 3);
INSERT INTO `customer_store` (store_number, store_name, customer_id) VALUES (0, 'CHAIN', 4);


LOAD DATA INFILE '/var/tmp/mysql_import/pos_tx_sample.csv'
INTO TABLE fact_pos_actual_stage
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

##Lookup product_id from product table.  Assumes loaded item_lookup with valid SKU, will migrate to vendor_product_lookup table
SET SQL_SAFE_UPDATES=0;
UPDATE fact_pos_actual_stage stg
inner join product dim ON stg.item_lookup = dim.sku
SET stg.product_id = dim.product_id 
WHERE stg.item_lookup = dim.sku;