# DB

[TOC]



## 表设计

### 设计表时字段默认`not null`, 减少判空与空指针异常

可空字段必须有明确说明原因，否则都必须非空，在特殊情况下程序疏漏可能插入空值，从而导致一系列问题。

可空字段漏了判空会导致空指针异常，需要频繁判空。

当然，在这条规则下写程序时仍需了解数据库字段，可空/非空 与其他字段不同的需要用文档注释标注，
在`SpringMVC`等可以使用`@Validated`的建议注解`@NotNull`

上面提到的两个注解具体路径为
```java
import org.springframework.validation.annotation.Validated
import javax.validation.constraints.NotNull
```



## 更新

### 更新与删除操作需在事务下进行，需根据返回的影响条数做回滚等处理

对影响条数的判断可以避免拼接条件组合问题等情况导致全表更新/删除



## 查询

### 大规模查询下`WHERE`/`ON`的字段需要命中索引

写数据库语句时看表结构是个好习惯，如果没有命中需注释说明原因


### 对表做特殊修改时应做备份，删除表可以用重命名的方式，慎用`TRUNCATE`(因为是`DDL`语句没有事务)

`Oracle`中`insert ... select`需用注释提高性能
```sql
insert ... select /*+ no_merge(p) use_hash(p) */  ...
```

`PostgreSQL`事务可以包含`DML`、`DDL`、`DCL`，可以使用重命名表的方式备份清理表不影响业务


### 数据量大的查询需使用游标查询，并使用流式读，避免 数据库服务器表空间爆满 和 程序堆内存溢出

`OOM：OutOfMemory`堆内存溢出

xml写法：
```xml
  <!-- fetchSize="-2147483648" 是 流式读 避免 数据库服务器表空间爆满 和 程序堆内存溢出 -->
  <select id="" fetchSize="-2147483648">
    SELECT * FROM TEST_TABLE
  </select>
```

注解写法：
```java
    /**
     * 调用需要加 @Transactional 注解，否则会立即关闭连接导致游标报 A Cursor is already closed.
     * <br/>fetchSize="-2147483648" 是 流式读 避免 数据库服务器表空间爆满 和 程序堆内存溢出
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
