set echo off
set linesize 2000
set pagesize 0
set trimspool on
set termout off
set feedback off
set verify off
spool &1

SELECT
t1.user_code ||','||
t1.name
FROM cx_user t1;

spool off

exit 0
