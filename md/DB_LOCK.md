# 数据库锁排查



## MySQL
```MySQL
-- 查看死锁（控制台上才能带 \G）
show engine innodb status \G;

-- 查锁表
show OPEN TABLES where In_use > 0;

-- 查进程
show processlist;
```

## Oracle
```
-- 查锁
select t2.USERNAME,
       t2.SID,
       t2.SERIAL#,
       t3.OBJECT_NAME,
       t2.OSUSER,
       t2.MACHINE,
       t2.PROGRAM,
       t2.LOGON_TIME,
       t2.COMMAND,
       t2.LOCKWAIT,
       decode(t1.LOCKED_MODE,
           '1', '1-空',
           '2', '2-行共享(RS)：共享表锁',
           '3', '3-行独占(RX)：用于行的修改',
           '4', '4-共享锁(S)：阻止其他DML操作',
           '5', '5-共享行独占(SRX)：阻止其他事务操作',
           '6', '6-独占(X)：独立访问使用'
           ) AS TYPE_DESCRIPTION,
       t4.SQL_TEXT
from "PUBLIC".V$LOCKED_OBJECT t1
         join "PUBLIC".V$SESSION t2 on t1.SESSION_ID = t2.SID
         join "PUBLIC".DBA_OBJECTS t3 on t1.OBJECT_ID = t3.OBJECT_ID
         left join "PUBLIC".V$SQL t4 on t2.SQL_HASH_VALUE = t4.HASH_VALUE
order by t2.LOGON_TIME;
```

## PostgreSQL
```SQL
-- 查锁
select * from pg_locks
-- 查询被检测到的死锁数量
select * from pg_stat_database
```

http://postgres.cn/docs/12/view-pg-locks.html

http://postgres.cn/docs/12/monitoring-stats.html#PG-STAT-DATABASE-VIEW
