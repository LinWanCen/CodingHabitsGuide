# 数据库注释整治

## Oracle
```sql
-- 添加表注释
COMMENT ON TABLE TEST.COMMON_SEQ IS '序号表';

-- 添加列注释
COMMENT ON COLUMN TEST.COMMON_SEQ.APP_CODE IS '应用编码';

-- 查询所有没注释的表
SELECT * FROM SYS.ALL_TAB_COMMENTS WHERE OWNER = '库名' AND COMMENTS IS NULL;

-- 查询所有没注释的列
SELECT * FROM SYS.ALL_COL_COMMENTS WHERE OWNER = '库名' AND COMMENTS IS NULL;
```
Jenkins
```shell
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
```


## MySQL
```MySQL
-- 创建时添加注释
CREATE TABLE `COMMON_SEQ`
(
    `APP_CODE` char(6) NOT NULL COMMENT '应用编码',
    UNIQUE KEY `COMMON_SEQ_APP_CODE_uindex` (`APP_CODE`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='流水号表';

-- 添加表注释
ALTER TABLE COMMON_SEQ COMMENT '流水号表';

-- 添加列注释
ALTER TABLE COMMON_SEQ MODIFY `APP_CODE` char(6) NOT NULL COMMENT '应用编码';

-- 查询所有没注释的表
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys')  AND TABLE_COMMENT = '';

-- 查询所有没注释的列
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys')  AND COLUMN_COMMENT = '';
```
Jenkins
```shell
echo '<style> table {border-collapse: collapse;}  th, td {border: 1px solid lightgray;padding-left: 5px;padding-right: 5px;}</style><table>' >\
APP_NAME-not_comment_table.html

mysql -h ___IP___ -P 3306 -u 用户名 -p 密码 -e \
"SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys') AND TABLE_COMMENT = '';"\
| sed 's/\t/<\/td><td>/g; s/^/<tr><td>/; s/$/<\/td><\/tr>/;' >>\
APP_NAME-not_comment_table.html

echo "</table>" >>\
APP_NAME-not_comment_table.html

rows_tb=$((`wc -l < APP_NAME-not_comment_table.html` - 3))
echo $rows_tb
```
```shell
echo '<style> table {border-collapse: collapse;}  th, td {border: 1px solid lightgray;padding-left: 5px;padding-right: 5px;}</style><table>' >\
APP_NAME-not_comment_column.html

mysql -h ___IP___ -P 3306 -u 用户名 -p 密码 -e \
"SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys') AND COLUMN_COMMENT = '';"\
| sed 's/\t/<\/td><td>/g; s/^/<tr><td>/; s/$/<\/td><\/tr>/;' >>\
APP_NAME-not_comment_column.html

echo "</table>" >>\
APP_NAME-not_comment_column.html

rows_col=$((`wc -l < APP_NAME-not_comment_column.html` - 3))
echo $rows_col
```

## PostgreSQL
添加方法类似 Oracle，详见：
http://postgres.cn/docs/12/sql-comment.html
```sql
-- 查询所有没注释的表
SELECT tb.table_name, d.description
FROM information_schema.tables tb
         JOIN pg_class c ON c.relname = tb.table_name
         LEFT JOIN pg_description d ON d.objoid = c.oid AND d.objsubid = '0'
WHERE tb.table_schema = 'test_schema' AND d.description IS NULL;

-- 查询所有没注释的列
SELECT col.table_name, col.column_name, col.ordinal_position AS o, d.description
FROM information_schema.columns col
         JOIN pg_class c ON c.relname = col.table_name
         LEFT JOIN pg_description d ON d.objoid = c.oid AND d.objsubid = col.ordinal_position
WHERE col.table_schema = 'test_schema' AND description IS NULL
ORDER BY col.table_name, col.ordinal_position;
```
