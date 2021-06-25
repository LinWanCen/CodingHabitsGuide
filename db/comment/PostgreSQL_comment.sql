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