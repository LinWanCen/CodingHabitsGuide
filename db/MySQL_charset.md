# MySQL 避免乱码

### 使用 utf8mb4_bin 以最大兼容各种字符

```mysql
show variables like 'character%';
show variables like 'collation%';
-- 大小写 Case 重音 Accent 不敏感 insensitive 敏感sensitive
-- ci cs ai as
-- bin 敏感二进制且兼容 e é，general_ci 更快，unicode_ci 更准确
```

5.5以上安装后
```sh
vim /etc/mysql/my.cnf

[client]
default-character-set=utf8mb4

[mysqld]
default-storage-engine=INNODB
character-set-server=utf8mb4
collation-server=utf8mb4_bin

/etc/init.d/mysql stop
/etc/init.d/mysql  start
```

```mysql
-- 服务端
set global character_set_server = utf8mb4;
set global character_set_database = utf8mb4;

-- 客户端
set global character_set_client = utf8mb4;
set global character_set_connection = utf8mb4;
set global character_set_results = utf8mb4;

create database if not exists `db1` /*!40100 default character set utf8mb4 collate utf8mb4_bin */;

-- show create table db1_table0;
drop table if exists `db1_table0`;
create table if not exists db1_table0
(
    id          bigint(20) unsigned not null auto_increment comment '自增主键',
    create_time datetime(6)         not null default current_timestamp(6) comment '创建时间',
    update_time datetime(6)         not null default current_timestamp(6) on update current_timestamp(6) comment '更新时间',
    constraint db1_table1_pk primary key (id),
    constraint db1_table1_id_unique_index unique (id)
) engine = InnoDB
  default charset = utf8mb4
  collate = utf8mb4_bin comment ='表名';

-- show create table db1_table1;
drop table if exists `db1_table1`;
create table if not exists db1_table1
(
    id          bigint(20) unsigned not null auto_increment primary key unique comment '自增主键',
    create_time datetime(6)         not null default current_timestamp(6) comment '创建时间',
    update_time datetime(6)         not null default current_timestamp(6) on update current_timestamp(6) comment '更新时间'
) engine = InnoDB
  default charset = utf8mb4
  collate = utf8mb4_bin comment ='表名';

-- show create table db1_table2;
drop table if exists `db1_table2`;
create table if not exists `db1_table2`
(
    `id`          bigint(20) unsigned not null auto_increment comment '自增序号',
    `create_time` datetime(6)         not null default current_timestamp(6) comment '创建时间',
    `update_time` datetime(6)         not null default current_timestamp(6) on update current_timestamp(6) comment '更新时间',
    primary key (`id`),
    unique key `id` (`id`)
) engine = InnoDB
  default charset = utf8mb4
  collate = utf8mb4_bin comment ='表名';
```