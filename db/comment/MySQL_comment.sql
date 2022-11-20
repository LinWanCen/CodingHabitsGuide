-- 创建时添加注释
CREATE TABLE `db1_table0`
(
    `id`          bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `create_time` datetime(6)     NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
    `update_time` datetime(6)     NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `db1_table1_id_unique_index` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT ='表名';

-- 添加表注释
ALTER TABLE COMMON_SEQ COMMENT '流水号表';

-- 添加列注释
ALTER TABLE COMMON_SEQ MODIFY `APP_CODE` char(6) NOT NULL COMMENT '应用编码';

-- 查询所有没注释的表
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys')  AND TABLE_COMMENT = '';

-- 查询所有没注释的列
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA not in ('information_schema','performance_schema','mysql','sys')  AND COLUMN_COMMENT = '';

-- 表大小
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT,
       DATA_LENGTH / 1024 / 1024 AS DATA_MB,
       INDEX_LENGTH / 1024 / 1024 AS INDEX_MB,
       (DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024 AS ALL_MB,
       TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA not in ('information_schema', 'performance_schema', 'mysql', 'sys');

# 查询列在哪个表与注释
SELECT c.TABLE_SCHEMA, c.TABLE_NAME, t.TABLE_COMMENT, COLUMN_NAME, COLUMN_COMMENT, COLUMN_TYPE, IS_NULLABLE
FROM information_schema.COLUMNS c JOIN information_schema.TABLES t ON t.TABLE_NAME = c.TABLE_NAME  AND t.TABLE_SCHEMA = c.TABLE_SCHEMA WHERE 1=1
# AND c.TABLE_SCHEMA = '数据库名'
 AND c.TABLE_NAME = '表名'
# AND c.COLUMN_NAME = '列名'
# AND c.COLUMN_COMMENT = '列注释'