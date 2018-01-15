WHENEVER SQLERROR EXIT  FAILURE  ROLLBACK
set serveroutput on

execute cx_log_lib.log_write('TST10',null,'Log','&1',null,0,'Red','1','001','001');

exit

