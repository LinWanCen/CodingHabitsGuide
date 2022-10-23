echo '<style> table {border-collapse: collapse;}  th, td {border: 1px solid lightgray;padding-left: 5px;padding-right: 5px;}</style><table>' >\
APP_NAME-not_comment_table.html

mysql -h ___IP___ -P 3306 -u 用户名 -p 密码 --default-character-set=utf8mb4_bin -e \
"SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys') AND TABLE_COMMENT = '';"\
| sed 's/\t/<\/td><td>/g; s/^/<tr><td>/; s/$/<\/td><\/tr>/;' >>\
APP_NAME-not_comment_table.html

echo "</table>" >>\
APP_NAME-not_comment_table.html

rows_tb=$((`wc -l < APP_NAME-not_comment_table.html` - 3))
echo $rows_tb