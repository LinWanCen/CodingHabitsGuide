# MySQL 避免乱码

5.5以上安装后
```sh
vim /etc/mysql/my.cnf

[client]
default-character-set=utf8mb4

[mysqld]
default-storage-engine=INNODB
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci

/etc/init.d/mysql stop
/etc/init.d/mysql  start
```

```mysql
show variables like 'character%';
-- 服务端
set global character_set_server=utf8mb4;
set global character_set_database=utf8mb4;

-- 客户端
set global character_set_client=utf8mb4;
set global character_set_connection=utf8mb4;
set global character_set_results=utf8mb4;

create database if not exists `db1` /*!40100 default character set utf8mb4 */;

-- drop table if exists `db1_table1`;
create table if not exists db1_table1
(
  id          bigint unsigned auto_increment comment '自增主键',
  create_time datetime not null              comment '创建时间',
  update_time datetime null                  comment '更新时间',
  constraint db1_table1_pk primary key (id),
  constraint db1_table1_id_unique_index unique (id)
) engine = InnoDB
  default charset = utf8mb4 comment ='表名';

-- 主键用id
create table if not exists db1_table1
(
  id          bigint unsigned auto_increment primary key unique comment '自增主键',
  create_time datetime not null comment '创建时间',
  update_time datetime null comment '更新时间'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='表名';

-- show create table db1_table1;
CREATE TABLE `db1_table1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='表名'
```

### 表前加库名可以方便后人接手

虽然可以在`information_schema.TABLES`查