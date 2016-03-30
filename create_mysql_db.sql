#CREATE DATABASE reporting

USE reporting;

CREATE TABLE product
(
item varchar(10) NOT NULL,
item_description varchar(24),
product_h1 varchar(10),
product_h2 varchar(10),
product_h3 varchar(10),
product_h4 varchar(10),
product_attr1 varchar(10),
product_attr2 varchar(10),
product_attr3 varchar(10),
product_attr4 varchar(10),
launch_date date,
eol_date date,
CONSTRAINT pk_product PRIMARY KEY (item)
) engine = innoDB;

CREATE TABLE customer
(
customer_id int(10) unsigned NOT NULL,
customer_name varchar(64) NOT NULL,
channel varchar(10),
address varchar(128),
city varchar(24),
state varchar(2),
zip varchar(10),
region varchar(10),
CONSTRAINT pk_customer PRIMARY KEY (customer_id)
) engine = innoDB;

DROP TABLE calendar;
CREATE TABLE calendar
(
date_id date NOT NULL,
week_start_date date NOT NULL,
week_end_date date,
week_number unsigned int(2),
month_number unsigned int(2),
quarter_number unsigned int(1),
pos_year unsigned int(4),
CONSTRAINT pk_customer PRIMARY KEY (date_id),
INDEX ix_weekly_end_date (week_end_date),
INDEX ix_year_week_end_date (pos_year, week_end_date)
) engine = innoDB;

DROP TABLE transactions_weekly_pos;
CREATE TABLE transactions_weekly_pos
(
   tx_id int not null auto_increment primary key,
   item varchar(10) NOT NULL,
   customer_id int(10) unsigned NOT NULL,
   pos_year int,
   week_end_date date,
   units int,
   sales Decimal(19,4),
   inventory_units int,
   inventory_value Decimal(19,4),
   
   INDEX ix_transactions_weekly_pos_unique (item, customer_id, week_end_date),
   INDEX ix_transactions_weekly_pos_item_cust (item, customer_id),
   INDEX ix_transactions_weekly_pos_item_week (customer_id, week_end_date),
   
   CONSTRAINT fk_txpos_item
   FOREIGN KEY (item)
    REFERENCES product(item)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

   CONSTRAINT fk_txpos_customer_id
   FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

   CONSTRAINT fk_txpos_week
	FOREIGN KEY (week_end_date)
    REFERENCES calendar(week_end_date)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
)ENGINE=InnoDB;

