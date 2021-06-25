prompt 类似 echo, 打印内容
@./batch/create_table.sql;
@./batch/insert_data.sql;
@./batch/update_data.sql;
SELECT trim(COL1) || '  ' || trim(COL2) FROM TEST.TEST_TABLE WHERE COL1 = '1';
exit;