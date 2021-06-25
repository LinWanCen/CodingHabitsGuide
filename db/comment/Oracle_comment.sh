echo "set echo off" > export_html.sql
echo "set feedback on" >> export_html.sql
echo "set newp none" >> export_html.sql
echo "set pagesize 0" >> export_html.sql
echo "set termout off" >> export_html.sql
echo "set serveroutput off" >> export_html.sql

echo "spool ${WORKSPACE}/库名-not_comment_table.txt" >> export_html.sql
echo "SELECT TABLE_NAME FROM SYS.ALL_TAB_COMMENTS WHERE OWNER = '库名' AND COMMENTS IS NULL;" >> export_html.sql
echo "spool off" >> export_html.sql

echo "spool ${WORKSPACE}/库名-not_comment_column.html" >> export_html.sql
echo "SELECT '<style> table {border-collapse: collapse;}  th, td {border: 1px solid lightgray;padding-left: 5px;padding-right: 5px;}</style><table>'  FROM dual;" >> export_html.sql
echo "SELECT '<tr><td>' || TABLE_NAME || '</td><td>' || COLUMN_NAME || '</td></tr>' FROM SYS.ALL_COL_COMMENTS WHERE OWNER = '库名' AND COMMENTS IS NULL;" >> export_html.sql
echo "SELECT '</table>'  FROM dual;" >> export_html.sql
echo "spool off" >> export_html.sql

sqlplus 用户名/密码@___IP___:1521/SID @export_html.sql