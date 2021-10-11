# MySQL explain

官方文档：https://dev.mysql.com/doc/refman/8.0/en/explain-output.html

都是越小越好

| explain       | 说明                     |
| ------------- | ------------------------ |
| id            |                          |
| select_type   | 查询类型                 |
| table         | 表                       |
| partitions    | 分区                     |
| type          | 扫描类型                 |
| possible_keys | 可能索引，包含key        |
| key           | 实际索引                 |
| key_len       | 索引长度                 |
| ref           | 列与索引的比较           |
| rows          | 扫描出的行数(估算的行数) |
| filtered      | 按表条件过滤的行百分比   |
| Extra         | 执行情况的描述和说明     |

## select_type

- SIMPLE
- PRIMARY
- UNION、DEPENDENT UNION、UNION RESULT
- SUBQUERY、DEPENDENT SUBQUERY
- 派生表 DERIVED、DEPENDENT DERIVED
- 物化子查询 MATERIALIZED
- 无法缓存结果子查询 UNCACHEABLE SUBQUERY、UNCACHEABLE UNION

## type

| type            | 说明                       |
| --------------- | -------------------------- |
| NULL            |                            |
| system          | 表只有一行                 |
| const           | 常量                       |
| eq_ref          | 唯一索引                   |
| ref             | 非唯一索引或or<=>          |
| fulltext        |                            |
| ref_or_null     | 可空索引                   |
| index_merge     | 索引合并优化               |
| unique_subquery | 唯一索引 in (select ...)   |
| index_subquery  | 非唯一索引 in (select ...) |
| range           | 索引区间                   |
| index           | 全二级索引（同ALL）        |
| ALL             | 全表                       |

range: =, <>, >, >=, <, <=, IS NULL, <=>, BETWEEN, LIKE, IN()

## Extra

using index 覆盖索引，无需回表查询