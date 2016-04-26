#NOT YET WORKING PROPERLY
#
select current_timestamp();
truncate table fact_pos_actual;
select * from fact_pos_actual; 

     DROP EVENT IF EXISTS EVENT_TEST;
	 
     CREATE EVENT EVENT_TEST
     ON SCHEDULE EVERY 1 DAY STARTS '2016-04-19 16:50:00'
     DO     
     CALL UPDATE_FACT_POS_ACTUAL();
     
SHOW processlist;
SHOW EVENTS;