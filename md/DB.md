# DB

[TOC]



## 表设计

### 设计表时字段默认`not null`, 减少判空与空指针异常

可空字段必须明确说明原因，否则都必须非空，在特殊情况下程序疏漏可能插入空值，从而导致一系列问题。

可空字段漏了判空会导致空指针异常，需要频繁判空。

当然，在这条规则下写程序时仍需了解数据库字段，可空/非空 与其他字段不同的需要用文档注释标注，
在`SpringMVC`等可以使用`@Validated`的建议注解`@NotNull`

上面提到的两个注解具体路径为
```java
import org.springframework.validation.annotation.Validated
import javax.validation.constraints.NotNull
```


### 大表考虑分区，可以非常简单地提升整个性能


### 开发测试环境的表与字段必须有注释

Oracle
```sql
-- 添加表注释
COMMENT ON TABLE TEST.COMMON_SEQ IS '序号表';

-- 添加列注释
COMMENT ON COLUMN TEST.COMMON_SEQ.APP_CODE IS '应用编码';

-- 查询所有没注释的表
SELECT * FROM SYS.ALL_TAB_COMMENTS WHERE OWNER = '库名' AND COMMENTS IS NULL;

-- 查询所有没注释的列
SELECT * FROM SYS.ALL_COL_COMMENTS WHERE OWNER = '库名' AND COMMENTS IS NULL;
```

MySQL
```MySQL
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
SELECT TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = '库名' AND TABLE_COMMENT = '';

-- 查询所有没注释的列
SELECT TABLE_NAME,COLUMN_NAME, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '库名' AND COLUMN_COMMENT = '';
```

PostgreSQL 类似 Oracle，详见：
[http://postgres.cn/docs/12/sql-comment.html](http://postgres.cn/docs/12/sql-comment.html)
```sql
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
```



## 更新

### 更新与删除操作需在事务下进行，需根据返回的影响条数做回滚等处理

对影响条数的判断可以避免拼接条件组合问题等情况导致全表更新/删除


### 表的 加锁查询/更新 顺序需一致，避免死锁导致性能问题

在类似非分布式系统互相转账的场景中，先锁卡号/账号小的一方


MySQL
```MySQL
-- 查看死锁（控制台上才能带 \G）
show engine innodb status \G;

-- 查锁表
show OPEN TABLES where In_use > 0;

-- 查进程
show processlist;
```

Oracle
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

PostgreSQL
```SQL
-- 查锁
select * from pg_locks
-- 查询被检测到的死锁数量
select * from pg_stat_database
```

[http://postgres.cn/docs/12/view-pg-locks.html](http://postgres.cn/docs/12/view-pg-locks.html)

[http://postgres.cn/docs/12/monitoring-stats.html#PG-STAT-DATABASE-VIEW](http://postgres.cn/docs/12/monitoring-stats.html#PG-STAT-DATABASE-VIEW)



## 查询

### 大规模查询下`WHERE`/`ON`的字段需要命中索引

写数据库语句时看表结构是个好习惯，如果没有命中需注释说明原因。


### MySQL 跟 Oracle/PostgreSQL 不同，行锁须命中索引，没有命中会锁表


### 避免动态`SQL`里出现全表查询

动态`SQL`没有预编译，性能本身就不好，但是在一些表筛选中难免会用到。\
一般系统都会要求某个条件必选，因为有时候用户没有选任何条件就会出现全表查询导致系统卡顿。\
同样在前后端都需要做判断，前端可能漏传错传条件导致触发全表查询，测试环境数据较少可能发现不了问题。


### 带筛选的查询功能刚进入时不要默认查询，除非能保障性能

例如作业执行清单，很多时候进去是要查指定作业，\
如果进去后默认显示最近作业，又没有充分优化，就可能需要卡一会儿


### 数据量大的查询需使用游标查询，并使用流式读，避免 数据库服务器表空间爆满 和 程序(堆)内存不足错误

`OOM: OutOfMemoryError`(堆)内存不足错误，对应`SOF: StackOverflowError`栈溢出错误

xml写法：
```xml
  <!-- fetchSize="-2147483648" 是 流式读 避免 数据库服务器表空间爆满 和 程序堆内存不足错误 -->
  <select id="" fetchSize="-2147483648">
    SELECT * FROM TEST_TABLE
  </select>
```

注解写法：
```java
    /**
     * 调用需要加 @Transactional 注解，否则会立即关闭连接导致游标报 A Cursor is already closed.
     * <br/>fetchSize="-2147483648" 是 流式读 避免 数据库服务器表空间爆满 和 程序堆内存不足错误
     */
    @Options(fetchSize = Integer.MIN_VALUE)
    @Select("SELECT * FROM TEST_TABLE")
    Cursor<Map<String, String>> cursorAllStream();
```



## 插入

### 大规模插入数据时使用批量执行模式

`MySQL`需在连接参数增加`rewriteBatchedStatements=true`

`Oracle`默认支持但不能返回影响条数

`spring`中代码示例：
```java
    @Autowired
    SqlSessionFactory sqlSessionFactory;

    @Test
    public void insert() throws SQLException {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        TestTableMapper mapper = sqlSession.getMapper(TestTableMapper.class);
        long time = System.currentTimeMillis();
        for (int i = 0; i < 1_000_000; i++) {
            mapper.insert(i);
            if (i % 100_000 == 0) {
                sqlSession.commit();
                LOGGER.info("{}", i);
            }
        }
        sqlSession.commit();
        System.out.println(System.currentTimeMillis() - time);
    }
```


### 对表做特殊修改时应做备份，删除表可以用重命名的方式，慎用`TRUNCATE`(因为是`DDL`语句没有事务)

`Oracle`中`insert ... select`需用注释提高性能
```sql
insert ... select /*+ no_merge(p) use_hash(p) */  ...
```

`PostgreSQL`事务可以包含`DML`、`DDL`、`DCL`，可以使用重命名表的方式备份清理表不影响业务



## 通用

### `@Transactional`不能用在`private`方法


### `prepareStatement`从`1`开始而不是`0`开始


### 调用外部服务与持有数据库连接不要放一起，否则调用时间较长时会导致长时间占用连接

而且在`SELECT ... FOR UPDATE`或`UPDATE`后会导致长时间锁表


### 阿里 Druid 连接池即使数据库连接超时释放了，连接池连接没释放也会导致性能问题，必须注意连接的释放

排查方法：
```xml
<!-- 超过时间限制是否回收 -->  
<property name="removeAbandoned" value="true" />  
<!-- 超时时间；单位为秒，180秒=3分钟   -->
<property name="removeAbandonedTimeout" value="180" />  
<!-- removeAbandoned 打印堆栈 -->
<property name="logAbandoned" value="true" />
```
日志里查找 removeAbandoned 找到错误堆栈


