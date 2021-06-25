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

-- 表大小
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT,
       DATA_LENGTH / 1024 / 1024 AS DATA_MB,
       INDEX_LENGTH / 1024 / 1024 AS INDEX_MB,
       (DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024 AS ALL_MB,
       TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA not in ('information_schema', 'performance_schema', 'mysql', 'sys');