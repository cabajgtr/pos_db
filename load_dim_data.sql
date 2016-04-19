use reporting2;

truncate table calendar;

LOAD DATA INFILE '/var/tmp/mysql_import/tblCAL.csv'
INTO TABLE calendar
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;