export TNS_ADMIN=/root/oracle/network/admin
export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/oracle/11.2/client64/lib/
export NLS_LANG=Japanese_Japan.AL32UTF8
export NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS'
#export strSchema=standard_dev10/standard_dev10@orcl
#export strSchema=standard/standard@xe
export strSchema=standard/standard@haier

export YYYY=`date +%Y`
export MM=`date +%m`
export DD=`date +%d`
export HR=`date +%H`
export MN=`date +%M`
export SS=`date +%S`

export strDate=${YYYY}${MM}${DD}${HR}${MN}${SS}

cd `dirname $0`

echo 'start:'`date` >> /tmp/5.txt

sqlplus64 -S -L ${strSchema} @test_Dat1.sql /tmp/user.txt >> /tmp/5.txt

rtn=$?
echo '1.return='$rtn >> /tmp/5.txt

sqlplus64 -L ${strSchema} @test_SP2.sql ${strDate} >> /tmp/5.txt

rtn=$?
echo '2.return='$rtn >> /tmp/5.txt

echo '001,'${strDate} > /tmp/vender.txt

#${ORACLE_HOME}/bin/sqlldr userid=${strSchema} control=vendor.ctl data=/tmp/vendor.txt bad=/tmp/6.bad log=/tmp/6.txt

echo "test" | mail -s "mailtest" nao_machida@cross-docking.com

rtn=$?
echo '3.return='$rtn >> /tmp/5.txt

echo 'end:'`date` >> /tmp/5.txt
