echo '<style> table {border-collapse: collapse;}  th, td {border: 1px solid lightgray;padding-left: 5px;padding-right: 5px;}</style><table>' >\
APP_NAME-not_comment_column.html

mysql -h ___IP___ -P 3306 -u 用户名 -p 密码 --default-character-set=utf8 -e \
"SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys') AND COLUMN_COMMENT = '';"\
| sed 's/\t/<\/td><td>/g; s/^/<tr><td>/; s/$/<\/td><\/tr>/;' >>\
APP_NAME-not_comment_column.html

echo "</table>" >>\
APP_NAME-not_comment_column.html

rows_col=$((`wc -l < APP_NAME-not_comment_column.html` - 3))
echo $rows_col